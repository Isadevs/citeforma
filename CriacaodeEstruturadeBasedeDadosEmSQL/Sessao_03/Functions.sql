use EuropeFootballLeagues;

show tables;

desc Teams;

delimiter $$
CREATE FUNCTION getTeamName(teamID INT)
RETURNS varchar(50)
DETERMINISTIC
BEGIN
	declare TeamName varchar(50) Default 'Não existe!';
    select team into TeamName from Teams where id=teamID;
    RETURN TeamName;
END$$
delimiter ; 

delimiter $$
CREATE FUNCTION getLeagueName(leagueID INT)
RETURNS varchar(50)
DETERMINISTIC
BEGIN
	declare LeagueName varchar(50) Default 'Não existe!';
    select league into LeagueName from Leagues where id=leagueID;
    RETURN LeagueName;
END$$
delimiter ;


delimiter $$ 
CREATE FUNCTION getVictories(teamID INT)
RETURNS int
DETERMINISTIC
BEGIN
	declare victories int default 0;
    select count(*) into victories
    from Matches
    where (HomeTeam_id=teamID and HomeScore>AwayScore) or (AwayTeam_id=teamID and AwayScore>HomeScore);
    RETURN victories;
END$$
delimiter ; 



select getTeamName(30000);

select getLeagueName(4);

select getTeamName(30),getVictories(30);

create database myfuncs;

use myfuncs;

delimiter $$ 
CREATE FUNCTION maior2(n1 INT,n2 INT)
RETURNS int
DETERMINISTIC
BEGIN
	IF n1>n2 then
		return n1;
	else
		return n2;
	end if;

END$$
delimiter ;

select maior2(23,45);



