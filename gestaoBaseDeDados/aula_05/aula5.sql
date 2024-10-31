CREATE TABLE especie (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(3),
    NomeComum VARCHAR(50),
    NomeCientifico VARCHAR(50),
    Profundidade BOOLEAN DEFAULT FALSE
);

create table profundidade(
    NomeComum VARCHAR(50),
    NomeCientifico VARCHAR(50)
);

LOAD DATA INFILE '/var/lib/mysql-files/Profundidade.csv'
INTO TABLE profundidade 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(NomeComum, NomeCientifico);

LOAD DATA INFILE '/var/lib/mysql-files/Especie.csv'
INTO TABLE especie 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Codigo, NomeComum, NomeCientifico);

-- update

SELECT * FROM Especie

SELECT * FROM especie WHERE NomeCientifico 
in(SELECT NomeCientifico FROM profundidade);

update especie
set Profundidade=true
WHERE NomeCientifico
in(SELECT NomeCientifico FROM profundidade);

create table test(valor1 int, valor2 int, total int);
insert into test(valor1, valor2)

drop table test;

insert into test(valor1, valor2)
values(23,26);

insert into test(valor1, valor2)
values(50,66);

insert into test(valor1, valor2)
values(300, 166);

update test set total=valor1+valor2;

use SalmonRiver;

create view rivercountry 
as SELECT name as River
from River inner join Country on River.CountryID=Country.id;

--
show full tables; -- mostra se as tables sao fisics ou view

