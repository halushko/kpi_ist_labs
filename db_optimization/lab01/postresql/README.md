# Завдання
1. Підключитися до БД
2. Виконати EMPLOYEES.sql
3. Виконати CITIES.sql
4. Створити процедуру з insert_values_into_cities.sql
5. Створити процедуру з generate_random_phone_number.sql
6. Створити процедуру з insert_values_into_employees.sql
7. Стоврити процедуру з update_managers.sql
8. Виконати наступний запит 
```
DO $$
BEGIN
    CALL INSERT_VALUES_INTO_CITIES();
    CALL INSERT_VALUES_INTO_EMPLOYEES();
END $$;
```
8. Виконати запит
```
DO $$
BEGIN
    CALL UPDATE_MANAGERS(100000, 8);
END $$;
```
9. Виконати запит для представлення ієрархії
```
WITH RECURSIVE employee_tree AS (
  SELECT id, first_name, last_name, manager_id, 1 AS level
  FROM employees
  WHERE id = 1
  
  UNION ALL

  SELECT e.id, e.first_name, e.last_name, e.manager_id, et.level + 1
  FROM employees e
  JOIN employee_tree et ON e.manager_id = et.id
)
SELECT LPAD(' ', (level - 1) * 2) || first_name || ' ' || last_name AS employee_name, level
FROM employee_tree;
```
10. Кожну дію Ви маєте розуміти і пояснити
