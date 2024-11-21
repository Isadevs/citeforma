/*Faça a criação de índices para as tabelas country(country), city(city) e airport(airport,
IATA_FAA,ICAO) da base de dados Airport.*/

USE Airport;

SHOW TABLES; 

DESC country;
-- Criar índice na tabela country para a coluna country
CREATE INDEX idx_country ON country(country);

-- Criar índice na tabela city para a coluna city
CREATE INDEX idx_city ON city(city);

-- Criar índices na tabela airport para as colunas airport, IATA_FAA e ICAO
CREATE INDEX idx_airport_name ON airport(airport);
CREATE INDEX idx_airport_iata_faa ON airport(IATA_FAA);
CREATE INDEX idx_airport_icao ON airport(ICAO);



