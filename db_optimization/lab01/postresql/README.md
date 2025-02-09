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
begin
    CALL INSERT_VALUES_INTO_CITIES();
    CALL INSERT_VALUES_INTO_EMPLOYEES();
end;
```
8. Виконати запит
```
begin
    CALL UPDATE_MANAGERS(100000, 8);
end;
```
9. Виконати запит для представлення ієрархії
```
SELECT LPAD(' ', (LEVEL-1) * 2) || FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME, level
from EMPLOYEES
start with id = 1
connect by nocycle PRIOR id = MANAGER_ID;
```
10. Кожну дію Ви маєте розуміти і пояснити
