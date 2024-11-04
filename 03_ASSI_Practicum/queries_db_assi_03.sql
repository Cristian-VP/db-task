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

-- UPDATE STATEMENT
SELECT id, name FROM COMPANY WHERE address IS NULL;
UPDATE COMPANY SET address = 'Diseminado 4,976' WHERE id = 2;
UPDATE TEACHER SET hire_date = '2018-02-03' WHERE id = 2;
UPDATE TEACHER SET hire_date = '2018-02-03' WHERE id = 1;
UPDATE TEACHER SET hire_date = '2016-10-12' WHERE id = 3;
UPDATE TEACHER SET hire_date = '2020-01-30' WHERE id = 4;

-- DELETE STATEMENT
SELECT phone, LENGTH(COMPANY.phone), id FROM COMPANY WHERE NOT LENGTH(phone) = 9;
DELETE FROM EMPLOYEEPOSITION WHERE company_id = 5;
DELETE FROM COMPANY WHERE id = 5;

-- LIMIT STATEMENT
SELECT name, id FROM STUDENT WHERE email LIKE '%@borjamoll.eu' LIMIT 3;
SELECT title, id AS id_posicion FROM POSITIONS WHERE id > 3;
    -- LIMIT ORDER BY
    SELECT name FROM STUDENT ORDER BY name DESC LIMIT 3;
    SELECT name, salary FROM TEACHER ORDER BY salary, name DESC LIMIT 5;

-- FUNCTIONS
    -- MIN(), MAX ()
    SELECT name, MIN(salary) FROM TEACHER;
    SELECT name AS profesor, MAX(salary) salario_mas_bajo FROM TEACHER;
    SELECT id AS identificativo, name AS profesor, MIN(salary) AS salario_maximo FROM TEACHER GROUP BY id, name ORDER BY salario_maximo;
    -- COUNT()
    SELECT COUNT(salary) AS Nº_Salarios FROM TEACHER;
    SELECT COUNT(DISTINCT salary) AS Nº_Salarios_distintos FROM TEACHER;
    -- SUM()
    SELECT SUM(num_employees) FROM COMPANY;
    SELECT SUM(num_employees) FROM COMPANY WHERE foundation_year > 2010;
    -- AVG()
    SELECT AVG(salary) AS Media_salarial FROM TEACHER;
    SELECT AVG(salary) AS Media_salarial FROM TEACHER WHERE id  BETWEEN 1 AND 5;

-- WILD CHARACTERS
    -- %, _, [], ^, -
    SELECT name FROM COMPANY WHERE address LIKE '%a%';
    SELECT name FROM COMPANY WHERE industry LIKE '_ostelerí_';
    SELECT name FROM COMPANY WHERE industry LIKE '____s';
    SELECT name FROM COMPANY WHERE industry REGEXP '^[AHM]';
    SELECT industry FROM COMPANY WHERE industry REGEXP  '^[D-R]';
    SELECT  name FROM COMPANY WHERE industry LIKE '_o%';

-- IN
SELECT email, id FROM EMPLOYEE WHERE name IN('Jaume Ripoll', 'Rosario Martínez', 'Pedro Sánchez');
SELECT name, id FROM COMPANY WHERE num_employees  IN(20, 100, 500);
    -- NOT IN
    SELECT phone, id FROM EMPLOYEE WHERE name NOT IN ('Pedro Sánchez', 'Clara Muñoz', 'Sofía Hernández');
    -- IN (SELECT)
    SELECT email, id FROM EMPLOYEE WHERE id IN (SELECT id FROM COMPANY WHERE foundation_year > 2005);
    -- NOT IN (SELECT)
    SELECT employee_position_id, employee_id FROM EMPLOYEEPOSITION WHERE company_id NOT IN (SELECT id FROM COMPANY WHERE num_employees > 100 );

-- BETWEEN
    -- numbers
    SELECT name FROM STUDENT WHERE id BETWEEN 5 AND 4;
    -- strings
    SELECT email FROM STUDENT WHERE name  BETWEEN 'Abimael Sánchez' AND 'Luis Sagrario';
    -- dates
    SELECT name FROM TEACHER WHERE hire_date BETWEEN  '2018-01-01' AND '2020-12-30';

-- AS
    SELECT id AS Identificador_profesor FROM TEACHER ORDER BY id;
    SELECT id  Identificador_profesor FROM TEACHER ORDER BY id;
    SELECT id AS "Identificador_profesor" FROM TEACHER ORDER BY id;
    SELECT id AS 'Identificador_profesor' FROM TEACHER ORDER BY id;

-- JOIN
    -- INNER JOIN
    SELECT EMPLOYEEPOSITION.employee_id, COMPANY.name FROM EMPLOYEEPOSITION
        INNER JOIN COMPANY ON EMPLOYEEPOSITION.company_id = COMPANY.id;
    -- LEFT JOIN
    SELECT STUDENT.name AS Estudiante, TEACHER.name AS Tutor, TEACHER.email AS Mail_tutor FROM STUDENT
        LEFT JOIN TEACHER ON STUDENT.teacher_id = TEACHER.id;
    SELECT POSITIONS.title AS Posicion, EMPLOYEE.name AS Empleado FROM POSITIONS
        LEFT JOIN EMPLOYEEPOSITION ON POSITIONS.id = EMPLOYEEPOSITION.employee_position_id
        LEFT JOIN EMPLOYEE ON EMPLOYEEPOSITION.employee_id = EMPLOYEE.id ;
    -- RIGHT JOIN
    SELECT POSITIONS.title AS Posicion, EMPLOYEE.name AS Empleado FROM POSITIONS
        RIGHT JOIN EMPLOYEEPOSITION ON POSITIONS.id = EMPLOYEEPOSITION.employee_position_id
        RIGHT JOIN EMPLOYEE ON EMPLOYEEPOSITION.employee_id = EMPLOYEE.id ;
    SELECT COMPANY.name AS COMPANIA, EMPLOYEE.name AS Empleado FROM COMPANY
        RIGHT JOIN EMPLOYEEPOSITION ON COMPANY.id = EMPLOYEEPOSITION.company_id
        RIGHT JOIN EMPLOYEE ON EMPLOYEEPOSITION.employee_id = EMPLOYEE.id;

-- UNION
SELECT name AS Nombre FROM TEACHER WHERE salary > 20000
UNION
SELECT name AS Nombre FROM STUDENT WHERE enrollment_date > '2018-01-01';
    -- UNION ALL
    SELECT email AS Correo FROM TEACHER
    UNION ALL
    SELECT email AS Correo FROM STUDENT;

-- GROUP BY
SELECT COMPANY.name AS COMPANIA, EMPLOYEE.name AS Empleado FROM COMPANY
RIGHT JOIN EMPLOYEEPOSITION ON COMPANY.id = EMPLOYEEPOSITION.company_id
RIGHT JOIN EMPLOYEE ON EMPLOYEEPOSITION.employee_id = EMPLOYEE.id
ORDER BY COMPANY.name, EMPLOYEE.name DESC;
    -- SUM()
    SELECT subject, SUM(salary) AS Total_Salario FROM TEACHER GROUP BY subject;
    -- AVG ()
    SELECT
    subject, AVG(salary) AS Salario_Promedio FROM TEACHER GROUP BY subject;
    -- COUNT ()
    SELECT TEACHER.name AS Tutor, COUNT(STUDENT.id) AS Total_Estudiantes FROM TEACHER
    LEFT JOIN STUDENT ON TEACHER.id = STUDENT.teacher_id
    GROUP BY TEACHER.name;
    -- MAX ()
    SELECT subject, MAX(salary) AS Salario_Maximo FROM TEACHER GROUP BY subject;
    -- MIN ()
    SELECT subject, MIN(salary) AS Salario_Minimo FROM TEACHER GROUP BY subject;