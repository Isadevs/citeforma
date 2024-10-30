--extrair coluna de tabela e inserir em outro ficheiro

select * into outfile '/var/lib/mysql-files/Country.txt'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
from Country;

--
mysqldump -u root -p Airport > airportBKP.sql
o mysqldump vai fazer backup de toda a tabela 

--rio pais localizacao , order by name rio
create table Airport;
use Airport;
source airportBKP.sql;
--vai importar exatamente todos os campos de atributos que tem na tabela 


mysqldump -u root -p --databases Airport SalmonRiver > airportBKP.sql
mysqldump -u root -p 


mysqldump -u root -p airport country countryairport.sq


