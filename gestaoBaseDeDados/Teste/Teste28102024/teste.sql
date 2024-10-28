--2.(3 val.) Faça a importação dos dados do ficheiro airline.csv fornecido e preencha as tabelas do
modelo de dados que criou.

CREATE DATABASE Airlines;

USE Airlines;

CREATE TABLE Temp (
    companhia VARCHAR(255),
    alias VARCHAR(255),
    iata VARCHAR(255),
    icao VARCHAR(255),
    callsign VARCHAR(255),
    country VARCHAR(255)
);

--Inserindo os dados da Tabela WorldPort no BD:
LOAD DATA INFILE '/var/lib/mysql-files/airline.csv'
INTO TABLE Temp
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(companhia, alias, iata, icao, callsign, country);


--Criando a Tabela country
CREATE TABLE country (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    countryID INT(2),
    FOREIGN KEY (countryID) REFERENCES country(id)
);

--Povoando a Tabela country
INSERT INTO country(country)
	SELECT DISTINCT country
	FROM Temp
    ORDER BY country
;

--criando a tabela companhia
CREATE TABLE airline(
    id INT AUTO_INCREMENT PRIMARY KEY,
    alias VARCHAR(255),
    IATA CHAR(3),
    ICAO CHAR(4),f
    callsign VARCHAR(255),
    countryID INT,
    country VARCHAR(255), 
    FOREIGN KEY (countryID) REFERENCES country(id)
);

-- povoando a tabela airline

INSERT INTO airline (alias, IATA, ICAO, callsign, countryID, country)
SELECT 
    Temp.alias, 
    Temp.IATA, 
    Temp.ICAO, 
    Temp.callsign, 
    country.id AS countryID,  
    country.country AS country  
FROM Temp
INNER JOIN country ON Temp.country = country.country

-- modificando as ordens das colunas:

ALTER TABLE airline
MODIFY COLUMN alias VARCHAR(255) FIRST,               
MODIFY COLUMN IATA CHAR(3) AFTER alias,               
MODIFY COLUMN ICAO CHAR(4) AFTER IATA,                
MODIFY COLUMN callsign VARCHAR(50) AFTER ICAO,        
MODIFY COLUMN country VARCHAR(255) AFTER callsign,    
MODIFY COLUMN countryID INT AFTER country;              


--3. Crie os utilizadores “tmpAirl”,“usrAirl” e “admAirl”.
CREATE USER 'tmpAirl'@'localhost' IDENTIFIED BY 'Abc75923893*';
CREATE USER 'usrAirl'@'localhost' IDENTIFIED BY 'Abc75923893*';
CREATE USER 'admAirl'@'localhost' IDENTIFIED BY 'Abc75923893*';

--4. Atribua as permissões de acesso à base de dados que criou para os seguintes utilizadores:
GRANT SELECT ON Airlines.* TO 'tmpAirl'@'localhost';
--“tmpAirl” - Leitura de todas as tabelas.

GRANT SELECT, INSERT, UPDATE ON Airlines.* TO 'usrAirl'@'localhost';
--“usrAirl” - Leitura, inserção e alteração de todas as tabelas.

GRANT ALL PRIVILEGES ON Airlines.* TO 'admAirl'@'localhost';
--“admAirl” - Permissões totais.

FLUSH PRIVILEGES;

--5. (2 val.) Retire todas as permissões ao utilizador “tmpAirl”.
REVOKE ALL PRIVILEGES ON *.* FROM 'tmpAirl'@'localhost';

--6. (3 val.) Crie uma View das Airlines para cada um dos seguintes Países:
--Portugal
--Spain

CREATE VIEW PortugalAirlines AS
SELECT 
    Temp.companhia AS airline,
    Temp.alias AS alias,
    Temp.iata AS IATA,
    Temp.icao AS ICAO,
    Temp.callsign AS callsign,
    country.country AS Country
FROM 
    Temp
INNER JOIN 
    country ON Temp.country = country.country  
WHERE 
    country.country IN ('Portugal');

CREATE VIEW SpainlAirlines AS
SELECT 
    Temp.companhia AS airline,
    Temp.alias AS alias,
    Temp.iata AS IATA,
    Temp.icao AS ICAO,
    Temp.callsign AS callsign,
    country.country AS Country
FROM 
    Temp
INNER JOIN 
    country ON Temp.country = country.country  
WHERE 
    country.country IN ('Spain');
--7. (3 val.) Faça a exportação das Views que criou para ficheiros csv.

SELECT * FROM SpainlAirlines
INTO OUTFILE '/var/lib/mysql-files/SpainlAirlines.csv'
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n';

SELECT * FROM PortugalAirlines
INTO OUTFILE '/var/lib/mysql-files/PortugalAirlines.csv'
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n';

--8. (1,5 val.) Faça um Backup da base de dados que criou.
mysqldump -u root -p Airlines > Airline.sql;