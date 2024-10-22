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

--criando a tabela port
CREATE TABLE port (
    id INT AUTO_INCREMENT PRIMARY KEY,
    port VARCHAR(255) NOT NULL,
    region VARCHAR(255) NOT NULL,
    FOREIGN KEY(codeCountry) REFERENCES region(codeCountry)
);

--construindo a tabela port
CREATE TABLE port (
    id INT AUTO_INCREMENT PRIMARY KEY,
    port VARCHAR(255) NOT NULL,
    region_id INT NOT NULL,  -- Armazena o ID da região como chave estrangeira
    FOREIGN KEY (region_id) REFERENCES region(id)  -- Chave estrangeira que referencia o ID da tabela region
);

-- povoando a tabela port
INSERT INTO port(port, region_id)
	SELECT DISTINCT port, region.id
	FROM Tmp 
    INNER JOIN region ON Tmp.region=region.region
    ORDER BY region.id, port;
;

--2. Crie os utilizadores “tmpPort”, “usrPort” e “admPort”.

CREATE USER 'tmpPort'@'localhost' IDENTIFIED BY 'Abc75923893*';
CREATE USER 'usrPort'@'localhost' IDENTIFIED BY 'Abc75923893*';
CREATE USER 'admPort'@'localhost' IDENTIFIED BY 'Abc75923893*';

--3. 
/*
Atribua as seguintes permissões aos utilizadores:
    ◦ “tmpPort” - Leitura de todas as tabelas da BD WorldPort.
    ◦ “usrPort” - Leitura de todas as tabelas da BD WorldPort e escrita na tabela Port.
    ◦ “admPort” - Permissões totais sobre a BD WorldPort.
*/

GRANT SELECT ON WorldPort.* TO 'usuario'@'host';
--tmpPort” - Leitura de todas as tabelas da BD WorldPort

GRANT SELECT ON WorldPort.* TO 'tmpPort'@'localhost';

--“usrPort” - Leitura de todas as tabelas da BD WorldPort e escrita na tabela Port.
GRANT SELECT ON WorldPort.* TO 'usrPort'@'localhost';
GRANT INSERT, UPDATE, DELETE ON WorldPort.port TO 'usrPort'@'localhost';

--admPort” - Permissões totais sobre a BD WorldPort.
GRANT ALL PRIVILEGES ON WorldPort.* TO 'admPort'@'localhost';

--4.Retire todas as permissões ao utilizador “tmpPort”;
REVOKE ALL PRIVILEGES ON *.* FROM 'tmpPort'@'%';

--5.Crie uma VIEW com o nome PortugalPort que liste os portos de Portugal 
--(Port, Region, CountryCode, Country)

CREATE VIEW PortugalPort AS
SELECT 
    Tmp.port AS Port,
    region.region AS Region,
    Tmp.countryCode AS CountryCode,
    country.country AS Country
FROM 
    Tmp
INNER JOIN 
    region ON Tmp.region = region.region  
INNER JOIN 
    country ON Tmp.countryCode = country.codeCountry  
WHERE 
    country.country = 'Portugal';  

--6.Faça a exportação para ficheiro da VIEW criada anteriormente.
SELECT * FROM PortugalP
INTO OUTFILE '/var/lib/mysql-files/PortugalPort.csv'
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n';

--7.Faça um Backup da BD WorldPort
mysqldump -u root -p WorldPort > WorldPort.sql;



