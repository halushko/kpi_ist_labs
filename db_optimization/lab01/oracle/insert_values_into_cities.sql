create or replace PROCEDURE insert_values_into_cities AS
   type city_list_t IS VARRAY(10) OF VARCHAR2(40);
   city_list city_list_t := city_list_t('New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix',
                                        'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose');
BEGIN
  FOR i IN 1..100000 LOOP
    INSERT INTO CITIES (name)
    VALUES (city_list(DBMS_RANDOM.VALUE(1, city_list.COUNT)) || ' ' || i);
  END LOOP;
  COMMIT;
END insert_values_into_cities;