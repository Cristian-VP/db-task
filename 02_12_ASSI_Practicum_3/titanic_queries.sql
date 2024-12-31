-- CREATE DATABASE
CREATE DATABASE titanicDB;
USE titanicDB;

-- CREATE TABLES
/*
 SEE CREATE STATEMENT ON titanic_tables.sql FILE
*/

-- DROP
DROP DATABASE titanicDB;
DROP table passengers;
    -- TRUNCATE
    TRUNCATE TABLE passengers;
DROP TABLE cabins;
DROP TABLE passenger_classes;
DROP TABLE classes;
DROP TABLE fare_details;
DROP TABLE ports;
    TRUNCATE TABLE ports;
DROP TABLE cabin_assignments;

-- ALTER TABLE
    -- ADD CHECK
    ALTER TABLE passengers
    ADD CHECK ( passengers.PassengerFare >= 0);

    -- ADD UNIQUE
    ALTER TABLE cabins
    ADD UNIQUE (CabinNumber);

    -- ADD PRIMARY KEY
    ALTER TABLE classes
    ADD PRIMARY KEY (ClassId);

    -- ADD CONSTRAIN
    ALTER TABLE classes
    ADD CONSTRAINT CHK_ClassID CHECK ( ClassId BETWEEN 1 AND 3);

    -- ADD
    ALTER TABLE passengers
    ADD PassengerFare FLOAT;

    ALTER TABLE ports
    ADD Country VARCHAR(250);

    -- DROP
    ALTER TABLE ports
    DROP Country;

    -- NOT NULL - MODIFY
    ALTER TABLE passenger_classes
    MODIFY COLUMN ClassId INT NOT NULL;

    -- AUTO_INCREMENT -MODIFY
    ALTER TABLE passengers
    MODIFY COLUMN PassengerId INT AUTO_INCREMENT;

    ALTER TABLE passengers
    AUTO_INCREMENT = 1;


-- CONSTRAIN, NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY,  CHECK, DEFAULT, AUTO INCREMENT
/*
 SEE ALL DECLARATION STATEMENTS ON titanic_tables.sql FILE
*/

-- DATES
    -- ALTER TABLE ADD COLUMN
    ALTER TABLE fare_details
    ADD FareDate DATE;

    -- ALTER TABLE ADD CONSTRAINTS TO CHECK ONLY OF 1912 FARES. IT WAS THE YEAR IN WICH THE TITANIC SER SAIL.
    ALTER TABLE fare_details
    ADD CONSTRAINT CHK_Year Check ( fare_details.FareDate BETWEEN '1912-04-10' AND '1912-04-11');

    DESCRIBE fare_details;

-- INDEX
    -- INDEX TO RECURSIVE QUERIES ON PorCode AND PassengerID
    CREATE INDEX idx_passenger_port ON passengers (PortCode);
    CREATE INDEX idx_passenger_id ON passengers (PassengerId);

-- VIEW
CREATE VIEW test_survival_3_class_female AS
    SELECT p.Name
    FROM passengers p
    JOIN passenger_classes ON p.PassengerId = passenger_classes.PassengerId
    WHERE ClassId = 3;
