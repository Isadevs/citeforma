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

insert into River(Name, Location, CountryID, CategoryID)
select distinct nameCountry, Location, Country.id, Category.id
from Tmp
inner join Country on Tmp.country=Country.Country
inner join Category on Tmp.category=Category.Category
order by Tmp.nameCountry;





