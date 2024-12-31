-- ADD VALUES Charged for CSV FILE
    -- Passengers table
    LOAD DATA INFILE '/mnt/passengers-dataset.csv'
    INTO TABLE passengers
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (Survival, Name, Gender, Age, SiblingsAndSpouses, ParentsAndChildren,TicketNumber, PortCode, PassengerFare);

    -- Passengers classes
    LOAD DATA INFILE '/mnt/passenger_classes-dataset.csv'
    INTO TABLE passenger_classes
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (PassengerId, ClassId);

    -- Fare details
    LOAD DATA INFILE '/mnt/fare_details-dataset.csv'
    INTO TABLE fare_details
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (FareId, PassengerId, FareAmount, ClassId, FareDate);

    -- Cabin assignments
    LOAD DATA INFILE '/mnt/cabin_assignments-dataset.csv'
    INTO TABLE cabin_assignments
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (CabinId, PassengerId);

INSERT INTO ports (PortCode, PortName, PortLocation, Country)
VALUES
('C', 'Cherbourg', 'Cherburgo-en-Cotentin', 'France'),
('Q', 'Queenstown','Cobh', 'Ireland'),
('S', 'Southampton', ' Southampton Water', 'England');

INSERT INTO classes (ClassId, ClassDescription)
VALUES  (1, 'First Class'),
        (2, 'Second Class'),
        (3, 'Third Class');

INSERT INTO cabins (CabinNumber, Deck) VALUES
('A23', 'Deck A'),
('B56', 'Deck B'),
('C67', 'Deck C'),
('D12', 'Deck D'),
('E34', 'Deck E'),
('F45', 'Deck F'),
('G12', 'Deck G'),
('H09', 'Deck H'),
('I20', 'Deck I'),
('J50', 'Deck J');
