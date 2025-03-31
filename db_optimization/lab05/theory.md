# Віртуальне обчислення та збереження даних

Не завжди для роботи з базою даних необхідно зберігати дані фізично. В цій лабораторній роботі можна ознайомитися з іншими механізмами обробки та збереження даних, що дозволяють обчислювати їх динамічно з інших колонок таблиці під час створення рядка або виклику запиту.

Віртуальні дані можна розділити:
- за сутністю: на віртуальні колонки (`... AS ...`) та віртуальні таблиці (`VIEW`/`WITH`);
- за часом існування: на постійні (інформація про існування колонки/таблиці постійно присутня в базі даних) та тимчасові (обчислюється протягом одного запиту і не залишає сліду після нього);
- за механізмом збереження: на незбережувані (`VIRTUAL`) та збережувані (`STORED`/`MATERIALIZED`);

# Частина 1. Віртуальні колонки

Дані у віртуальних колонках не зберігаються користувачем, а обчислюються на основі інших колонок таблиці або незмінних функцій. Основне правило зберігання віртуальних колонок для PostgreSQL - детермінованість, що означає визначеність колонки на основі вхідних даних (інших колонок або функцій), тому використання таких функцій як NOW(), RANDOM() або SELECT неможливий.

Створення віртуальної колонки в PostgreSQL, тільки збережуваної:
```mysql
CREATE TABLE orders (
  price NUMERIC,
  tax NUMERIC,
  total NUMERIC GENERATED ALWAYS AS (price + tax) STORED
);
```

Створити `VIRTUAL` колонку в PostgreSQL - неможливо
```mysql
-- Не спрацює
CREATE TABLE test (
  a INT,
  b INT GENERATED ALWAYS AS (a + 1) VIRTUAL
);
```

Один зі способів, як можна створити додаткову колонку - створити її тимчасово під час формування відповіді. Для цього можна просто використовуючи SELECT додавати нові поля через `...AS...`:
```mysql
SELECT price, tax, (price + tax) AS total FROM orders;
```

Щоб створити незбережувану колонку в MySQL:
```mysql
CREATE TABLE employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(25),
  hire_date DATE,
  full_name VARCHAR(45) 
    AS (first_name || ' ' || last_name) 
    VIRTUAL
);
```

# Частина 2. Віртуальні таблиці — VIEW

Для створення віртуальних таблиць використовується ключове слово `VIEW` що з англійської означає "представлення". Віртуальна таблиця не зберігається в таблиці та не містить власних даних. Простіше кажучи, VIEW є "інтерфейсом" з прихованою логікою та інкапсулює в собі більш складний запит. Під час кожного виклику VIEW відбувається виклик прихованого запиту, тому дані з VIEW завжди є свіжими.

Для створення віртуальної таблиці маємо такий синтаксис в PostgreSQL:
```mysql
CREATE VIEW expensive_orders AS
SELECT * FROM orders WHERE total > 100;
```
Його використання:
```mysql
SELECT * FROM expensive_orders;
```
Насправді, замість виклику expensive_orders викликається запит з orders та `WHERE`.

Модифікація VIEW (через DROP + CREATE):
```mysql
DROP VIEW IF EXISTS expensive_orders;
CREATE VIEW expensive_orders AS
SELECT * FROM orders WHERE price > 50;
```
Також є варіант (тільки в PostgreSQL):
```mysql
CREATE OR REPLACE VIEW high_paid_employees AS
SELECT id, name, salary FROM employees WHERE salary > 60000;
```
Про плюси VIEW: актуальні дані, не займає місця в пам'яті, автоматично оновлюється, підтримує деякі види `UPDATE` `INSERT`. З мінусів: не індексується, повільніший (оскільки має виконати запит).

# Частина 3. Матеріалізовані представлення

Якщо по-простому, `MATERIALIZED VIEW` - це представлення, яке зберігається в пам'яті. Інкапсульований запит виконується тільки на час створення таблиці, наступні виклики VIEW беруть дані зі збережених. 

Створення матеріалізованого представлення не відрізняється сильно від звичайного, окрім ключового слова `MATERIALIZED`:
```mysql
CREATE MATERIALIZED VIEW material_orders AS
SELECT * FROM orders WHERE price > 100;
```
З опису зрозуміло, що з часом дані в збереженій таблиці перестають бути актуальними. Для цього існує окремий запит на оновлення:
```mysql
REFRESH MATERIALIZED VIEW material_orders;
```
Є також 2 способи створення такого представлення - з даними та без. У другому випадку створюється пуста табличка, яку можна наповнити через запит `REFRESH`:
```mysql
CREATE MATERIALIZED VIEW ... WITH NO DATA;
REFRESH MATERIALIZED VIEW ...;
```
Про плюси: значно швидше виконується (оскільки не потрібно виконувати інкапсульований запит), можна накладати індекси. З мінусів: неактуальність, не підтримує жодні запити `UPDATE` або `INSERT`, займає місце в пам'яті.

# Частина 4. Тимчасові таблиці

Тимчасовими називають такі віртуальні таблиці, що існують в межах одного запиту до бази даних. Способів створення є декілька, але ми розглянемо ключове слово `WITH`. Такий спосіб має назву CTE або Common Table Expression.

Використання CTE:
```mysql
WITH high_salary_employees AS (
  SELECT id, first_name, last_name, salary
  FROM employees
  WHERE salary > 50000
)
SELECT * FROM high_salary_employees;
```
Якщо для запиту потрібне використання декількох таблиць, існує такий спосіб вкористання CTE:
```mysql
WITH
  recent_hires AS (
    SELECT id, first_name, hire_date
    FROM employees
    WHERE hire_date > CURRENT_DATE - INTERVAL '1 year'
  ),
  high_salary AS (
    SELECT id, salary FROM employees WHERE salary > 60000
  )
SELECT r.first_name, h.salary
FROM recent_hires r
JOIN high_salary h ON r.id = h.id;
```
