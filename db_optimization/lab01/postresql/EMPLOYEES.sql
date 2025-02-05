-- drop table EMPLOYEES;
create table EMPLOYEES
(
  id             integer GENERATED ALWAYS AS IDENTITY,
  first_name     VARCHAR(20),
  last_name      VARCHAR(25),
  email          VARCHAR(25),
  phone_number   VARCHAR(20),
  hire_date      DATE,
  job_id         VARCHAR(10),
  salary         integer,
  manager_id     integer,
  department_id  integer
);

alter table EMPLOYEES
  add constraint EMP_EMP_ID_PK primary key (ID);
alter table EMPLOYEES
  add constraint EMP_EMAIL_UK unique (EMAIL);
alter table EMPLOYEES
  add constraint EMP_MANAGER_FK foreign key (MANAGER_ID)
  references EMPLOYEES (ID);
-- Create/Recreate check constraints
alter table EMPLOYEES
  add constraint EMP_EMAIL_NN
  check (EMAIL IS NOT NULL);
alter table EMPLOYEES
  add constraint EMP_HIRE_DATE_NN
  check (HIRE_DATE IS NOT NULL);
alter table EMPLOYEES
  add constraint EMP_JOB_NN
  check (JOB_ID IS NOT NULL);
alter table EMPLOYEES
  add constraint EMP_LAST_NAME_NN
  check (LAST_NAME IS NOT NULL);
alter table EMPLOYEES
  add constraint EMP_SALARY_MIN
  check (salary > 0);