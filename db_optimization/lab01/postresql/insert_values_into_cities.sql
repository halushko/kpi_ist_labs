CREATE OR REPLACE PROCEDURE insert_values_into_cities()
LANGUAGE plpgsql
AS $$
DECLARE
    city_list TEXT[] := ARRAY[
        'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix',
        'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose'
    ];
    i INT;
    random_index INT;
BEGIN
    FOR i IN 1..100000 LOOP
        random_index := FLOOR(RANDOM() * ARRAY_LENGTH(city_list, 1) + 1);
        INSERT INTO cities (name)
        VALUES (city_list[random_index] || ' ' || i);
    END LOOP;
    COMMIT;
END;
$$;

ALTER PROCEDURE insert_values_into_cities() OWNER TO halushko;
