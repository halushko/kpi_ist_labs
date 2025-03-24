CREATE OR REPLACE PROCEDURE insert_values_into_employees()
LANGUAGE plpgsql
AS $$
DECLARE
    first_name_list TEXT[] := ARRAY[
        'Steven', 'Lex', 'Sus', 'Alexander', 'Bruce',
        'David', 'Antonio', 'Diego', 'Valli', 'Diana',
        'Nancy', 'Daniel', 'John', 'Ismael', 'Luis',
        'Shelli', 'Eagle', 'Karen', 'Matthew', 'Adam'
    ];
    
    last_name_list TEXT[] := ARRAY[
        'Fripp', 'Weiss', 'Colmenares', 'Himuro', 'Tobias',
        'Baida', 'Khoo', 'Raphaely', 'Popp', 'Urman',
        'Sciarra', 'Chen', 'Faviet', 'Greenberg', 'Lorentz'
    ];
    
    fn TEXT;
    ln TEXT;
    i INT;
    random_index_fn INT;
    random_index_ln INT;
    email TEXT;
    phone TEXT;
    hire_date DATE;
    job_id TEXT;
    salary INT;
    department_id INT;
BEGIN
    FOR i IN 1..100000 LOOP
        -- Generate random indices for first and last names
        random_index_fn := FLOOR(RANDOM() * ARRAY_LENGTH(first_name_list, 1) + 1);
        random_index_ln := FLOOR(RANDOM() * ARRAY_LENGTH(last_name_list, 1) + 1);

        fn := first_name_list[random_index_fn];
        ln := last_name_list[random_index_ln];

        -- Generate email
        email := LOWER(LEFT(fn, 1) || '.' || LEFT(ln, 1) || '.' || i || '@gmail.com');

        -- Generate random phone number (assuming the function exists)
        phone := generate_random_phone_number();

        -- Generate random hire date
        hire_date := TO_DATE(FLOOR(RANDOM() * 31 + 1)::TEXT || '-01-2024', 'DD-MM-YYYY');

        -- Generate random job_id (2 random uppercase letters)
        job_id := CHR(FLOOR(RANDOM() * 26 + 65)::INT) || CHR(FLOOR(RANDOM() * 26 + 65)::INT);

        -- Generate random salary
        salary := FLOOR(RANDOM() * (40000 - 1000) + 1000);

        -- Generate random department_id
        department_id := FLOOR(RANDOM() * 100 + 1);
        
        INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
        VALUES (fn, ln, email, phone, hire_date, job_id, salary, NULL, department_id);
    END LOOP;
    
    COMMIT;
END;
$$;
