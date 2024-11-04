/*1. Crie a tabela River_log(id,modification,datetime,user) 
na base de dados SalmonRiver.*/

/*Mostrando as tabelas disponíveis*/
SHOW DATABASES;

/*Selecionando o usuario:*/
USE SalmonRiver;

CREATE TABLE River_log (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_River INT NOT NULL,
    modification VARCHAR(200),
    date_time DATETIME,
    userName VARCHAR(255)
);

/*2. Crie os TRIGGERS necessários para o preenchimento da tabela 
River_log acionados depois de INSERT,UPDATE e DELETE.*/

-- TRIGGER AFTER INSERT IN RIVER
DELIMITER $$
CREATE TRIGGER AfterInsertRiver
AFTER INSERT ON River FOR EACH ROW -- depois do INSERT movimento é realizado
BEGIN
	DECLARE Modif VARCHAR(200);
    SET Modif = CONCAT_WS(' ; ', NEW.Name, NEW.Location, NEW.CountryID, NEW.CategoryID, 'INSERTED');
    -- Modif é uma variavel auxiliar que vai retornar uma string concatenada na variável Modif
    -- A Função de concatenação separador entre as strings que eu vou concatenar, 
    -- A ideia é fazer um histórico das movimentações para a tabela log_movimentações
    -- CONCAT_WS é mais vantajosa que posso usar uma substring para realizar o separador
    INSERT INTO River_log( -- Insira dentro da tabela  Movimento_log
		id_River, -- campo movimento_id
        modification, -- campo modificacao
        date_time, -- campo DataMovimento
        userName -- campo user Name
	)
    VALUES (NEW.id, Modif, NOW(), USER());/*campos que vem da tabela River*/
END$$
DELIMITER ;

-- TRIGGER AFTER UPDADE IN RIVER
DELIMITER $$
CREATE TRIGGER AfterUpdateRiver
AFTER UPDATE ON River FOR EACH ROW -- depois do UPDATE movimento é realizado
BEGIN
	DECLARE Modif VARCHAR(200);
	SET Modif=CONCAT_WS( ' ; ', NEW.Name, NEW.Location, NEW.CountryID, NEW.CategoryID, 'UPDATE'); 
    -- Modif é uma variavel auxiliar que vai retornar uma string concatenada na variável Modif
    -- A Função de concatenação separador entre as strings que eu vou concatenar, 
    -- A ideia é fazer um histórico das movimentações para a tabela log_movimentações
    -- CONCAT_WS é mais vantajosa que posso usar uma substring para realizar o separador
    INSERT INTO River_log( -- Insira dentro da tabela  Movimento_log
		id_River, -- campo movimento_id
        modification, -- campo modificacao
        date_time, -- campo DataMovimento
        userName -- campo user Name
	)
    VALUES (NEW.id, Modif, NOW(), USER());
END$$
DELIMITER $$

DELIMITER $$
CREATE TRIGGER AfterDeleteRiver
-- Após uma deleção na tabela Movimento este Trigger será acionado:
AFTER DELETE ON River FOR EACH ROW -- depois do UPDATE movimento é realizado
BEGIN
	DECLARE Modif VARCHAR(200);
	SET Modif=CONCAT_WS( ' ; ', OLD.Name, OLD.Location, OLD.CountryID, OLD.CategoryID, 'DELETE'); 
    -- Modif é uma variavel auxiliar que vai retornar uma string concatenada na variável Modif
    -- A Função de concatenação separador entre as strings que eu vou concatenar, 
    -- A ideia é fazer um histórico das movimentações para a tabela log_movimentações
    -- CONCAT_WS é mais vantajosa que posso usar uma substring para realizar o separador
    INSERT INTO Movimento_log( -- Insira dentro da tabela  Movimento_log
		movimento_id, -- campo movimento_id
        modificacao, -- campo modificacao
        DataMovimento, -- campo DataMovimento
        userName -- campo user Name
	)
    VALUES (OLD.id, Modif, NOW(), USER());
END$$
DELIMITER ; 


