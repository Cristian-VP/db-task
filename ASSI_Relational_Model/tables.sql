CREATE DATABASE real_state;
USE real_state;



CREATE TABLE Person (
  person_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  date_birth DATE,
  age TINYINT AS (TIMESTAMPDIFF(YEAR, date_birth, CURDATE())) VIRTUAL,
  direction VARCHAR (255)  
);

CREATE TABLE Phone(
  id_phone INT PRIMARY KEY AUTO_INCREMENT,
  number VARCHAR(255),
  FOREIGN KEY (id_phone) REFERENCES Person(person_id)
);

CREATE TABLE Customer(
  person_id INT PRIMARY KEY AUTO_INCREMENT,
  date_end_relation DATE,
  FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

CREATE TABLE Seller(
  person_id INT PRIMARY KEY AUTO_INCREMENT,
  nss VARCHAR (255) NOT NULL,
  salary DECIMAL(10,2) NOT NULL,
  type_contract ENUM('comercial','api'),
  FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

CREATE TABLE Api(
  record_id INT PRIMARY KEY AUTO_INCREMENT,
  record_date DATE,
  FOREIGN KEY (record_id) REFERENCES Seller(person_id)
);

CREATE TABLE Owner(
  person_id INT PRIMARY KEY AUTO_INCREMENT,
  nif VARCHAR (255),
  FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

CREATE TABLE Visit(
  visit_id INT PRIMARY KEY AUTO_INCREMENT,
  date_visit DATE,
  hour_visit TIME,
  FOREIGN KEY (visit_id) REFERENCES Customer(person_id),
  FOREIGN KEY (visit_id) REFERENCES Flat(flat_id)
);


CREATE TABLE Flat(
  flat_id INT PRIMARY KEY AUTO_INCREMENT,
  direction VARCHAR (255),
  surface INT,
  num_rooms INT,
  price DECIMAL (9,2)
    
);

CREATE TABLE Property(
  owner_id INT,
  flat_id INT,
  FOREIGN KEY (owner_id) REFERENCES Owner(person_id),
  FOREIGN KEY (flat_id) REFERENCES Flat(flat_id)
);


CREATE TABLE Satisfaction(
  no_satisfaction ENUM('yes','no'),
  characteristics_id INT,
  flat_id INT,
  FOREIGN KEY (characteristics_id) REFERENCES Characteristics(characteristics_id),
  FOREIGN KEY (flat_id) REFERENCES Flat(flat_id)  
);

CREATE TABLE Characteristics(
  characteristics_id INT PRIMARY KEY AUTO_INCREMENT,
  description VARCHAR(255)
);

CREATE TABLE Zone(
  zone_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  FOREIGN KEY (zone_id) REFERENCES Population(population_id)
);

CREATE TABLE Bordering(
  covers INT,
  covered INT,
  FOREIGN KEY (covers) REFERENCES Zone(zone_id),
  FOREIGN KEY (covered) REFERENCES Zone(zone_id)
);

CREATE TABLE Population(
  population_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR (255),
  num_habitants VARCHAR (255)
);

