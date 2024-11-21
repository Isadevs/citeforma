DELIMITER $$

CREATE FUNCTION extrair_primeiro_ultimo(nome_completo VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE primeiro_nome VARCHAR(255);
    DECLARE ultimo_nome VARCHAR(255);
    DECLARE resultado VARCHAR(255);
    
    -- Extrair o primeiro nome (primeira palavra antes do primeiro espaço)
    SET primeiro_nome = SUBSTRING_INDEX(nome_completo, ' ', 1);
    
    -- Extrair o último nome (última palavra após o último espaço)
    SET ultimo_nome = SUBSTRING_INDEX(nome_completo, ' ', -1);
    
    -- Combinar primeiro e último nome
    SET resultado = CONCAT(primeiro_nome, ' ', ultimo_nome);
    
    RETURN resultado;
END$$

DELIMITER ;

SELECT extrair_primeiro_ultimo('Isabella Cristina Rodrigues Ramos Muniz Gonçalves');
