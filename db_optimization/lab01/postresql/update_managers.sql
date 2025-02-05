CREATE OR REPLACE PROCEDURE update_managers(n INT, s INT)
LANGUAGE plpgsql
AS $$
DECLARE
    temp_value INT;
    i INT;
    j INT;
BEGIN
    FOR i IN 1..(n / s) LOOP
        FOR j IN 0..(s-1) LOOP
            temp_value := s * (i - 1) + j;
            IF temp_value != 0 AND temp_value != 1 AND temp_value < n THEN
                UPDATE employees
                SET manager_id = i
                WHERE id = temp_value;
            END IF;
        END LOOP;
    END LOOP;
    COMMIT;
END;
$$;
