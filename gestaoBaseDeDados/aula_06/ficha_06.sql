--1. Construa o modelo de dados que entenda ser o mais adequado ao ficheiro WorldPort.csv
--(Port, Region, CountryCode, Country) e faça a importação dos dados.

CREATE DATABASE WorldPort;

--Criando a tabela temporaria Tmp para receber os dados da tabela externa
--WorldPort
CREATE TABLE Tmp (
    port VARCHAR(500),
    region VARCHAR(500),
    countryCode VARCHAR(50),
    country VARCHAR(500)
);

--Inserindo os dados da Tabela WorldPort no BD:
LOAD DATA INFILE '/var/lib/mysql-files/WorldPort.csv'
INTO TABLE Tmp
fields terminated by ';'
lines terminated by '\r\n'
(port, region, countryCode, country);

--Apaga somente os dados da Tabela:
TRUNCATE TABLE Tmp

--Criando a Tabela country
CREATE TABLE country (
    codeCountry VARCHAR(2) PRIMARY KEY,
    country VARCHAR(255) NOT NULL

);

--Povoando a Tabela country
INSERT INTO country(codeCountry, country)
	SELECT DISTINCT countryCode, country
	FROM Tmp
    ORDER BY country
;

--Criando a Tabela Regiao

CREATE TABLE region (
    id INT AUTO_INCREMENT PRIMARY KEY,
    region VARCHAR(255) NOT NULL,
    codeCountry VARCHAR (2) NOT NULL,
    FOREIGN KEY (codeCountry) REFERENCES country(codeCountry)
);

--Povoando a tabela regiao
INSERT INTO region(region, codeCountry)
	SELECT DISTINCT region, country.codeCountry
	FROM Tmp
    INNER JOIN country ON Tmp.countryCode=country.codeCountry
    ORDER BY country.countryCode
;



