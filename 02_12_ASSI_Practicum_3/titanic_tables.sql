
-- Tabla para los pasajeros
CREATE TABLE passengers (
    PassengerId INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Gender ENUM('male', 'female') NOT NULL,
    Age INT,
    SiblingsAndSpousesAboard INT NOT NULL,
    ParentsAndChildrenAboard INT NOT NULL,
    TicketNumber VARCHAR(50),
    PassengerFare FLOAT,
    EmbarkedPort ENUM('C', 'Q', 'S')
);


-- Tabla para puertos
CREATE TABLE ports (
    PortCode ENUM('C', 'Q', 'S') PRIMARY KEY,
    PortName VARCHAR(100),
    PortLocation VARCHAR(100)
);

-- Tabla de clases de pasarjeros
CREATE TABLE classes (
    ClassId INT PRIMARY KEY,
    ClassDescription VARCHAR(100)
);

-- Crear tabla de cabinas
CREATE TABLE cabins (
    CabinId INT PRIMARY KEY,
    CabinNumber VARCHAR(50),
    Deck VARCHAR(50),  -- Deck o piso de la cabina
    PassengerId INT,
    FOREIGN KEY (PassengerId) REFERENCES passengers(PassengerId)
);

-- Tabla para los supervivientes
CREATE TABLE survival (
    PassengerId INT PRIMARY KEY,
    Survival TINYINT NOT NULL,
    FOREIGN KEY (PassengerId) REFERENCES passengers(PassengerId)
);


-- Crear una tabla para relacionar pasajeros con su clase
CREATE TABLE passenger_classes (
    PassengerId INT,
    ClassId INT,
    PRIMARY KEY (PassengerId, ClassId),
    FOREIGN KEY (PassengerId) REFERENCES passengers(PassengerId),
    FOREIGN KEY (ClassId) REFERENCES classes(ClassId)
);


-- Crear tabla de detalles de tarifa
CREATE TABLE fare_details (
    FareId INT PRIMARY KEY,
    PassengerId INT,
    FareAmount FLOAT,
    ClassId INT,
    EmbarkedPort ENUM('C', 'Q', 'S'),
    FOREIGN KEY (PassengerId) REFERENCES passengers(PassengerId),
    FOREIGN KEY (ClassId) REFERENCES classes(ClassId)
);