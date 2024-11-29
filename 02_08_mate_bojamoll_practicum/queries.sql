/*

 */
-- 1
-- 2
-- 3
-- FIN

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
RIGHT JOIN Student ON Student.employee_id =  Employee.id
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
RIGHT JOIN Company ON Employee.company_id = Company.id
-- 3
-- FIN FULL JOIN