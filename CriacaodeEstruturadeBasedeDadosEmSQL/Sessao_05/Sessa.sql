USE myfuncs;

CREATE TABLE initialDigitsCC(id INT NOT NULL);

/*
Formato: DDDDDDDD C AAT
Onde:
D- Número de Identificação Civil [0.. 9]
C – Check Digit do Número de Identificação Civil [0.. 9]
A – Versão [A.. Z, 0.. 9]
T – Check Digit Número de Documento [0.. 9]
*/

CREATE TABLE initialDigitsCC(id INT NOT NULL);
INSERT INTO initialDigitsCC(id) VALUES(1);
INSERT INTO initialDigitsCC(id) VALUES(2);
INSERT INTO initialDigitsCC(id) VALUES(3);
INSERT INTO initialDigitsCC(id) VALUES(4);
INSERT INTO initialDigitsCC(id) VALUES(5);
INSERT INTO initialDigitsCC(id) VALUES(6);
INSERT INTO initialDigitsCC(id) VALUES(7);
INSERT INTO initialDigitsCC(id) VALUES(8);
INSERT INTO initialDigitsCC(id) VALUES(9);
INSERT INTO initialDigitsCC(id) VALUES(10);
INSERT INTO initialDigitsCC(id) VALUES(11);
INSERT INTO initialDigitsCC(id) VALUES(12);

drop function validar_cc;

DELIMITER $$

CREATE FUNCTION validar_cc(cc VARCHAR(255))
RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    DECLARE valor INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE len INT;
    DECLARE num CHAR(1);
    DECLARE letra CHAR(1);
    DECLARE letra_valor INT;
    
    -- Remover espaços
    SET cc = REPLACE(cc, ' ', '');
    
    -- Tamanho da string sem espaços
    SET len = CHAR_LENGTH(cc);
    
    -- Loop para processar cada caractere
    WHILE i <= len DO
        SET num = SUBSTRING(cc, i, 1);
        
        -- Se for um número, apenas adicione ele na soma
        IF num REGEXP '[0-9]' THEN
            SET valor = valor + CAST(num AS UNSIGNED);
        ELSE
            -- Se for uma letra, converta para o valor correspondente na tabela
            SET letra = UPPER(num); -- Para garantir que seja maiúsculo
            CASE letra
                WHEN 'A' THEN SET letra_valor = 10;
                WHEN 'B' THEN SET letra_valor = 11;
                WHEN 'C' THEN SET letra_valor = 12;
                WHEN 'D' THEN SET letra_valor = 13;
                WHEN 'E' THEN SET letra_valor = 14;
                WHEN 'F' THEN SET letra_valor = 15;
                WHEN 'G' THEN SET letra_valor = 16;
                WHEN 'H' THEN SET letra_valor = 17;
                WHEN 'I' THEN SET letra_valor = 18;
                WHEN 'J' THEN SET letra_valor = 19;
                WHEN 'K' THEN SET letra_valor = 20;
                WHEN 'L' THEN SET letra_valor = 21;
                WHEN 'M' THEN SET letra_valor = 22;
                WHEN 'N' THEN SET letra_valor = 23;
                WHEN 'O' THEN SET letra_valor = 24;
                WHEN 'P' THEN SET letra_valor = 25;
                WHEN 'Q' THEN SET letra_valor = 26;
                WHEN 'R' THEN SET letra_valor = 27;
                WHEN 'S' THEN SET letra_valor = 28;
                WHEN 'T' THEN SET letra_valor = 29;
                WHEN 'U' THEN SET letra_valor = 30;
                WHEN 'V' THEN SET letra_valor = 31;
                WHEN 'W' THEN SET letra_valor = 32;
                WHEN 'X' THEN SET letra_valor = 33;
                WHEN 'Y' THEN SET letra_valor = 34;
                WHEN 'Z' THEN SET letra_valor = 35;
                ELSE SET letra_valor = 0; -- Caso a letra não seja válida
            END CASE;

            -- Multiplicação por 2 e ajuste (subtrair 9, se necessário)
            SET letra_valor = letra_valor * 2;
            IF letra_valor > 9 THEN
                SET letra_valor = letra_valor - 9;
            END IF;
            
            -- Adiciona o valor da letra
            SET valor = valor + letra_valor;
        END IF;

        -- Incrementa o contador
        SET i = i + 1;
    END WHILE;
    
    -- Passo 3: Verifica se o valor final mod 10 é 0 (dígito de verificação válido)
    IF valor MOD 10 = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END$$

DELIMITER ;



SELECT validar_cc('00000000 0 ZZ4');

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
            
        
    END$$
DELIMITER ;


DELIMITER $$

CREATE FUNCTION validar_numero_documento_cc(numeroDocumento VARCHAR(255))
RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE secondDigit BOOLEAN DEFAULT FALSE;
    DECLARE valor INT;
    DECLARE letra CHAR(1);

    -- Verificar o tamanho do número de documento
    IF CHAR_LENGTH(numeroDocumento) != 12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tamanho inválido para número de documento.';
    END IF;

    -- Loop para processar cada caractere do número de documento
    WHILE i <= CHAR_LENGTH(numeroDocumento) DO
        SET letra = SUBSTRING(numeroDocumento, i, 1);
        
        -- Obter o valor do caractere
        SET valor = GetNumberFromChar(letra);

        -- Se o dígito for o segundo, multiplicar por 2 e ajustar se necessário
        IF secondDigit THEN
            SET valor = valor * 2;
            IF valor > 9 THEN
                SET valor = valor - 9;
            END IF;
        END IF;

        -- Adicionar o valor à soma total
        SET sum = sum + valor;

        -- Alternar entre o primeiro e o segundo dígito
        SET secondDigit = NOT secondDigit;

        -- Incrementar o índice
        SET i = i + 1;
    END WHILE;

    -- Validar se a soma é divisível por 10
    IF sum % 10 = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END$$

DELIMITER ;

-- Função auxiliar para obter o valor numérico de cada caractere
DELIMITER $$

DELIMITER $$

CREATE FUNCTION validar_numero(numeroDocumento VARCHAR(255))
RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE secondDigit BOOLEAN DEFAULT FALSE;
    DECLARE valor INT;
    DECLARE letra CHAR(1);

    -- Verificar o tamanho do número de documento
    IF CHAR_LENGTH(numeroDocumento) != 12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tamanho inválido para número de documento.';
    END IF;

    -- Loop para processar cada caractere do número de documento
    WHILE i <= CHAR_LENGTH(numeroDocumento) DO
        SET letra = SUBSTRING(numeroDocumento, i, 1);
        
        -- Obter o valor do caractere
        SET valor = GetNumberFromChar(letra);

        -- Se o dígito for o segundo, multiplicar por 2 e ajustar se necessário
        IF secondDigit THEN
            SET valor = valor * 2;
            IF valor > 9 THEN
                SET valor = valor - 9;
            END IF;
        END IF;

        -- Adicionar o valor à soma total
        SET sum = sum + valor;

        -- Alternar entre o primeiro e o segundo dígito
        SET secondDigit = NOT secondDigit;

        -- Incrementar o índice
        SET i = i + 1;
    END WHILE;

    -- Validar se a soma é divisível por 10
    IF sum % 10 = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END$$

DELIMITER ;

-- Função auxiliar para obter o valor numérico de cada caractere
DELIMITER $$

CREATE FUNCTION GetNumberFromChar(letra CHAR(1))
RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE valor INT;

    -- Converter o caractere para o valor correspondente
    CASE letra
        WHEN '0' THEN SET valor = 0;
        WHEN '1' THEN SET valor = 1;
        WHEN '2' THEN SET valor = 2;
        WHEN '3' THEN SET valor = 3;
        WHEN '4' THEN SET valor = 4;
        WHEN '5' THEN SET valor = 5;
        WHEN '6' THEN SET valor = 6;
        WHEN '7' THEN SET valor = 7;
        WHEN '8' THEN SET valor = 8;
        WHEN '9' THEN SET valor = 9;
        WHEN 'A' THEN SET valor = 10;
        WHEN 'B' THEN SET valor = 11;
        WHEN 'C' THEN SET valor = 12;
        WHEN 'D' THEN SET valor = 13;
        WHEN 'E' THEN SET valor = 14;
        WHEN 'F' THEN SET valor = 15;
        WHEN 'G' THEN SET valor = 16;
        WHEN 'H' THEN SET valor = 17;
        WHEN 'I' THEN SET valor = 18;
        WHEN 'J' THEN SET valor = 19;
        WHEN 'K' THEN SET valor = 20;
        WHEN 'L' THEN SET valor = 21;
        WHEN 'M' THEN SET valor = 22;
        WHEN 'N' THEN SET valor = 23;
        WHEN 'O' THEN SET valor = 24;
        WHEN 'P' THEN SET valor = 25;
        WHEN 'Q' THEN SET valor = 26;
        WHEN 'R' THEN SET valor = 27;
        WHEN 'S' THEN SET valor = 28;
        WHEN 'T' THEN SET valor = 29;
        WHEN 'U' THEN SET valor = 30;
        WHEN 'V' THEN SET valor = 31;
        WHEN 'W' THEN SET valor = 32;
        WHEN 'X' THEN SET valor = 33;
        WHEN 'Y' THEN SET valor = 34;
        WHEN 'Z' THEN SET valor = 35;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor inválido no número de documento.';
    END CASE;

    RETURN valor;
END$$

DELIMITER ;

drop function validar_numero;

DELIMITER $$

CREATE FUNCTION validar_numero(numeroDocumento VARCHAR(255))
RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE secondDigit BOOLEAN DEFAULT FALSE;
    DECLARE valor INT;
    DECLARE letra CHAR(1);

    -- Verificar o tamanho do número de documento
    IF CHAR_LENGTH(numeroDocumento) != 12 THEN
        RETURN FALSE; -- Retorna FALSE caso o tamanho seja inválido
    END IF;

    -- Loop para processar cada caractere do número de documento
    WHILE i <= CHAR_LENGTH(numeroDocumento) DO
        SET letra = SUBSTRING(numeroDocumento, i, 1);
        
        -- Obter o valor do caractere
        SET valor = GetNumberFromChar(letra);

        -- Se o dígito for o segundo, multiplicar por 2 e ajustar se necessário
        IF secondDigit THEN
            SET valor = valor * 2;
            IF valor > 9 THEN
                SET valor = valor - 9;
            END IF;
        END IF;

        -- Adicionar o valor à soma total
        SET sum = sum + valor;

        -- Alternar entre o primeiro e o segundo dígito
        SET secondDigit = NOT secondDigit;

        -- Incrementar o índice
        SET i = i + 1;
    END WHILE;

    -- Validar se a soma é divisível por 10
    IF sum % 10 = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END$$

DELIMITER ;

-- Função auxiliar para obter o valor numérico de cada caractere
DELIMITER $$


CREATE FUNCTION GetNumberFromChar(letra CHAR(1))
RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE valor INT;

    -- Converter o caractere para o valor correspondente
    CASE letra
        WHEN '0' THEN SET valor = 0;
        WHEN '1' THEN SET valor = 1;
        WHEN '2' THEN SET valor = 2;
        WHEN '3' THEN SET valor = 3;
        WHEN '4' THEN SET valor = 4;
        WHEN '5' THEN SET valor = 5;
        WHEN '6' THEN SET valor = 6;
        WHEN '7' THEN SET valor = 7;
        WHEN '8' THEN SET valor = 8;
        WHEN '9' THEN SET valor = 9;
        WHEN 'A' THEN SET valor = 10;
        WHEN 'B' THEN SET valor = 11;
        WHEN 'C' THEN SET valor = 12;
        WHEN 'D' THEN SET valor = 13;
        WHEN 'E' THEN SET valor = 14;
        WHEN 'F' THEN SET valor = 15;
        WHEN 'G' THEN SET valor = 16;
        WHEN 'H' THEN SET valor = 17;
        WHEN 'I' THEN SET valor = 18;
        WHEN 'J' THEN SET valor = 19;
        WHEN 'K' THEN SET valor = 20;
        WHEN 'L' THEN SET valor = 21;
        WHEN 'M' THEN SET valor = 22;
        WHEN 'N' THEN SET valor = 23;
        WHEN 'O' THEN SET valor = 24;
        WHEN 'P' THEN SET valor = 25;
        WHEN 'Q' THEN SET valor = 26;
        WHEN 'R' THEN SET valor = 27;
        WHEN 'S' THEN SET valor = 28;
        WHEN 'T' THEN SET valor = 29;
        WHEN 'U' THEN SET valor = 30;
        WHEN 'V' THEN SET valor = 31;
        WHEN 'W' THEN SET valor = 32;
        WHEN 'X' THEN SET valor = 33;
        WHEN 'Y' THEN SET valor = 34;
        WHEN 'Z' THEN SET valor = 35;
        ELSE
            RETURN -1; -- Retorna um valor inválido
    END CASE;

    RETURN valor;
END$$

DELIMITER ;


SELECT validar_numero('00000000ZZ4');
					   000000000ZZ4

drop function validacaocc;

SELECT validacaocc('000000000ZZ4');
					

DELIMITER $$

-- Função para validar o número do cartão de cidadão
CREATE FUNCTION validacaocc(numero VARCHAR(255))
RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE sum INT DEFAULT 0;
    DECLARE secondDigit BOOLEAN DEFAULT FALSE;
    DECLARE valor INT;
    DECLARE digit CHAR(1);

    -- Remover espaços do número do cartão
    SET numero = REPLACE(numero, ' ', '');

    -- Verificar se o comprimento do número é válido (exemplo: 12 dígitos)
    IF CHAR_LENGTH(numero) != 12 THEN
        RETURN FALSE;
    END IF;

    -- Processar cada caractere do número
    WHILE i <= CHAR_LENGTH(numero) DO
        SET digit = SUBSTRING(numero, i, 1);

        -- Converter o caractere para um valor numérico
        SET valor = CAST(digit AS UNSIGNED);

        -- Se o dígito for o segundo (segundo de trás para frente), multiplicar por 2 e ajustar se necessário
        IF secondDigit THEN
            SET valor = valor * 2;
            IF valor > 9 THEN
                SET valor = valor - 9;
            END IF;
        END IF;

        -- Adicionar o valor à soma total
        SET sum = sum + valor;

        -- Alternar entre o primeiro e o segundo dígito (sempre alternando os dígitos)
        SET secondDigit = NOT secondDigit;

        -- Incrementar o índice
        SET i = i + 1;
    END WHILE;

    -- Verificar se a soma é divisível por 10
    IF sum % 10 = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END$$

DELIMITER ;


