show tables;

select count(*) 'Total Equipas' from Teams;

desc Leagues;
desc Teams;
desc Matches;

SELECT L.league, count(*)
	FROM Teams T
INNER JOIN Leagues L ON L.id=T.league_id
GROUP BY L.league; -- agrupa por league

SELECT T.team, count(*) Matches
	FROM Teams T
	INNER JOIN Matches M 
    ON T.id=M.HomeTeam_id 
	OR T.id=M.AwayTeam_id
        -- exclusão de jogos que ainda não foram realizados:
    AND M.DATE IS NOT NULL
    
GROUP BY T.team;

SELECT T.team, count(*) Matches
	FROM Teams T
	INNER JOIN Matches M 
    ON T.id=M.HomeTeam_id 
	OR T.id=M.AwayTeam_id
        -- exclusão de jogos que ainda não foram realizados:
    AND M.DATE IS NOT NULL
    INNER JOIN Leagues L ON L.id=T.league_id
    WHERE L.league='La Liga'
GROUP BY T.team;


