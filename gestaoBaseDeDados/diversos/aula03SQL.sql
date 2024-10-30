SELECT @@SECURE_FILE_PRIV;

create table tmp(airport varchar(80), city varchar(60),country varchar(60),IATA_FAA varchar(3), ICAO varchar(4));

/var/lib/mysql-files/AtlanticSalmonRiver.csv/

-- Selecionar sem duplicações em ordem alfabetica: 
select distinct country from tmp order by country;

insert into country(country) select distinct country from tmp order by country;

--listar todas as tabelas 
select *from country;

select city, ID --id corresponde ao país
from tmp 
inner join country
on tmp.country=country.country;


insert into city(city, countryID)
select distinct city, id
from tmp 
inner join country
on tmp.country=country.country order by id, city;

select city, country
from city 
inner join country
on city.countryID=country.id
and country='Portugal';

--refinando o aerotporto
insert into airport(airport, IATA_FAA, ICAO, cityID)
select distinct airport, IATA_FAA, ICAO, city.id
from tmp
inner join city on tmp.city=city.city 
inner join country on city.countryID=country.id and
tmp.country=country.country;

-- ficha 03 
load data infile '/home/var/lib/mysql-files/AtlanticSalmonRiver.csv'
into table Tmp
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(country, nameCountry, category, location);

Create table Tmp(
	country varchar(500),
	nameCountry varchar(50),
	category varchar(50),
	location varchar(500));

LOAD DATA INFILE 'admin:///var/lib/mysql-files/AtlanticSalmonRiver.csv'
INTO TABLE Tmp
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(country, nameCountry, category, location);

load data infile '/var/lib/mysql-files/AtlanticSalmonRiver.csv'
into table Tmp
fields terminated by ';'
lines terminated by '\n'
(country, nameCountry, category, location);

insert into Country (Country)
	select distinct Country
	from Tmp
	where Country is not null;

insert into Category (Category)
	select distinct Category
	from Tmp
	where Category is not null;
	
insert into River (Name, CountryID, CategoryID)
	select distinct Tmp.location, Tmp.country, Tmp.category
	from Tmp
	join 
	
select * from country
where country like '%P'
into outfile 'admin:///var/lib/mysql-files'


insert into airport(airport, IATA_FAA, ICAO, cityID)
select distinct airport, IATA_FAA, ICAO, city.id
from tmp
inner join city on tmp.city=city.city 
inner join country on city.countryID=country.id and
tmp.country=country.country;

----------




