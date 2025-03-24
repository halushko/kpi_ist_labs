create or replace PROCEDURE insert_values_into_employees AS
   type FIRST_NAME_t IS VARRAY(20) OF VARCHAR2(20);
   FIRST_NAME_list FIRST_NAME_t := FIRST_NAME_t('Steven', 'Lex', 'Sus', 'Alexander', 'Bruce',
                                   'David', 'Antonio', 'Diego', 'Valli', 'Diana',
                                    'Nancy', 'Daniel', 'John', 'Ismael', 'Luis',
                                     'Shelli', 'Eagle', 'Karen', 'Matthew', 'Adam');
   type LAST_NAME_t IS VARRAY(15) OF VARCHAR2(25);
   LAST_NAME_list LAST_NAME_t := LAST_NAME_t('Fripp', 'Weiss', 'Colmenares', 'Himuro', 'Tobias',
                    'Baida', 'Khoo', 'Raphaely', 'Popp', 'Urman',
                                'Sciarra', 'Chen', 'Faviet', 'Greenberg', 'Lorentz');
   fn varchar2(20);
   ln varchar2(25);
BEGIN
  FOR i IN 1..100000 LOOP
      fn := FIRST_NAME_list(DBMS_RANDOM.VALUE(1, 20));
      ln := LAST_NAME_list(DBMS_RANDOM.VALUE(1, 15));
    insert into EMPLOYEES(FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
                      HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID)
    VALUES (fn,
            ln,
            SUBSTR(fn, 1, 1) || '.' || SUBSTR(ln, 1, 1) || '.' || i || '@gmail.com',
            GENERATE_RANDOM_PHONE_NUMBER(),
            to_date(FLOOR(DBMS_RANDOM.VALUE(1, 32)) || '-01-2024', 'dd-mm-yyyy'),
            dbms_random.string('u',2),
            floor(DBMS_RANDOM.VALUE(1000, 40000)),
            null,
            floor(DBMS_RANDOM.VALUE(1, 100)));
  END LOOP;
  COMMIT;
END insert_values_into_employees;