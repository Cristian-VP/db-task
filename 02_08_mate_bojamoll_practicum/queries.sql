/*
JOIN
1- Muestra el nombre y apellido de los estudiantes junto con el nombre de su empresa, obteniendo solo aquellos estudiantes que están relacionados con una empresa.
2- Obtén una lista de todos los empleados con su nombre, apellido y nombre de la empresa, pero solo aquellos empleados que están asignados a un estudiante.
3- Muestra el nombre de los estudiantes, su email, el nombre de su maestro y el nombre de la empresa en la que trabaja su empleado correspondiente.
*/
-- 1
SELECT CONCAT(Student.name, ' ', Student.surname) AS DATOS_ESTUDIANE, Company.name
FROM Student
JOIN Employee ON Student.employee_id = Employee.id
JOIN Company ON Employee.company_id = Company.id;
-- 2
SELECT Employee.name, Employee.surname, Company.name
FROM Employee
JOIN Company ON Employee.company_id = Company.id;
-- 3
SELECT Student.name, Student.email, Teacher.name, Company.name
FROM Student, Teacher, Company, Employee
WHERE Student.id = Teacher.id AND Student.id = employee_id AND Employee.id = Company.id;
-- FIN JOIN

/*
LEFT JOIN
1- Obtén una lista de todos los estudiantes con sus nombres, apellidos y el teléfono de contacto, y también muestra la empresa de la que cada estudiante es asociado (incluyendo a los estudiantes que no tienen asignada una empresa).
2- Muestra todos los empleados junto con su nombre, apellido y teléfono, y si están asociados con algún estudiante (incluye todos los empleados, incluso aquellos sin asignación de estudiante).
3- Realiza una consulta para obtener los nombres de todos los profesores y los nombres de los estudiantes que están bajo su tutela, mostrando también a los profesores sin estudiantes.
 */
-- 1
SELECT Student.name, Student.surname, Student.phone, Company.name
FROM Student
LEFT JOIN Employee ON Student.employee_id = Employee.id
LEFT JOIN Company ON Employee.company_id = Company.id;
-- 2
SELECT Employee.name, Employee.surname, Employee.phone, Student.name
FROM Student
LEFT JOIN Employee ON Employee.id = Student.employee_id;
-- 3
SELECT Teacher.name, Student.name
FROM Student
LEFT JOIN Teacher ON Teacher.id = Student.id;
-- FIN LEFT JOIN

/*
RIGHT JOIN

1- Realiza una consulta para obtener una lista de todos los empleados con su nombre y apellido, y muestra también el nombre de los estudiantes asociados a estos empleados (incluye todos los empleados, aunque no tengan estudiantes asignados).
2- Muestra una lista de todos los empleados, junto con su empresa y los nombres de los estudiantes asociados a esos empleados (incluso si el empleado no está asignado a ningún estudiante).
3- Obtén una lista de todas las empresas con el nombre de los empleados y los estudiantes asociados a estas empresas, mostrando a todas las empresas aunque no tengan estudiantes.
 */
-- 1
SELECT Employee.name, Employee.surname, Student.name
FROM Student
RIGHT JOIN Employee ON Student.employee_id = Employee.id;
-- 2
SELECT Employee.name, Company.name, Student.name
FROM Student
RIGHT JOIN Employee ON Student.employee_id = Employee.id
RIGHT JOIN Company ON Employee.company_id = Company.id;
-- 3
SELECT Company.name, Employee.name, Student.name
FROM Company
RIGHT JOIN Employee ON Company.id = Employee.company_id
RIGHT JOIN Student ON Student.employee_id =  Employee.id;
-- FIN RIGHT JOIN

/*
FULL JOIN

1- Realiza una consulta para obtener una lista completa de todos los estudiantes junto con el nombre de su profesor y el nombre de la empresa, incluyendo estudiantes sin asignación de empresa o profesor.
2- Muestra una lista completa de todas las empresas y los estudiantes asociados a ellas, mostrando también empresas que no tienen estudiantes asignados y estudiantes sin empresa.
3- Obtén todos los empleados y su empresa, junto con los estudiantes asociados a esos empleados, mostrando empleados sin estudiantes y estudiantes sin empleados.
*/
-- 1
SELECT Student.name, Teacher.name, Company.name
FROM Student
LEFT JOIN Teacher ON Student.teacher_id = Teacher.id
LEFT JOIN Employee ON  Student.employee_id = Employee.id
LEFT JOIN Company ON Employee.company_id = Company.id
UNION
SELECT Student.name, Teacher.name,Company.name
FROM Student
RIGHT JOIN Teacher ON Student.teacher_id = Teacher.id
RIGHT JOIN Employee ON  Student.employee_id = Employee.id
RIGHT JOIN Company ON Employee.company_id = Company.id;
-- 2
SELECT Company.name, Student.name
FROM Student
LEFT JOIN Employee ON Student.employee_id = Employee.id
LEFT JOIN Company ON Employee.company_id = Company.id
UNION
SELECT Company.name, Student.name
FROM Student
RIGHT JOIN Employee ON Student.employee_id = Employee.id
RIGHT JOIN Company ON Employee.company_id = Company.id;
-- 3
SELECT Employee.name, Company.name, Student.name
FROM Employee
LEFT JOIN Company ON Employee.company_id = Company.id
LEFT JOIN Student ON Employee.id = Student.employee_id
UNION
SELECT Employee.name, Company.name, Student.name
FROM Student
RIGHT JOIN Employee ON Student.employee_id = Employee.id
RIGHT JOIN Company ON Employee.company_id = Company.id;
-- FIN FULL JOIN

/*
GROUP BY
1- Realiza una consulta que muestre cuántos empleados hay por cada empresa, agrupados por nombre de la empresa.
2- Calcula cuántos estudiantes están asignados a empleados de cada empresa, agrupados por el nombre de la empresa.
3- Obtén el total de empleados de cada empresa y el promedio de estudiantes asociados a cada uno de ellos, agrupando por nombre de empresa.
 */
-- 1
SELECT COUNT(Employee.id) AS Numero_empleados, Company.name
FROM Employee
JOIN Company ON Employee.company_id = Company.id
GROUP BY Company.name;
-- 2
SELECT COUNT(Student.id) AS Numero_estudiantes, Company.name
FROM Student
JOIN Employee ON Student.employee_id = Employee.id
JOIN Company ON Employee.company_id = Company.id
GROUP BY Company.name;
-- 3
SELECT Company.name, COUNT(Employee.id) AS Total_empleados, AVG(suma_estudiantes) AS Media_estudiantes_empleados
FROM Company
LEFT JOIN Employee ON Company.id = Employee.company_id
LEFT JOIN (
    SELECT employee_id, COUNT(id) AS suma_estudiantes
    FROM Student
    GROUP BY employee_id
) AS estudiantes_summario ON Employee.id = estudiantes_summario.employee_id
GROUP BY Company.name;
-- FIN GROUP BY

-- HAVING
SELECT
    company_id,
    COUNT(*) AS num_empleados
FROM
    Employee
GROUP BY
    company_id
HAVING
    COUNT(*) > 2;
-- ---------------------------------------------------------
SELECT
    teacher_id,
    COUNT(*) AS num_estudiantes
FROM
    Student
GROUP BY
    teacher_id
HAVING
    COUNT(*) > 2;
-- ---------------------------------------------------------
SELECT
    Company.id,
    Company.name,
    COUNT(Employee.id) AS num_empleados
FROM
    Company
LEFT JOIN
    Employee
ON
    Company.id = Employee.company_id
GROUP BY
    Company.id
HAVING
    COUNT(Employee.id) > 1;
-- EXISTS
SELECT
    *
FROM
    Student
WHERE
    EXISTS (
        SELECT
            1
        FROM
            Teacher
        WHERE
            Teacher.id = Student.teacher_id
    );
-- ---------------------------------------------------------
SELECT
    *
FROM
    Employee
WHERE
    EXISTS (
        SELECT
            1
        FROM
            Student
        WHERE
            Student.employee_id = Employee.id
    );
-- ---------------------------------------------------------
SELECT
    *
FROM
    Student
WHERE
    EXISTS (
        SELECT
            1
        FROM
            Employee
        WHERE
            Employee.id = Student.employee_id
            AND Employee.company_id IS NOT NULL
    );
-- ANY
SELECT
    *
FROM
    Employee
WHERE
    company_id = ANY (
        SELECT
            company_id
        FROM
            Employee
        GROUP BY
            company_id
        HAVING
            COUNT(*) > 2
    );
-- ---------------------------------------------------------
SELECT
    *
FROM
    Student
WHERE
    teacher_id = ANY (
        SELECT
            id
        FROM
            Teacher
        WHERE
            id > 2
    );
-- ---------------------------------------------------------
SELECT
    *
FROM
    Student
WHERE
    employee_id = ANY (
        SELECT
            id
        FROM
            Employee
        WHERE
            company_id > 3
    );
-- CASE
SELECT
    name,
    surname,
    email,
    CASE
        WHEN phone IS NOT NULL THEN 'Activo'
        ELSE 'Inactivo'
    END AS estado
FROM
    Employee;
-- ---------------------------------------------------------
SELECT
    Student.name,
    Student.surname,
    Student.email,
    CASE
        WHEN Employee.company_id IS NOT NULL THEN
            (SELECT name FROM Company WHERE Company.id = Employee.company_id)
        ELSE 'Sin empresa'
    END AS empresa_asignada
FROM
    Student
LEFT JOIN
    Employee
ON
    Student.employee_id = Employee.id;
-- ---------------------------------------------------------
SELECT
    Teacher.name,
    Teacher.surname,
    Teacher.email,
    CASE
        WHEN EXISTS (
            SELECT
                1
            FROM
                Student
            WHERE
                Student.teacher_id = Teacher.id
        ) THEN 'Tienen estudiantes'
        ELSE 'Sin estudiantes'
    END AS estado
FROM
    Teacher;
-- INSERT INTO SELECT
INSERT INTO Student (name, surname, email, phone, teacher_id, employee_id)
SELECT
    name,
    surname,
    email,
    phone,
    teacher_id,
    employee_id
FROM
    Student
WHERE
    teacher_id IN (1, 2);
-- ---------------------------------------------------------
INSERT INTO Employee (name, surname, email, phone, company_id)
SELECT
    Employee.name,
    Employee.surname,
    Employee.email,
    Employee.phone,
    Employee.company_id
FROM
    Employee
JOIN
    Company
ON
    Employee.company_id = Company.id
WHERE
    Company.name LIKE '%Barcelo%';
-- ---------------------------------------------------------
INSERT INTO Student (name, surname, email, phone, teacher_id, employee_id)
SELECT
    Student.name,
    Student.surname,
    Student.email,
    Student.phone,
    Student.teacher_id,
    Student.employee_id
FROM
    Student
JOIN
    Employee
ON
    Student.employee_id = Employee.id
JOIN
    Company
ON
    Employee.company_id = Company.id
WHERE
    Company.name = 'AirEuropa';
-- COALESCE
SELECT
    name,
    email,
    COALESCE(phone, 'Teléfono no disponible') AS telefono
FROM
    Student;
-- ---------------------------------------------------------
SELECT
    Employee.name,
    Employee.surname,
    COALESCE(
        (SELECT Company.name
         FROM Company
         WHERE Company.id = Employee.company_id),
        'Empresa no asignada'
    ) AS empresa
FROM
    Employee;
-- ---------------------------------------------------------
SELECT
    name,
    surname,
    COALESCE(phone, 'No disponible') AS telefono
FROM
    Student;