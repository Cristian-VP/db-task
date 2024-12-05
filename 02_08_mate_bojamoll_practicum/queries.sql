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

/*
HAVING
1- Muestra todos los empleados cuya empresa tiene más de 2 empleados asignados.
2- Muestra los profesores y el número de estudiantes que supervisan, filtrando aquellos con más de 1 estudiante.
3- Consulta todas las empresas con el número de empleados que tienen, pero filtra solo aquellas que tienen más de 1 empleado.
 */
-- 1
SELECT Company.id AS Empresa, COUNT(Employee.company_id) AS Numero_empleados FROM Employee
JOIN Company ON Employee.company_id = Company.id
GROUP BY Company.id HAVING Numero_empleados > 2;
-- 2
SELECT Teacher.name, COUNT(Student.id) AS N_estudiantes
FROM Student
JOIN Teacher ON Student.teacher_id = Teacher.id
GROUP BY Teacher.name
HAVING N_estudiantes > 1;
-- 3
SELECT Company.name, COUNT(Employee.id) AS Numeros_empleados
FROM Company
JOIN Employee ON Company.id = Employee.company_id
GROUP BY Company.name
HAVING Numeros_empleados > 1;
-- FIN HAVING

/*
 EXIST
1- Realiza una consulta para obtener todos los empleados que están relacionados con alguna empresa y tienen estudiantes asociados.
2- Obtén una lista de todos los empleados que están asociados a algún estudiante, utilizando EXISTS para verificar la relación.
3- Muestra todos los estudiantes que están asociados con al menos una empresa, utilizando EXISTS para comprobar si tienen asignada una empresa.
 */
-- 1
SELECT Employee.name
FROM Employee, Student
WHERE EXISTS(
    SELECT Employee.name
    FROM Employee
    JOIN Company On Employee.company_id = Company.id
) AND Employee.id = Student.employee_id
GROUP BY Employee.name;
--
INSERT INTO Employee (id, name, surname, email, phone, company_id) VALUES (7,'Rosa', 'Maertinez', 'rosa@empresa.com', '633915509', NULL);
-- 2
SELECT Employee.name
FROM Employee
WHERE EXISTS ( SELECT '4' FROM Student WHERE Student.employee_id = Employee.id);
-- 3
SELECT Student.name
FROM Student
WHERE EXISTS (SELECT 1 FROM Employee WHERE Employee.id = Student.employee_id);
-- FIN EXIST

/*
ANY
-- 1 Muestra todos los empleados que trabajan para una empresa que tiene más de 2 empleados, utilizando ANY para comparar los resultados.
-- 2 Realiza una consulta para obtener los empleados cuyo número de teléfono coincide con alguno de los empleados de la empresa con id 2, usando ANY.
-- 3 Muestra todos los estudiantes cuyo id de profesor coincide con alguno de los profesores que tiene el email que termina en '@cifpfbmoll.eu'
 */
-- 1
SELECT Employee.name FROM Employee WHERE  Employee.company_id = ANY
     (SELECT Company.id
      FROM Employee, Company
      WHERE company_id = Company.id
      GROUP BY Company.id
      HAVING COUNT(*) > 2);
-- 2
SELECT Employee.name FROM Employee WHERE Employee.phone = ANY
    (SELECT Employee.id
     FROM Employee
     WHERE company_id = 2
     GROUP BY Employee.id);
-- 3
SELECT Student.name FROM Student WHERE Student.teacher_id = ANY (
    SELECT id
    FROM Teacher
    WHERE Student.email LIKE '%@cifpfbmoll.eu'
);
INSERT INTO Teacher (id, name, surname, email) VALUES (5, 'Marta', 'Suspiros', 'marta@gmail.com');
INSERT INTO Student (id, name, surname, email, phone, teacher_id, employee_id) VALUES (12, 'Sebas', 'Ripoll', 'sabas@mail.com', '599897845', 5, 2);
-- FIN ANY
