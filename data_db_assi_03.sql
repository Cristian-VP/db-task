-- Añadimos datos a las tablas creadas

-- Tabla Teacher

INSERT INTO TEACHER (name, email, phone, subject, salary) VALUES
    ('Maria','maria@borjamoll.eu', 633495640, 'Sistemas Informáticos', 12564.20),
    ('Jose Campero', 'jose@borjamoll.eu', 983345436, 'Desarrollo Web', 12544.20),
    ('Pep Adrover', 'pep@borjamoll.eu', 456789007, 'Lenguaje de Marcas', 12564.20),
    ('Sol Serna', 'sol@borjamoll.eu', 971543560, 'Entornos de Desarrollo', 12564.20),
    ('Dan Smith', 'dan@borjamoll.eu', 971345260, 'Inglés', 25647.20),
    ('Tina Rodriguez', 'tina@borjamoll.eu', 968562013, 'Base de datos', 25647.20),
    ('Mel González', 'mel@borjamoll.eu', 671458963, 'Programación', 25647.20),
    ('Rodrigo González', 'rodrigo@borjamoll.eu', 456897456, 'Seguridad Informática', 18695.30),
    ('Kora Marsé', 'kora@borjamoll.eu', 983645897, 'Estrategias Creativas', 20564.32),
    ('Joana Bermer', 'joana@borjamoll.eu', 971585963, 'Diseño Gráfico', 2158.20),
    ('Adela', 'adela@borjamoll.eu', 975689456, 'Estrategia de Marketing', 18596.23);


-- Tabla Company

INSERT INTO COMPANY (name, industry, foundation_year, num_employees, address, phone) VALUES
     ('Air Europa', 'Transporte Aéreo', 1996, 2500, NULL, 971558963),
     ('Bed Dreams', 'Hostelería', 2000, 500,NULL, 971586943),
     ('Glad to Link','Desarrollo de Software', 2001, 50,NULL, 968549678),
     ('Mano Web', 'Desarrollo de Software', 1996, 12,NULL, 971468695),
     ('Barceló Hoteles', 'Hostelería', 1901, 1500,NULL, 9457896),
     ('We are Yellow', 'Marketing', 2015, 20, NULL,968532678),
     ('DHL', 'Logística', 1996, 800, 'Calle los Olmos', 633579486),
     ('ProgersSys', 'Ciberseguridad', 2001, 23, 'Plaza España', 915638945),
    ('Geiser', 'Alimentación', 2002, 30, NULL, 617038956),
    ('Marley Sound', 'Discográfica', 2021, 2, 'Carrer Moli,4,1º',671589634),
    ('Mocitos','Suministro',2014, 9,'Castell Fidardo', NULL),
    ('Pollos Hermanos', 'Alimentación', 2002, 200,'Calle Pata Palo', 99996633);
-- Tabla Positions

INSERT INTO POSITIONS (title) VALUES

    ('Desarrollador Backend'),
    ('Desarrollador Frontend'),
    ('Ingeniero de DevOps'),
    ('Analista'),
    ('Administrador de Bases de Datos'),
    ('Especialista en UX/UI'),
    ('Especialista en SEO'),
    ('Copywriter'),
    ('Diseñador Gráfico'),
    ('Analista de Seguridad'),
    ('Administrador de Redes');

-- Tabla Employee
-- 32 empleados
INSERT INTO EMPLOYEE (name, email, phone) VALUES
    ('Pedro Sánchez', 'pedro.sanchez@gmail.com', '651234567'),
    ('Ana Gómez', 'ana.gomez@gmail.com', '661234568'),
    ('Luis Martínez', 'luis.martinez@gmail.com', '671234569'),
    ('Maria López', 'maria.lopez@gmail.com', '681234570'),
    ('Javier Pérez', 'javier.perez@gmail.com', '691234571'),
    ('Laura Fernández', 'laura.fernandez@gmail.com', '701234572'),
    ('Carlos Ruiz', 'carlos.ruiz@gmail.com', '711234573'),
    ('Sofía Hernández', 'sofia.hernandez@gmail.com', '721234574'),
    ('Marta Castillo', 'marta.castillo@gmail.com', '731234575'),
    ('Fernando Torres', 'fernando.torres@gmail.com', '741234576'),
    ('Beatriz Jiménez', 'beatriz.jimenez@gmail.com', '751234577'),
    ('Raúl García', 'raul.garcia@gmail.com', '761234578'),
    ('Patricia Moreno', 'patricia.moreno@gmail.com', '771234579'),
    ('David López', 'david.lopez@gmail.com', '781234580'),
    ('Cristina Romero', 'cristina.romero@gmail.com', '791234581'),
    ('Jorge Salas', 'jorge.salas@gmail.com', '801234582'),
    ('Estefanía Álvarez', 'estefania.alvarez@gmail.com', '811234583'),
    ('Hugo Santos', 'hugo.santos@gmail.com', '821234584'),
    ('Clara Muñoz', 'clara.munoz@gmail.com', '831234585'),
    ('Rafael Castro', 'rafael.castro@gmail.com', '841234586');

-- Tabla Student

INSERT INTO STUDENT (name, email, enrollment_date, teacher_id, employee_id) VALUES
    ('Alejandro Romero', 'alex@@borjamoll.eu', '2018-05-21', 1, 1),
    ('Rosario Martínez', 'rosario@borjamoll.eu', '2018-05-21', 2, 2),
    ('Luis Sagrario','luis@borjamoll.eu', '2018-05-21', 3, 3),
    ('Martín Martínez', 'marin@borjamoll.eu', '2018-05-21', 5, 4),
    ('Ferran Llul', 'ferran@borjamoll.eu', '2018-05-21', 4, 5),
    ('Cristian Perez', 'cristian@borjamoll.eu', '2018-05-21', 6, 6),
    ('Abimael Sánchez', 'abi@borjamoll.eu', '2018-05-21', 7, 7),
    ('Lautaro Montò', 'lautaro@borjamoll.eu', '2018-05-21', 9, 8),
    ('Isabel Gallardo', 'isabel@borjamoll.eu', '2018-05-21', 9, 9),
    ('Risto Mejide', 'risto@borjamoll.eu', '2018-05-21', 10, 10),
    ('María Teresa', 'maria@borjamoll.eu', '2018-05-21', 11, 11);

-- Asociar posiciones con la tabla empleados dentro de la empresa
CREATE TABLE EMPLOYEEPOSITION (
    employee_id INT NOT NULL,
    company_id INT NOT NULL,
    employee_position_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id),
    FOREIGN KEY (company_id) REFERENCES COMPANY(id),
    FOREIGN KEY (employee_position_id) REFERENCES POSITIONS(id)
);

INSERT INTO EMPLOYEEPOSITION (employee_id, company_id, employee_position_id, start_date, end_date) VALUES
   (1,1, 5, '2024-9-20', NULL ),
   (2,2, 6, '2024-9-21', NULL),
   (3,3, 1, NULL, NULL),
   (4,4, 2, '2023-10-21', NUll),
   (5, 5, 7, '2023-09-07', NULL),
   (6,6,9, '2021-04-02', NULL),
   (7, 7, 4, '2022-01-01', NULL),
   (8, 8, 10, NULL, NULL),
   (9,9,8, '2023-07-11', NULL),
   (10, 10, 3, NULL, NUll),
   (11,12,11,'2024-10-20', NULL);

-- TEST INSERT donde COMPANI.adress = NULL
INSERT INTO COMPANY (id, name, industry, foundation_year, num_employees, address, phone)