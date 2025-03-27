Будь-ласка, не для кожного Завдання: не виконуйте його по пунктам, не прочитавши спочатку всі пункти до кінця. Інколи може бути що без скріншоту доведеться перероблювати

# Очікувані результати

1. Ви побачите, як накопичуються мертві рядки після UPDATE та DELETE.
2. Ви навчитеся вимірювати ефект VACUUM та VACUUM FULL на розмір таблиці.
3. Ви зможете аналізувати роботу autovacuum, як він працює і вручну його запускати.
4. Ви навчитеся переглядати, як зміни у статистиці впливають на плани виконання запитів.

# Завдання

## 1. Переконайтеся, що autovacuum працює, виконавши:

```postgresql
SHOW autovacuum;
```

Якщо off, увімкніть його через ALTER SYSTEM і перезавантажте PostgreSQL для застосування змін, а потім впевніться що він 'on'

```postgresql
ALTER SYSTEM SET autovacuum = 'on';
SELECT pg_reload_conf();
```

якщо не вийшло після pg_reload_conf() спробуйте бутнути вашу базу - рестарт контейнера, або самої БД, якщо вона у Вас не в контейнері.

Якщо хочете виставити значення за замовчанням, то можете виконати цю команду, а потім перезавантажте БД

```postgresql
ALTER SYSTEM RESET autovacuum;
```

Інші приклади налаштувань автовакууму, що не стосуються лаби, але для цікавості можете подивитися що вони роблять:

```sql
ALTER SYSTEM SET autovacuum_vacuum_threshold = 50;
ALTER SYSTEM SET autovacuum_vacuum_cost_limit = 200;
ALTER SYSTEM SET autovacuum_naptime = '30s';
```

## 2. Створіть тестову таблицю TEST_VACUUM, що має ту саму структуру, що й EMPLOYEES:

```postgresql
CREATE TABLE TEST_VACUUM AS SELECT * FROM EMPLOYEES;
```

## 3. Переконайтеся, що таблиця створена та містить рядки:

```postgresql
SELECT COUNT(*) FROM TEST_VACUUM;
```

## 4. Перевірте кількість “мертвих” рядків перед оновленням:

```postgresql
SELECT relname, n_dead_tup, n_live_tup
FROM pg_stat_all_tables
WHERE relname = 'test_vacuum';
```

## 5. Виконайте масове оновлення даних:

```postgresql
UPDATE TEST_VACUUM SET salary = salary + 100;
```

## 6.1. Знову перевірте кількість "мертвих" рядків

Очікується, що значення n_dead_tup (dead tuples) може або зрости, або не змінитись (тобто залишитись 0).
Чому це можливо?

## 6.2. Виконайте запит із EXPLAIN перед VACUUM:

```postgresql
EXPLAIN ANALYZE SELECT * FROM TEST_VACUUM WHERE salary > 5000;
```

## 7. Виконайте звичайний VACUUM та перевірте ефект:

```postgresql
VACUUM TEST_VACUUM;
```

Потім знову перевірте pg_stat_all_tables.

## 8. Виконайте ANALYZE та перевірте статистику:

```postgresql
VACUUM ANALYZE TEST_VACUUM;
```

## 9. Знову виконайте запит із EXPLAIN після VACUUM:

```postgresql
EXPLAIN ANALYZE SELECT * FROM TEST_VACUUM WHERE salary > 5000;
```

Порівняйте витрати (cost), кількість рядків, використання індексів.

## 10. Перевірте розмір таблиці перед VACUUM FULL:

```postgresql
SELECT pg_size_pretty(pg_total_relation_size('test_vacuum'));
```

## 11. Виконайте VACUUM FULL та перевірте зміни:

```postgresql
VACUUM FULL TEST_VACUUM;
```

## 12. Перевірте розмір таблиці після VACUUM FULL:

```postgresql
SELECT pg_size_pretty(pg_total_relation_size('test_vacuum'));
```

Очікується зменшення розміру таблиці.

## 13. Запустіть багато UPDATE і DELETE, а потім перевірте, чи спрацював autovacuum:

Не забудьте перевірити чи autovacuum включений, якщо ви виключали його на пункті 6.

Наприклад якось так, можливо там помилка і треба інші числа.

```postgresql
UPDATE TEST_VACUUM SET salary = salary + 500 WHERE department_id = 10;
DELETE FROM TEST_VACUUM WHERE salary > 10000;
```

## 14. Чекаємо деякий час (або вручну тригеримо autovacuum):

```postgresql
SELECT now(), last_autovacuum, last_autoanalyze
FROM pg_stat_all_tables
WHERE relname = 'test_vacuum';
```

Якщо autovacuum не спрацював, примусово запустіть його:

```postgresql
VACUUM ANALYZE TEST_VACUUM;
```

Чому він не спрацьовує іноді самостійно? Чи впливає на це запуск мануально вакууму?

# Підготуйте щоб точно знати відповіді

1. Що таке мертві рядки (dead tuples)?
2. Чому PostgreSQL не видаляє одразу оновлені/видалені рядки?
3. У чому різниця між VACUUM, VACUUM FULL і ANALYZE?
4. Як дізнатися, чи працював autovacuum для таблиці?
5. Як VACUUM FULL впливає на продуктивність?
