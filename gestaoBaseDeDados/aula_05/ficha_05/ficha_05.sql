--Questao 01 
--1. Crie uma VIEW que liste os aeroportos da  Península Ibérica (airport, city, IATA_FAA, ICAO).

LOAD DATA INFILE '/var/lib/mysql-files/airport.csv'
INTO TABLE airport 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(airport);

INSERT INTO airport (airport, IATA_FAA, ICAO, city_id)
SELECT 
    tmp.airport,     
    tmp.IATA_FAA,    
    tmp.ICAO,        
    city.id           
FROM tmp tmp
JOIN city city ON tmp.city=city.city;  

CREATE VIEW PeninsulaIberica 
AS SELECT PeninsulaIberica AS  airport
FROM airport WHERE airport.airport="Península Ibérica";

CREATE VIEW IberiaPeninsulaAirport AS
SELECT 
    airport.airport AS airport,
    city.city AS city,
    airport.IATA_FAA,
    airport.ICAO
FROM 
    airport
INNER JOIN 
    city ON airport.city_id = city.id
INNER JOIN 
    country ON city.countryID = country.id
WHERE 
    country.country IN ('Spain', 'Portugal');

--2.Faça a exportação para um ficheiro CSV da VIEW que criou.
SELECT * FROM IberiaPeninsulaAirport
INTO OUTFILE '/var/lib/mysql-files/IberiaPeninsulaAirport.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

--3.Faça um Backup da BD Airports
mysqldump -u root -p Airport > bdAirports.sql


