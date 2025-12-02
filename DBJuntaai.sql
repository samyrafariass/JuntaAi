CREATE DATABASE DBJuntaai;
GO
USE DBJuntaai;

 --Tabelas

CREATE TABLE Usuaria (Id_Usuaria INTEGER PRIMARY KEY IDENTITY(1000,1),
					  Nome VARCHAR(50) NOT NULL,
					  Data_Nascimento DATE NOT NULL,
					  Telefone VARCHAR(15),
					  CEP VARCHAR(10) NOT NULL,
					  Rua_Avenida VARCHAR(30) NOT NULL,
					  Num_Imovel INTEGER NOT NULL,
					  Bairro VARCHAR(30) NOT NULL,
					  Cidade VARCHAR(30) NOT NULL,
					  Estado VARCHAR(2) NOT NULL,
					  Email VARCHAR(30) UNIQUE NOT NULL,
					  Senha VARCHAR(256) NOT NULL);


CREATE TABLE Rede_Apoio (Id_Rede_Apoio INTEGER PRIMARY KEY IDENTITY(1000,1),
						 Nome VARCHAR(50) NOT NULL,
						 Responsavel VARCHAR(30) NOT NULL,
						 Descricao VARCHAR(100) NOT NULL,
						 Telefone VARCHAR(15) NOT NULL,
						 CEP VARCHAR(10) NOT NULL,
						 Rua_Avenida VARCHAR(30) NOT NULL,
					     Num_Imovel INTEGER NOT NULL,
					     Bairro VARCHAR(30) NOT NULL,
					     Cidade VARCHAR(30) NOT NULL,
					     Estado VARCHAR(2) NOT NULL,
						 Horario VARCHAR(15) NOT NULL);


CREATE TABLE Conteudo_Informativo (Id_Conteudo INTEGER PRIMARY KEY IDENTITY(1000,1),
								   Conteudo VARCHAR(30) NOT NULL,
								   Descricao VARCHAR(100) NOT NULL,
								   Data_Hora DATETIME DEFAULT GETDATE());


CREATE TABLE Tipo_Violencia (Id_Tipo_Violencia INTEGER PRIMARY KEY IDENTITY(1000,1),
						     Sessao INTEGER NOT NULL,
							 Pergunta VARCHAR(50) NOT NULL,
							 Resposta VARCHAR(50) NOT NULL,
							 Status BIT);


CREATE TABLE Classificacao (Id_Classificacao INTEGER PRIMARY KEY IDENTITY(1000,1),
					        Descricao VARCHAR(100) NOT NULL,
							Telefone VARCHAR(15) NOT NULL,
							CEP VARCHAR(10) NOT NULL,
						    Rua_Avenida VARCHAR(30) NOT NULL,
					        Num_Imovel INTEGER NOT NULL,
					        Bairro VARCHAR(30) NOT NULL,
					        Cidade VARCHAR(30) NOT NULL,
					        Estado VARCHAR(2) NOT NULL);


CREATE TABLE Orgao (Id_Orgao INTEGER PRIMARY KEY IDENTITY(1000,1),
				    Nome VARCHAR(50) NOT NULL,
					Descricao_Alerta VARCHAR(100) NOT NULL,
					Solicitacao BIT DEFAULT 0,
					Id_Classificacao INTEGER NOT NULL,
					FOREIGN KEY (Id_Classificacao) REFERENCES Classificacao(Id_Classificacao));


CREATE TABLE Alerta (Id_Alerta INTEGER PRIMARY KEY IDENTITY(1000,1),
			         Status_Alerta BIT NOT NULL,
					 Data_Hora DATETIME DEFAULT GETDATE(),
					 CEP VARCHAR(10) NOT NULL,
					 Rua_Avenida VARCHAR(30) NOT NULL,
					 Num_Imovel INTEGER NOT NULL,
					 Bairro VARCHAR(30) NOT NULL,
					 Cidade VARCHAR(30) NOT NULL,
					 Estado VARCHAR(2) NOT NULL,
					 Id_Orgao INTEGER NOT NULL,
					 Id_Usuaria INTEGER NOT NULL,
					 FOREIGN KEY (Id_Orgao) REFERENCES Orgao(Id_Orgao),
					 FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria));


CREATE TABLE Denuncia (Id_Denuncia INTEGER PRIMARY KEY IDENTITY(1000,1),
			           Violencia_Sofrida VARCHAR(20) CHECK (Violencia_Sofrida = 'Física' OR Violencia_Sofrida = 'Psicológica' OR Violencia_Sofrida = 'Sexual' OR Violencia_Sofrida = 'Patrimonial' OR Violencia_Sofrida = 'Moral') NOT NULL,
					   Situacao_Atual VARCHAR(15) CHECK (Situacao_Atual = 'Em perigo' OR Situacao_Atual = 'Controlada' OR Situacao_Atual = 'Fora de perigo') NOT NULL,
					   Descricao VARCHAR(100) NOT NULL,
					   Data_Hora DATETIME DEFAULT GETDATE(),
					   Status_Denuncia BIT DEFAULT 0,
					   Id_Orgao INTEGER NOT NULL,
					   FOREIGN KEY (Id_Orgao) REFERENCES Orgao(Id_Orgao));


--Tabelas Associativas

CREATE TABLE Utiliza_Rede_Apoio_Usuaria (Id_Rede_Apoio INTEGER NOT NULL,
									       Id_Usuaria INTEGER NOT NULL,
									       FOREIGN KEY (Id_Rede_Apoio) REFERENCES Rede_Apoio(Id_Rede_Apoio) ON DELETE NO ACTION,
									       FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria) ON DELETE CASCADE,
									       PRIMARY KEY (Id_Rede_Apoio, Id_Usuaria));


CREATE TABLE Acessa_Usuaria_Conteudo (Id_Usuaria INTEGER NOT NULL,
										Id_Conteudo INTEGER NOT NULL,
										Data_Acesso DATETIME DEFAULT GETDATE(),
										FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria),
										FOREIGN KEY (Id_Conteudo) REFERENCES Conteudo_Informativo(Id_Conteudo),
										PRIMARY KEY (Id_Usuaria, Id_Conteudo));


CREATE TABLE Sofre_Tipo_Violencia_Usuaria (Id_Usuaria INTEGER NOT NULL,
											Id_Tipo_Violencia INTEGER NOT NULL,
											FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria) ON DELETE NO ACTION,
											FOREIGN KEY (Id_Tipo_Violencia) REFERENCES Tipo_Violencia(Id_Tipo_Violencia) ON DELETE CASCADE,
											PRIMARY KEY (Id_Usuaria, Id_Tipo_Violencia));

--Permitir que a usuária seja NULL no back
CREATE TABLE Gera_Denuncia_Usuaria (Id_Usuaria INT,
									  Id_Denuncia INT NOT NULL,
								      FOREIGN KEY(Id_Usuaria) REFERENCES Usuaria(Id_Usuaria),
									  FOREIGN KEY(Id_Denuncia) REFERENCES Denuncia(Id_Denuncia) ON DELETE CASCADE,
									  PRIMARY KEY (Id_Usuaria, Id_Denuncia));


 -- Alimentando as Tabelas

INSERT INTO 
	   Usuaria (Nome, Data_Nascimento, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Email, Senha)
VALUES
	   ('Julia Manuelly', '2000/10/02', '8191234-5678', '00000-000', 'Rua das Flores', 123, 'Assunção', 'Recife', 'PE', 'julia@gmail.com', '12345678'),
	   ('Maria Estela', '1980/08/10', '8191234-5678', '00000-000', 'Av.Recife', 456, 'Magalhães', 'Recife', 'PE', 'maria@gmail.com', '12345678'),
	   ('Ana Maria', '1999/01/27', '8191234-5678', '00000-000', 'Rua da Alegria', 789, 'Pontezinha', 'Cabo de Santo Agostinho', 'PE', 'ana@gmail.com', '12345678');


INSERT INTO 
	   Rede_Apoio (Nome, Responsavel, Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Horario)
VALUES
	   ('ONG Marias', 'Maria José', 'Cuidamos de você com paciência, rompendo o ciclo e conquistando sua independência', '81912345678', '0000-0000', 'Av.Recife', 456, 'Magalhães', 'Recife', 'PE', 'Das 8hrs ás 19hrs'),
	   ('ONG Malala', 'Augusta Lima', 'Acolhendo mulheres que sofrem de violência física e psicológica', '81900000000', '0000-0000', 'Rua da Alegria', 789, 'Cabo-Centro', 'Cabo de Santo Agostinho', 'PE', 'Das 8hrs ás 19hrs'),
	   ('ONG Renascer', 'Margarida Silva', 'Rompa o ciclo da violencia e busque seu renascimento', '81912345678', '0000-0000', 'Av.Recife', 456, 'Das graças', 'Recife', 'PE', 'Das 8hrs ás 19hrs');


INSERT INTO 
	   Alerta (Status_Alerta, Data_Hora, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Id_Orgao, Id_Usuaria)
VALUES
	   (1, GETDATE(), '00000-000', 'Rua da Alegria', 789, 'Pontezinha', 'Cabo de Santo Agostinho', 'PE', 1002, 1000);

INSERT INTO 
	   Classificacao (Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado)
VALUES
	   ('Especializada em violência contra a mulher', 180, '00000-000', 'Av.Boa Viagem', 000, 'Boa Viagem', 'Recife', 'PE'),
	   ('Também realiza atendimento em caso de violência contra a mulher envolvendo crianças', 100, '00000-000', 'Av.Rosa Branca', 000, 'Boa Viagem', 'Recife', 'PE'),
	   ('Atende em casos de violência física', 190, '00000-000', 'Av.Francisco da Cunha', 123, 'Boa viagem', 'Recife', 'PE');

INSERT INTO 
	   Orgao (Nome, Descricao_Alerta, Solicitacao, Id_Classificacao)
VALUES
	   ('Delegacia da Mulher', 'Mulher com supostas agressoes realizadas pelo parceiro', 1, 1000),
	   ('Direitos Humanos', 'Mulher e criança com supostas agressoes realizadas pelo parceiro/pai da criança', 0, 1001),
	   ('Policia Militar', 'Mulher com indícios de violência física realizada pelo (ex)parceiro', 0, 1002);


INSERT INTO 
	   Denuncia (Violencia_Sofrida, Situacao_Atual, Descricao, Data_Hora, Status_Denuncia, Id_Orgao)
VALUES
	   ('Física', 'Em perigo', 'Vítima apresenta sinais de violência física',  GETDATE(), 0, 1002);


INSERT INTO 
	   Tipo_Violencia (Sessao, Pergunta, Resposta, Status)
VALUES
	   (1, 'Possui filhos com o agressor?', 'Sim/Não', 1),
	   (4, 'Você está passando por xingamentos e humilhações', 'Sim/Não', 0),
	   (1, 'Precisa ter contato com o agressor por conta dos filhos', 'Sim/Não', 1);


INSERT INTO 
	   Conteudo_Informativo (Conteudo, Descricao)
VALUES
	   ('Violêcia Física', 'Socos, tapas e empurrões'),
	   ('Violêcia Moral', 'Xingamentos, humilhações'),
	   ('Violêcia Patrimonial', 'Subtração de bens financeiros');


INSERT INTO 
	   Utiliza_Rede_Apoio_Usuaria (Id_Rede_Apoio, Id_Usuaria)
VALUES
	   (1000, 1000);


INSERT INTO 
	   Acessa_Usuaria_Conteudo (Id_Usuaria, Id_Conteudo, Data_Acesso)
VALUES
	   (1001, 1000,  GETDATE());


INSERT INTO 
	   Sofre_Tipo_Violencia_Usuaria (Id_Usuaria, Id_Tipo_Violencia)
VALUES
	   (1002, 1002);


INSERT INTO 
	   Gera_Denuncia_Usuaria (Id_Usuaria, Id_Denuncia)
VALUES
	   (NULL, 1000),
	   (1000, 1001);


 --Triggers, Views, Functions e Stored Procedures

 --Colocar o item excluído da tabela usuária em uma cópia de uma tabela "morto"

CREATE OR ALTER TRIGGER Controle_Delete_Usuaria
ON
	Usuaria
FOR DELETE
AS
	INSERT INTO Verifica_Delete_Usuaria SELECT * FROM DELETED
	PRINT 'Registro excluído com sucesso!';


 --Colocar o item excluído da tabela alerta em uma cópia de uma tabela "morto"

CREATE OR ALTER TRIGGER Controle_Delete_Alerta
ON
	Alerta
FOR DELETE
AS
	INSERT INTO Verifica_Delete_Alerta SELECT * FROM DELETED
	PRINT 'Registro excluído com sucesso!';


 --Colocar o item excluído da tabela denuncia em uma cópia de uma tabela "morto"

CREATE OR ALTER TRIGGER Controle_Delete_Denuncia
ON
	Denuncia
FOR DELETE
AS
	INSERT INTO Verifica_Delete_Denuncia SELECT * FROM DELETED
	PRINT 'Registro excluído com sucesso!';


 --Colocar o item excluído da tabela rede de apoio em uma cópia de uma tabela "morto"

CREATE OR ALTER TRIGGER Controle_Delete_Rede_Apoio
ON
	Rede_Apoio
FOR DELETE
AS
	INSERT INTO Verifica_Delete_Rede_Apoio SELECT * FROM DELETED
	PRINT 'Registro excluído com sucesso!';


 --FUNCTIONS 

 --Calcular a idade da usuaria com base na data de nascimento

CREATE OR ALTER FUNCTION Calcula_Idade_Usuaria(@Data_Nascimento DATE)
	   RETURNS INT
AS
	   BEGIN
			DECLARE @Idade INT;
			SET @Idade = YEAR(GETDATE()) - YEAR(@Data_Nascimento);
			RETURN @Idade;
	   END;


 --VIEWS

 --Ver as idades sem armazená-las

CREATE OR ALTER VIEW Idade_Usuaria AS
SELECT 
    Id_Usuaria,
    Nome,
    Data_Nascimento,
    dbo.Calcula_Idade_Usuaria(Data_Nascimento) AS Idade
FROM 
    Usuaria;

SELECT * FROM Idade_Usuaria;


 --Ver a quantidade e os tipos das denúncias 

CREATE OR ALTER VIEW Qtd_Denuncia_Por_Tipo_E_Status AS
SELECT
    CASE WHEN Tipo_Denuncia = 0 THEN 'Anônima' ELSE 'Identificada' END AS Tipo,
    Status_Denuncia,
    COUNT(*) AS Quantidade
FROM Denuncia
WHERE Status_Denuncia IN ('Em análise', 'Concluída')
GROUP BY Tipo_Denuncia, Status_Denuncia;

SELECT * FROM Qtd_Denuncia_Por_Tipo_E_Status;


 --STORED PROCEDURES

 --Cancelando o alerta

CREATE OR ALTER PROCEDURE Cancelar_Alerta
    @Id_Alerta INT
AS
BEGIN
    UPDATE Alerta
    SET Status_Alerta = 0,
    WHERE Id_Alerta = @Id_Alerta;
END;

EXEC Cancelar_Alerta @Id_Denuncia = 1000;

 --Retirando a denúncia

CREATE OR ALTER PROCEDURE Retirar_Denuncia
    @Id_Denuncia INT
AS
BEGIN
    UPDATE Denuncia
    SET Status_Denuncia = 0,
    WHERE Id_Denuncia = @Id_Denuncia;
END;

EXEC Retirar_Denuncia @Id_Denuncia = 1000;

 --Consultas

 --Consultar a quantidade de alertas enviados e cancelados pelos orgaos

SELECT
    O.Id_Orgao,
    O.Nome,
    COUNT(CASE WHEN A.Status_Alerta = 1 THEN 1 END) AS QtdRecebidos,  -- Contagem dos enviados/recebidos
    COUNT(CASE WHEN A.Status_Alerta = 0 THEN 1 END) AS QtdCancelados  -- Contagem dos cancelados
FROM Orgao O
LEFT JOIN Alerta A ON A.Id_Orgao = O.Id_Orgao
GROUP BY O.Id_Orgao, O.Nome;

 --Consultar a quantidade mínima de acessos aos conteúdos informativos, mostrando qual teve menos acessos

SELECT c.Id_Conteudo, c.Conteudo, c.Descricao, t.qtd_acessos
FROM (
    SELECT Id_Conteudo, COUNT(*) AS qtd_acessos
    FROM Acessa_Usuaria_Conteudo
    GROUP BY Id_Conteudo
) AS t
JOIN Conteudo_Informativo c ON c.Id_Conteudo = t.Id_Conteudo
WHERE t.qtd_acessos = (
    SELECT MIN(qtd_acessos)
    FROM (
        SELECT Id_Conteudo, COUNT(*) AS qtd_acessos
        FROM Acessa_Usuaria_Conteudo
        GROUP BY Id_Conteudo
    ) AS x
);

 --Quantidade de denúncias por usuária e o último registro feito

SELECT 
    u.Nome AS Nome_Usuaria,
    COUNT(d.Id_Denuncia) AS Total_Denuncias,
    MAX(d.Id_Denuncia) AS Ultima_Denuncia,
    COUNT(DISTINCT r.Id_Rede_Apoio) AS Total_Redes_Apoio
FROM Usuaria u
JOIN Denuncia d 
    ON u.Id_Usuaria = d.Id_Usuaria
JOIN Utiliza ut 
    ON u.Id_Usuaria = ut.Id_Usuaria
JOIN Rede_Apoio r 
    ON ut.Id_Rede_Apoio = r.Id_Rede_Apoio
GROUP BY u.Nome;


 --CONSULTAS SIMPLES COM SELECT PARA VERIFICAÇÃO DOS DADOS DAS TABELAS

SELECT * FROM Usuaria;
SELECT * FROM Rede_Apoio;
SELECT * FROM Alerta;
SELECT * FROM Orgao;
SELECT * FROM Classificacao;
SELECT * FROM Denuncia;
SELECT * FROM Conteudo_Informativo;
SELECT * FROM Tipo_Violencia;
SELECT * FROM Utiliza_Rede_Apoio_Usuaria;
SELECT * FROM Acessa_Usuaria_Conteudo;
SELECT * FROM Sofre_Tipo_Violencia_Usuaria;
SELECT * FROM Gera_Denuncia_Usuaria;
