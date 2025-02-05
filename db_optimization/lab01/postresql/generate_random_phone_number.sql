CREATE OR REPLACE FUNCTION generate_random_phone_number()
RETURNS TEXT AS $$
DECLARE
    pattern TEXT := '515.123.4568';
    result_string TEXT := '';
    random_char CHAR(1);
    i INT;
BEGIN
    FOR i IN 1..LENGTH(pattern) LOOP
        IF SUBSTRING(pattern FROM i FOR 1) = '.' THEN
            result_string := result_string || '.';
        ELSE
            random_char := CAST(FLOOR(RANDOM() * 10) AS INT)::TEXT;
            result_string := result_string || random_char;
        END IF;
    END LOOP;

    RETURN result_string;
END;
$$ LANGUAGE plpgsql;
