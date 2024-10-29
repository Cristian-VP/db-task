CREATE DATABASE borjamoll;

USE borjamoll;

-- Tabla Teacher
CREATE TABLE TEACHER (                         -- Mayus en columnas para evitar errores en las consultas
  id INT AUTO_INCREMENT PRIMARY KEY,           -- Auto-increment para ID
  name VARCHAR(250) NOT NULL,                  -- Evitar que el nombre sea nulo
  email VARCHAR(250) UNIQUE NOT NULL,          -- Correo único y no nulo
  phone VARCHAR(20),
  subject VARCHAR(250),
  hire_date DATE,                              -- YYYY-MM-DD
  salary NUMERIC(8 ,2)                         -- Solo dos decimales
);

-- Tabla Company
CREATE TABLE COMPANY (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(250) UNIQUE NOT NULL,
  industry VARCHAR (250),
  foundation_year YEAR,                         -- YYYY
  num_employees INT,
  address VARCHAR(500),
  phone VARCHAR(20)
);

-- Tabla posibles posiciones en la empresa
CREATE TABLE POSITION (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) UNIQUE NOT NULL
);
-- Tabla Employee
CREATE TABLE EMPLOYEE (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(250) NOT NULL,
  email VARCHAR(250) UNIQUE NOT NULL,
  phone VARCHAR(20)
);

-- Asociar posiciones con la tabla empleados dentro de la empresa
CREATE TABLE EMPLOYEEPOSITION (
    employee_id INT NOT NULL,
    company_id INT NOT NULL,
    employee_position_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id),
    FOREIGN KEY (company_id) REFERENCES COMPANY(id),
    FOREIGN KEY (employee_position_id) REFERENCES POSITION(id)
);

-- Tabla Student
CREATE TABLE STUDENT (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(250) NOT NULL,
  email VARCHAR(250) UNIQUE NOT NULL,
  enrollment_date DATE,
  teacher_id INT REFERENCES TEACHER(id) ON DELETE SET NULL,
  employee_id INT REFERENCES EMPLOYEE(id) ON DELETE SET NULL
);