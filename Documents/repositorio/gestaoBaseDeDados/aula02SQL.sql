/*CRIAÇÃO DE USUÁRIOS: */
create user user_test@localhost identified by 'Test2024*';

/*MOSTRAR OS USUÁRIOS: */
show grants for user_test@localhost;

/*utilizador so fara select na base de dados*/
grant select on banco.* to user_test@localhost;

grant insert,update on banco.Client to user_test@localhost;

grant all on banco.* to new_user@localhost identified by 'Test2024';

GRANT ALL PRIVILEGES ON banco.* TO 'new_user'@'localhost';


sql
Copiar código
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'Test2024*';

alter user new_user@localhost identified by 'New2024*';

create user adm@localhost identified by 'Test2024*';

Nível de permissao igual ao root:
grant all on *.* to adm@localhost;

/*EX: 001 DAR PERMISSÃO AOS USUÁRIOS: */
create user isabella@localhost identified by 'Isa1993*';
grant all on *.* to isabella@localhost;

/*EX: 002 DAR CRIAR OS USUÁRIOS: */
create user tmpAir@localhost identified by 'Tmp2024*';
create user usrAir@localhost identified by 'Usr2024*';
create user admAir@localhost identified by 'Adm2024*'; 

/*EX: 003 ALTERAR PERMISSÃO DOS USUÁRIOS: */
grant select on Airport.* to tmpAir@localhost;
grant select on Airport.* to usrAir@localhost;
grant insert, update on Airport.airport to tmpAir@localhost;
grant all on *.* to admAir@localhost;



/*EX: 004 REMOVER TODAS AS PERMISSÕES DOS USUÁRIOS: */
REVOKE ALL PRIVILEGES ON *.* FROM 'admAir'@'localhost';





