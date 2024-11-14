-- Ficha 03

USE myfuncs;

CREATE TABLE initialDigitsNIF(id INT NOT NULL);
INSERT INTO initialDigitsNIF(ID) VALUES(1);
INSERT INTO initialDigitsNIF(ID) VALUES(2);
INSERT INTO initialDigitsNIF(ID) VALUES(3);
INSERT INTO initialDigitsNIF(ID) VALUES(4);
INSERT INTO initialDigitsNIF(ID) VALUES(5);
INSERT INTO initialDigitsNIF(ID) VALUES(6);
INSERT INTO initialDigitsNIF(ID) VALUES(45);
INSERT INTO initialDigitsNIF(ID) VALUES(70);
INSERT INTO initialDigitsNIF(ID) VALUES(71);
INSERT INTO initialDigitsNIF(ID) VALUES(72);
INSERT INTO initialDigitsNIF(ID) VALUES(74);
INSERT INTO initialDigitsNIF(ID) VALUES(75);
INSERT INTO initialDigitsNIF(ID) VALUES(77);
INSERT INTO initialDigitsNIF(ID) VALUES(78);
INSERT INTO initialDigitsNIF(ID) VALUES(79);
INSERT INTO initialDigitsNIF(ID) VALUES(90);
INSERT INTO initialDigitsNIF(ID) VALUES(91);
INSERT INTO initialDigitsNIF(ID) VALUES(98);
INSERT INTO initialDigitsNIF(ID) VALUES(99);

SELECT * FROM initialDigitsNIF;

DELIMITER $$
CREATE FUNCTION	teste (n INT)
	RETURNS BOOLEAN
    DETERMINISTIC 
    BEGIN
		IF n NOT IN(1,2,3,4,5,6,7,8,9,10) THEN	
			RETURN FALSE;
		ELSE
			RETURN TRUE;
		END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE	FUNCTION check_nif(nif INT)
RETURNS BOOLEAN
	DETERMINISTIC
	BEGIN
    DECLARE  i INT  DEFAULT 1;
	DECLARE res INT DEFAULT 0;
		IF LENGTH(nif)<>9 
			OR NOT EXISTS  -- SE O COMPRIMENTO FOR DIFERENTE DE NOVE VA A TABELA E RETORNE A SUBSTRITNT 1
			(SELECT ID FROM initialDigitsNIF 
			WHERE SUBSTR(nif,1,1)=ID 
			OR SUBSTR(nif,1,2)=ID)THEN
			RETURN FALSE;
			END IF;
            
        WHILE i < 9 DO
			SET res = res + SUBSTR(nif, i, 1) * (9 - i + 1);
            SET i = i + 1;
		END WHILE;
        SET res=res MOD 11;
			IF res < 2 THEN
			SET res=0;
		ELSE
			SET res=11 - res;
		END IF;
			IF SUBSTR(nif, 9, 1)= res THEN
				RETURN TRUE;
			ELSE
				RETURN FALSE;
			END IF;
    END$$
DELIMITER ;

SELECT check_nif(321299833);
SELECT check_nif(211299833);
    
USE EuropeFootballLeagues;

DELIMITER $$
CREATE PROCEDURE ListVictories(INT id, INT, OUT victories INT)
BEGIN
	SELECT getVictories(id, TRUE) + getVictories(id, FALSE) INTO victories;
    
    SELECT 
		getTeamName(HomeTeam_id) 
        HomeTeam, HomeScore, 
        getTeamName(AwayTeam_id) 
        AwayTeam, AwayScore, DATE
    
    FROM Matches
    
    WHERE (HomeTeam_id=id 
			AND HomeScore>AwayScore) OR
            (AwayTeam_id=id AND 
            (AwayScore>Home);
END$$
DELIMITER ;

CALL ListVictories(1, @vict);
SELECT @vict;