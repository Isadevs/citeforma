--Questao 01 
--1. Crie uma VIEW que liste os aeroportos da  Península Ibérica (airport, city, IATA_FAA, ICAO).

LOAD DATA INFILE '/var/lib/mysql-files/airport.csv'
INTO TABLE airport 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(airport);

INSERT INTO airport (airport, IATA_FAA, ICAO, city_id)
SELECT 
    t.airport,     
    t.IATA_FAA,    
    t.ICAO,        
    c.id           
FROM tmp t
JOIN city c ON t.city=c.id; 

INSERT INTO airport (airport, IATA_FAA, ICAO, city_id)
SELECT 
    t.airport,     
    t.IATA_FAA,    
    t.ICAO,        
    c.id           -- id correto da cidade
FROM tmp t
JOIN city c ON t.city=c.id;  -- Ajuste a coluna conforme necessário

