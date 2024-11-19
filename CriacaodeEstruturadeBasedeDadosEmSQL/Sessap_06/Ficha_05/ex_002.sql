DELIMITER $$

CREATE FUNCTION cartaoDeCredito(cartao VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    -- Verificar o tamanho do cartão
    DECLARE tamanho INT;
    SET tamanho = CHAR_LENGTH(cartao);
    
    -- Retornar asteriscos para os dígitos exceto os últimos 4
    RETURN CONCAT(REPEAT('*', tamanho - 4), RIGHT(cartao, 4));
END$$

DELIMITER ;

SELECT cartaoDeCredito('1234567812345678'); -- Saída: ************5678
SELECT cartaoDeCredito('987654321098');     -- Saída: ********1098

