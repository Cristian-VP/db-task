
CREATE TABLE passengers (
    PassengerId INT PRIMARY KEY,
    -- TINYINT(size) A very small integer. Signed range is from -128 to 127. Unsigned range is from 0 to 255.
    -- TINYINT is usefully because ee will register the survivors with 1 and the people who did not survive with 0
    Survival TINYINT(1) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    -- ENUM(val1, val2, val3, ...) A string object that can have only one value, chosen from a list of possible values.
    -- ENUM Help us that user register only the acepted values.
    Gender VARCHAR(250) NOT NULL,
    Age INT,
    SiblingsAndSpouses INT NOT NULL,
    ParentsAndChildren INT NOT NULL,
    -- Each passenger must have to a unique ticket number
    TicketNumber VARCHAR(50) UNIQUE,
    PortCode CHAR(1),
    FOREIGN KEY (PortCode) REFERENCES ports (PortCode),
    -- We need to check people age.
    CONSTRAINT CHK_Age CHECK ( Age BETWEEN 1 AND 100)
);

-- Table of ports
CREATE TABLE ports (
    -- We want assign capital letter of port name how port code
    PortCode CHAR(1) PRIMARY KEY,
    PortName VARCHAR(250),
    PortLocation VARCHAR(250),
    CHECK (PortCode IN ('C','Q','S'))
);

-- Table of passengers classes
CREATE TABLE classes (
    -- Only exists three classes
    ClassId INT,
    ClassDescription VARCHAR(100)
);


CREATE TABLE cabins (
    CabinId INT PRIMARY KEY AUTO_INCREMENT,
    CabinNumber VARCHAR(50),
    Deck VARCHAR(50)
);

-- Table of cabins
CREATE TABLE cabin_assignments (
    CabinId INT AUTO_INCREMENT,
    PassengerId INT,
    PRIMARY KEY (CabinId, PassengerId),
    FOREIGN KEY (CabinId) REFERENCES cabins (CabinId),
    FOREIGN KEY (PassengerId) REFERENCES passengers(PassengerId)
);

-- Relational table between classes and passengers
CREATE TABLE passenger_classes (
    PassengerId INT PRIMARY KEY,
    ClassId INT,
    FOREIGN KEY (PassengerId) REFERENCES passengers (PassengerId),
    FOREIGN KEY (ClassId) REFERENCES classes (ClassId)
);


-- Table of fare details
CREATE TABLE fare_details (
    FareId INT PRIMARY KEY,
    PassengerId INT,
    FareAmount FLOAT DEFAULT 0.0,
    ClassId INT,
    FOREIGN KEY (PassengerId) REFERENCES passengers(PassengerId),
    FOREIGN KEY (ClassId) REFERENCES classes(ClassId),
    CHECK ( FareAmount >= 0 )
);

