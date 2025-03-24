-- drop table CITIES;
create table CITIES
(
	id   number GENERATED ALWAYS AS IDENTITY not null,
	name VARCHAR2(40)
);