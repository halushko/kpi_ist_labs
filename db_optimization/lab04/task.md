# Частина 1. Хінти без pg_hint_plan (непрямий вплив)
## 1.1. Аналіз плану виконання
Отримайте план цього запиту:
```postgresql
SELECT * FROM employees WHERE salary > 10000;
```
## 1.2. Вплив через вимкнення типів сканування
Виконайте і після цього оцініть план запиту з пункту 1.1:
```postgresql
SET enable_seqscan = off;
```
Але дана команда може не одразу вимкнути `Sequence scan`, тобто при виконанні плану запиту з пункту 1.1 все ще буде використовуватися `Sequence scan`, але при цьому дуже сильно зросте `Total cost`, тому для повного вимкнення `Sequence scan` іноді потрібно перезапустити БД (у `Docker` або через служби, якщо використовується локальна бд) і після перезапуску знову виконати дану команду.
## 1.3. Зміна параметрів cost
Виконайте і після цього оцініть план запиту з пункту 1.1:
```postgresql
SET random_page_cost = 1.0;
SET seq_page_cost = 10.0;
```

# Частина 2. Прямі хінти з pg_hint_plan
Якщо pg_hint_plan не встановлено — встановіть і активуйте розширення. Можна використати Docker image з попередньо встановленим pg_hint_plan [exteded-postgres](https://hub.docker.com/r/postgresai/extended-postgres).

```postgresql
CREATE EXTENSION IF NOT EXISTS pg_hint_plan;
--CREATE EXTENSION pg_hint_plan;
```

Перед запуском запитів з хінтами, виконайте завантаження розширення і включіть відладку:
```postgresql
LOAD 'pg_hint_plan';

SET pg_hint_plan.enable_hint TO on;

SET pg_hint_plan.enable_hint_table TO ON;

SET pg_hint_plan.debug_print = on;
```
`enable_hint`: вмикає/вимикає обробку хінтів у запитах,
`enable_hint_table`: дозволяє задавати хінти через спеціальну таблицю,
`debug_print` потрібен для того, щоб у вікні `Output` з'являлись повідомлення про обробку хінтів — якщо хінт написаний з помилками, або не застосований, це буде видно у повідомленні у вікні `Output`.

## 2.1. Хінт IndexScan
Створіть індекс, якщо ще не створено. Або використайте інший індекс:
```postgresql
CREATE INDEX idx_employees_salary ON employees(salary);
```
Оцініть план з хінтом і без нього:
```postgresql
/*+ IndexScan(employees idx_employees_salary) */
SELECT * FROM employees WHERE salary > 10000;
```
У деяких випадках хінт може не працювати, якщо він записаний окремо від запиту, оскільки PostgreSQL може просто ігнорувати його як звичайний коментар. Тому хінт треба записати безпосередньо всередині запиту, щоб він був правильно зчитаний оптимізатором PostgreSQL. Це може залежати від середовища розробки (IDE), яке визначає, який синтаксис сприймається коректно. Наприклад, даний хінт спрацювує у `DBeaver`, але не працює у `DataGrip`:
```postgresql
/*+ IndexScan(employees idx_employees_salary) */
explain analyze SELECT FROM employees WHERE employees.salary > 10000;
```
При цьому, хінт записаний безспосередньо в запиті, виконується і в `DataGrip`:
```postgresql
SELECT /*+ IndexScan(employees idx_employees_salary) */ * FROM employees WHERE salary > 10000;
```
## 2.2. JOIN з хінтами
Оцініть план для запиту:
```postgresql
SELECT *
FROM employees e
JOIN cities c ON c.id = e.city_id
WHERE e.salary > 10000;
```
Додайте почергово хінти та порівняйте ці три плани
```postgresql
/*+ HashJoin(e c) */
SELECT ...

/*+ NestLoop(e c) */
SELECT ...
```
Підказка: для коректної роботи `NestLoop` варто створити індекси на полях, які використовуються для з’єднання. Наприклад:
```postgresql
CREATE INDEX idx_employees_city_id ON employees(city_id);
CREATE INDEX idx_cities_id ON cities(id);
```
## Частина 3. Додатковий аналіз
##  3.1. Перевірка статистики
Гляньте що всередині. Зверніть увагу на стовпчики `idx_scan` та `last_idx_scan`:
```postgresql
SELECT * FROM pg_stat_user_indexes WHERE relname = 'employees';
```
## 3.2. Непрацюючий хінт для IndexOnlyScan
Гляньте план запиту:
```postgresql
/*+ IndexOnlyScan(employees idx_employees_salary) */
SELECT * FROM employees ORDER BY salary;
```
Розкажіть чому навіть з хінтом операція IndexOnlyScan не виконується.

## Частина 4. Додаткове завдання "на 5"
Без цього завдання ви можете отримати максимум 4 бали з 5ти.

З таблиці прикладів хінтів знайдіть ці хінти, самостійно придумайте запити що покажуть доцільність використання цих хінтів 
1. `OR → UNION ALL` - продемонструйте коли доцільно зробити UNION на прикладі
2. `Leading((t1 t2))` - продемонструйте як працює Leading на прикладі
3. `Rows(t1 t2 #100)` - використайте, як варіант, з FunctionScan. Продемонструйте як воно впливає на план запиту на прикладі з JOIN  
4. `work_mem` - гляньте в теорії. Змусьте БД використовувати “external merge” або “disk-based hash” 

