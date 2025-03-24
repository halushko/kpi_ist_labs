-- drop table CITIES;
create table CITIES
(
	id   integer GENERATED ALWAYS AS IDENTITY not null,
	name varchar(40)
);