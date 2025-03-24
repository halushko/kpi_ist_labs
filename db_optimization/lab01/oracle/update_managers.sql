create or replace PROCEDURE update_managers(n number, s number) AS
  temp_value NUMBER;
BEGIN
  FOR i IN 1..(n / s) LOOP
    FOR j IN 0..(s-1) LOOP
      temp_value := s * (i - 1) + j;
      IF temp_value != 0 AND temp_value != 1 AND temp_value < n THEN
        UPDATE EMPLOYEES SET MANAGER_ID = i WHERE ID = temp_value;
      END IF;
    END LOOP;
  END LOOP;
  COMMIT;
END update_managers;
