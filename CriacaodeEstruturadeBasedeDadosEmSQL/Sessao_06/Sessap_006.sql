SHOW TABLES;

DESC airport;

CREATE INDEX airport_idx ON airport(airport);

CREATE DATABASE mycompany;

USE mycompany;

CREATE TABLE contact
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    surname VARCHAR(259) NOT NULL,
    cc VARCHAR(12) NOT NULL,
    nif INT NOT NULL,
    email VARCHAR(50),
    INDEX name_idx(name(10), surname(10))
);
