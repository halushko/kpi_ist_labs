1. Підключитися до БД
2. Виконати EMPLOYEES.sql
3. Виконати CITIES.sql
4. Виконати insert_values_into_cities.sql
5. Виконати generate_random_phone_number.sql
6. Виконати insert_values_into_cities.sql
7. Виконати запит 
```
begin
    INSERT_VALUES_INTO_CITIES();
    INSERT_VALUES_INTO_EMPLOYEES();
end;
```
8. Виконати запит
```
begin
    UPDATE_MANAGERS(100000, 8);
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