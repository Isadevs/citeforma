CREATE TABLE Cliente(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	telefone VARCHAR(20),
	email VARCHAR(50)
);

CREATE TABLE Conta(
	id INT NOT NULL AUTO_INCREMENT,
	conta_id INT NOT NULL,
	saldo DECIMAL(10,2) DEFAULT 0.0,
	PRIMARY KEY(id),
	FOREIGN KEY (conta_id) REFERENCES Cliente(id)
);

CREATE TABLE Movimento(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    conta_id INT NOT NULL,
	DataMovimento DATETIME DEFAULT now(),
    saldoAnterior DECIMAL(10,2),
    saldoAtual DECIMAL(10,2),
	valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(conta_id) REFERENCES Conta(id)
);

ALTER TABLE Movimento ADD COLUMN saldoAnterior DECIMAL(10,2);
ALTER TABLE Movimento ADD COLUMN saldoAtual DECIMAL(10,2);

CREATE TABLE Movimento_log (
    movimento_id INT NOT NULL PRIMARY KEY,
    modificacao VARCHAR(200),
    DataMovimento DATETIME,
    userName CHAR(32)
);

/*Trigger será adicionado antes de INSERT para que o movimento possa ser DISPARADO:*/
DELIMITER $$

CREATE TRIGGER BeforeInsertMovimento 
BEFORE INSERT ON Movimento 
FOR EACH ROW 
BEGIN
    SET NEW.saldoAnterior = (SELECT saldo FROM Conta WHERE id = NEW.conta_id);
    UPDATE Conta SET saldo = saldo + NEW.valor WHERE id = NEW.conta_id;
    SET NEW.saldoAtual = (SELECT saldo FROM Conta WHERE id = NEW.conta_id);
END $$

DELIMITER ;

DELIMITER $$
/*Vai modificar uma LINHA EXISTENTE, que no caso é o valor do MOVIMENTO, e eu quero que esse TRIGGER
ex: tinha depositado OLD.75  e me enganei e agora quero depositar NEW.100
eu quero corrigir o saldo, que eu me enganei
OLD=São valores antes  da modificação (update)
NEW=São valores depois da modificação (update)
*/
CREATE TRIGGER BeforeUpdateMovimento 
BEFORE INSERT ON Movimento 
FOR EACH ROW 
BEGIN
    SET NEW.saldoAnterior = (SELECT saldo FROM Conta WHERE id = NEW.conta_id);
    UPDATE Conta SET saldo = saldo.OLD.valor + NEW.valor WHERE id = NEW.conta_id;
    SET NEW.saldoAtual = (SELECT saldo FROM Conta WHERE id = NEW.conta_id);
END $$

DELIMITER ;

/*Para eliminar um movimento vou por o saldo como estava antes desse movimento*/

DELIMITER $$

CREATE TRIGGER BeforeDeleteMovimento -- criei um trigger chamado BeforeDeleteMovimento (antes de detar o movimento)
BEFORE DELETE ON Movimento -- antes de deletar na tabela Movimento
FOR EACH ROW -- em cada registro ou em cada linha, de cada coluna
BEGIN -- isto significa {
    UPDATE Conta -- atualize a conta de cada cliente
    SET saldo = saldo + OLD.valor 
    WHERE id = OLD.conta_id; 
END $$

DELIMITER ;

DELIMITER $$
CREATE TRIGGER AfterInsertMovimentoLog
AFTER INSERT ON Movimento FOR EACH ROW -- depois do INSERT movimento é realizado
BEGIN
	DECLARE Modif VARCHAR(200);
	SET Modif=CONCAT_WS( ' ; ', NEW.valor, NEW.saldoAnterior, NEW.saldoAtual, 'INSERTED'); 
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
    VALUES (NEW.id, Modif, NEW.DataMovimento, USER());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER AfterUpdateMovimentoLog
AFTER INSERT ON Movimento FOR EACH ROW -- depois do INSERT movimento é realizado
BEGIN
	DECLARE Modif VARCHAR(200);
	SET Modif=CONCAT_WS( ' ; ', NEW.valor, NEW.saldoAnterior, NEW.saldoAtual, 'UPDATE'); 
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
    VALUES (NEW.id, Modif, NEW.DataMovimento, USER());
END$$

DELIMITER ;

SELECT * FROM Movimento_log;

/*Inserindo os dados na tabela Cliente: */
INSERT INTO Cliente(nome,telefone,email) VALUES('Joaquim Dias','+351 963456789','jdias@mail.pt');
INSERT INTO Cliente(nome,telefone,email) VALUES('Maria Pereira','+351 923456789','mpereira@mail.pt');
INSERT INTO Cliente(nome,telefone,email) VALUES('Rosa Maria','+351 923456789','rosamaria@mail.pt');
INSERT INTO Cliente(nome,telefone,email) VALUES('Victor Rodrigues','+351 923456789','victor@mail.pt');

/*Inserindo os dados na tabela Conta dos Clientes: */
INSERT INTO Conta(conta_id,saldo) VALUES(1,5000);
INSERT INTO Conta(conta_id,saldo) VALUES(2,15000);
INSERT INTO Conta(conta_id,saldo) VALUES(3,5000);
INSERT INTO Conta(conta_id,saldo) VALUES(4,15000);

/*Inserindo os dados na tabela dos Movimentos e isto é o que vai executar o Trigger e atualizar o saldo da conta do Cliente: */
INSERT INTO Movimento(conta_id,valor) values(1,500);
INSERT INTO Movimento(conta_id,valor) values(2,-200);
INSERT INTO Movimento(conta_id,valor) values(3,1500);
INSERT INTO Movimento(conta_id,valor) values(4,-200);

SELECT Conta.id,nome,saldo FROM Conta INNER JOIN Cliente on Conta.cliente_id=Cliente.id;

/*Agora vamos conferir se as tabelas estão funcionando: */
SELECT * FROM Cliente;
SELECT * FROM Conta;
SELECT * FROM Movimento;




