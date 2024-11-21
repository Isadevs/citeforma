DELIMITER $$

CREATE FUNCTION calcular_idade(data_nascimento DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;

    -- Calcula a idade em anos completos
    SET idade = TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());

    -- Ajusta a idade se o aniversário ainda não aconteceu neste ano
    IF DATE_ADD(data_nascimento, INTERVAL idade YEAR) > CURDATE() THEN
        SET idade = idade - 1;
    END IF;

    RETURN idade;
END$$

DELIMITER ;
