/*1. Construa uma função na base de dados EuropeFootballLeagues que devolva opcionalmente o
número de jogos jogados em casa ou fora de casa para uma dada equipa.*/

DELIMITER $$

CREATE FUNCTION contMatches(team_id INT, home_or_away VARCHAR(4)) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE match_count INT DEFAULT 0;

    IF home_or_away = 'home' THEN  
        SELECT COUNT(*) INTO match_count
        FROM Matches
        WHERE HomeTeam_id = team_id;
    ELSEIF home_or_away = 'away' THEN 
        SELECT COUNT(*) INTO match_count
        FROM Matches
        WHERE AwayTeam_id = team_id;
    END IF;

    RETURN match_count;
END$$ 

DELIMITER ;

DROP function contMatches;
SELECT contMatches(16, 'home');  

/*2.Construa uma função na base de dados EuropeFootballLeagues que devolva opcionalmente o
número de vitórias em casa ou fora de casa para uma dada equipa.*/

DELIMITER $$

CREATE FUNCTION numVictories(team_id INT, home_or_away VARCHAR(4)) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE victories INT DEFAULT 0;
    IF home_or_away = 'home' THEN  
        SELECT COUNT(*) INTO victories
        FROM Matches
        WHERE HomeScore > AwayScore;
    ELSEIF home_or_away = 'away' THEN 
        SELECT COUNT(*) INTO victories
        FROM Matches
        WHERE HomeScore < AwayScore;
    END IF;

    RETURN victories;
END$$ 

DELIMITER ;

DROP function numVictories;

SELECT numVictories(16, 'home'); 
