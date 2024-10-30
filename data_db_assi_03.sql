-- Añadimos datos a las tablas creadas

-- Tabla Teacher

INSERT INTO TEACHER (name, email, phone, subject, salary) VALUES
    ('Maria','maria@borjamoll.eu', 633495640, 'Sistemas Informáticos', 12564.20),
    ('Jose Campero', 'jose@borjamoll.eu', 983345436, 'Desarrollo Web', 12544.20),
    ('Luis Martínez', 'luis@borjamoll.eu', 543897865, 'Ipo', 12564.20),
    ('Pep Adrover', 'pep@borjamoll.eu', 456789007, 'Lenguaje de Marcas', 12564.20),
    ('Sol Serna', 'sol@borjamoll.eu', 971543560, 'Entornos de Desarrollo', 12564.20),
    ('Dan Smith', 'dan@borjamoll.eu', 971345260, 'Inglés', 25647.20),
    ('Tina Rodriguez', 'tina@borjamoll.eu', 968562013, 'Base de datos', 25647.20),
    ('Mel González', 'mel@borjamoll.eu', 671458963, 'Programación', 25647.20),
    ('Rodrigo González', 'rodrigo@borjamoll.eu', 456897456, 'Seguridad Informática', 18695.30),
    ('Kora Marsé', 'kora@borjamoll.eu', 983645897, 'Estrategias Creativas', 20564.32),
    ('Joana Bermer', 'joana@borjamoll.eu' 971585963, 'Diseño Gráfico', 2158.20),
    ('Jaume Ripoll', 'jaume@borjamoll.eu', 968457895, 'Instructor de vuelo', 45609.30 ),
    ('Juan', 'juan@borjamoll.eu', 971565989, 'Docente de restauración', 23456.23),
    ('Adela', 'adela@borjamoll.eu', 975689456, 'Estrategia de Marketing', 18596.23),
    ('Jeff Kons', 'jeff@borjamoll.eu', 974586345, 'Gestion Logistica', 18564.69);

-- Tabla Company

INSERT INTO COMPANY (name, industry, foundation_year, num_employees, address, phone) VALUES
     ('Air Europa', 'Transporte Aéreo', 1996, 2500, NULL, 971558963),
     ('Bed Dreams', 'Hostelería', 2000, 500,NULL, 971586943),
     ('Glad to Link','Desarrollo de Software', 2001, 50,NULL, 968549678),
     ('Mano Web', 'Desarrollo de Software', 1996, 12,NULL, 971468695),
     ('Barceló Hoteles', 'Hostelería', 1901, 1500,NULL, 9457896),
     ('We are Yellow', 'Marketing', 2015, 20, NULL,968532678),
     ('DHL', 'Logística', 1996, 800, 'Calle los Olmos', 633579486),
     ('ProgersSys', 'Ciberseguridad', 2001, 23, 'Plaza España', 915638945);

-- Tabla Positions

INSERT INTO POSITIONS (title) VALUES
    -- Transporte Aéreo (e.g., Air Europa)
    ('Piloto'),
    ('Copiloto'),
    ('Ingeniero de Mantenimiento de Aeronaves'),
    ('Auxiliar de Vuelo'),

    -- Hostelería (e.g., Bed Dreams, Barceló Hoteles)
    ('Gerente de Hotel'),
    ('Recepcionista'),
    ('Conserje'),
    ('Chef'),
    ('Camarero'),
    ('Encargado de Mantenimiento de Hotel'),
    ('Encargado de Limpieza'),

    -- Desarrollo de Software (e.g., Glad to Link, Mano Web)
    ('Desarrollador Backend'),
    ('Desarrollador Frontend'),
    ('Ingeniero de DevOps'),
    ('Analista de QA'),
    ('Administrador de Bases de Datos'),
    ('Especialista en UX/UI'),

    -- Marketing (e.g., We are Yellow)
    ('Director de Marketing'),
    ('Especialista en SEO'),
    ('Copywriter'),
    ('Ejecutivo de Cuentas'),
    ('Community Manager'),
    ('Diseñador Gráfico'),

    -- Logística (e.g., DHL)
    ('Gerente de Logística'),
    ('Supervisor de Almacén'),
    ('Operador de Montacargas'),
    ('Conductor de Reparto'),
    ('Planificador de Rutas'),
    ('Empaquetador'),

    -- Ciberseguridad (e.g., ProgersSys)
    ('Analista de Seguridad'),
    ('Ingeniero de Seguridad'),
    ('Consultor en Ciberseguridad'),
    ('Especialista en Respuesta a Incidentes'),
    ('Especialista en Gestión de Riesgos'),
    ('Administrador de Redes');

-- Tabla Employee

INSERT INTO EMPLOYEE (name, email, phone) VALUES
    -- Empleados de Air Europa (Transporte Aéreo)
    ('Pedro Sánchez', 'pedro.sanchez@gmail.com', '651234567'),
    ('Ana Gómez', 'ana.gomez@gmail.com', '661234568'),
    ('Luis Martínez', 'luis.martinez@gmail.com', '671234569'),
    ('Maria López', 'maria.lopez@gmail.com', '681234570'),

    -- Empleados de Bed Dreams (Hostelería)
    ('Javier Pérez', 'javier.perez@gmail.com', '691234571'),
    ('Laura Fernández', 'laura.fernandez@gmail.com', '701234572'),
    ('Carlos Ruiz', 'carlos.ruiz@gmail.com', '711234573'),
    ('Sofía Hernández', 'sofia.hernandez@gmail.com', '721234574'),

    -- Empleados de Glad to Link (Desarrollo de Software)
    ('Marta Castillo', 'marta.castillo@gmail.com', '731234575'),
    ('Fernando Torres', 'fernando.torres@gmail.com', '741234576'),
    ('Beatriz Jiménez', 'beatriz.jimenez@gmail.com', '751234577'),
    ('Raúl García', 'raul.garcia@gmail.com', '761234578'),

    -- Empleados de Mano Web (Desarrollo de Software)
    ('Patricia Moreno', 'patricia.moreno@gmail.com', '771234579'),
    ('David López', 'david.lopez@gmail.com', '781234580'),
    ('Cristina Romero', 'cristina.romero@gmail.com', '791234581'),
    ('Jorge Salas', 'jorge.salas@gmail.com', '801234582'),

    -- Empleados de Barceló Hoteles (Hostelería)
    ('Estefanía Álvarez', 'estefania.alvarez@gmail.com', '811234583'),
    ('Hugo Santos', 'hugo.santos@gmail.com', '821234584'),
    ('Clara Muñoz', 'clara.munoz@gmail.com', '831234585'),
    ('Rafael Castro', 'rafael.castro@gmail.com', '841234586'),

    -- Empleados de We are Yellow (Marketing)
    ('Silvia Romero', 'silvia.romero@gmail.com', '851234587'),
    ('Álvaro Pérez', 'alvaro.perez@gmail.com', '861234588'),
    ('Inés Castro', 'ines.castro@gmail.com', '871234589'),
    ('Fernando López', 'fernando.lopez@gmail.com', '881234590'),

    -- Empleados de DHL (Logística)
    ('Carmen González', 'carmen.gonzalez@gmail.com', '891234591'),
    ('Andrés Díaz', 'andres.diaz@gmail.com', '901234592'),
    ('Patricia Romero', 'patricia.romero@gmail.com', '911234593'),
    ('Samuel Ortega', 'samuel.ortega@gmail.com', '921234594'),

    -- Empleados de ProgersSys (Ciberseguridad)
    ('Lucía Ruiz', 'lucia.ruiz@gmail.com', '931234595'),
    ('Julio Medina', 'julio.medina@gmail.com', '941234596'),
    ('Valeria Salazar', 'valeria.salazar@gmail.com', '951234597'),
    ('Sergio Vargas', 'sergio.vargas@gmail.com', '961234598');

-- Tabla Student
CREATE TABLE STUDENT (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         name VARCHAR(250) NOT NULL,
                         email VARCHAR(250) UNIQUE NOT NULL,
                         enrollment_date DATE,
                         teacher_id INT REFERENCES TEACHER(id) ON DELETE SET NULL,
                         employee_id INT REFERENCES EMPLOYEE(id) ON DELETE SET NULL
);

INSERT INTO STUDENT (name, email, enrollment_date, teacher_id, employee_id) VALUES
    ('Alejandro Romero', ''),
