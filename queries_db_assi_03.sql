-- SELECT STATEMENT
SELECT name, industry FROM COMPANY;

-- SELECT DISTINCT STATEMENT
SELECT DISTINCT name FROM TEACHER;

-- COUNT(DISTINCT) STATEMENT
SELECT COUNT(DISTINCT name) AS  Numero_profesores FROM TEACHER ;

-- WHERE STATEMENT numeric value
SELECT employee_id AS Id_empleado FROM EMPLOYEEPOSITION WHERE EMPLOYEEPOSITION.employee_position_id = 2;
    -- String value
    SELECT teacher_id AS Student_asociate FROM STUDENT WHERE name = 'Rosario Martínez';
    -- Operators filters >, <, <>, =, >=, <=
    SELECT name AS Student_asociate FROM STUDENT WHERE teacher_id <> 0;
    SELECT name AS Student_asociate FROM STUDENT WHERE teacher_id > 9;
    SELECT name AS Student_asociate FROM STUDENT WHERE teacher_id < 9;
    SELECT name AS Student_asociate FROM STUDENT WHERE teacher_id <= 9;
    SELECT name AS Student_asociate FROM STUDENT WHERE teacher_id >= 9;
    -- IN, BETWEEN, LIKE
    SELECT * FROM COMPANY WHERE foundation_year BETWEEN  2005 AND 2021;
    SELECT * FROM COMPANY WHERE foundation_year IN  (2005,2021);
    SELECT * FROM COMPANY WHERE name LIKE 'A%';
    -- AND, OR OPERATOR
    SELECT title FROM POSITIONS WHERE id BETWEEN 1 AND 5 AND title LIKE 'A%a';
    SELECT title FROM POSITIONS WHERE id BETWEEN 1 AND 5 OR title LIKE 'A%a';
    SELECT title FROM POSITIONS WHERE title LIKE '%c%' OR title LIKE '%z';
    SELECT title FROM POSITIONS WHERE id BETWEEN 2 AND 5 AND title LIKE 'A%a' OR title LIKE '%b%';
    -- NOT, NULL OPERATOR
    SELECT address FROM COMPANY WHERE address IS NOT NULL;
    SELECT name FROM COMPANY WHERE address IS NULL;
    SELECT foundation_year FROM COMPANY WHERE name NOT LIKE 'A%' AND id NOT BETWEEN 1 AND 5;
    SELECT phone AS telefono_empresa, name AS nombre_empresa FROM COMPANY WHERE NOT foundation_year < 2002;


-- ORDER BY STATEMENT
    -- ORDERN ALFABÉTICO (A-Z) y (Z-A)
    SELECT * FROM TEACHER ORDER BY name;
    SELECT * FROM TEACHER ORDER BY name DESC;
    -- ASCENDENTE Y DESCENDENTE
    SELECT * FROM TEACHER ORDER BY salary;
    SELECT * FROM TEACHER ORDER BY salary DESC;
    -- CONSIDERANDO DOS COlUMNAS
    SELECT * FROM TEACHER ORDER BY salary, name;
    -- ASC y DESC
    SELECT * FROM TEACHER ORDER BY salary DESC, name DESC;

-- UPDATE
SELECT id, name FROM COMPANY WHERE address IS NULL;
UPDATE COMPANY SET address = 'Diseminado 4,976' WHERE id = 2;

-- DELETE
SELECT phone, LENGTH(COMPANY.phone), id FROM COMPANY WHERE NOT LENGTH(phone) = 9;
DELETE FROM EMPLOYEEPOSITION WHERE company_id = 5;
DELETE FROM COMPANY WHERE id = 5;

