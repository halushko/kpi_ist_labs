create or replace FUNCTION generate_random_phone_number RETURN VARCHAR2 IS
  pattern VARCHAR2(20) := '515.123.4568';
  result_string VARCHAR2(20) := '';
  random_char CHAR(1);
BEGIN
  FOR i IN 1..LENGTH(pattern) LOOP
    IF SUBSTR(pattern, i, 1) = '.' THEN
      result_string := result_string || '.';
    ELSE
      random_char := TO_CHAR(FLOOR(DBMS_RANDOM.VALUE(0, 10)), 'FM9');
      result_string := result_string || random_char;
    END IF;
  END LOOP;

  RETURN result_string;
END generate_random_phone_number;