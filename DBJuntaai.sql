IF DB_ID('DBJuntaai') IS NOT NULL
BEGIN
    ALTER DATABASE DBJuntaai SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DBJuntaai;
END
GO

CREATE DATABASE DBJuntaai;
GO
USE DBJuntaai;

-- ============================================
-- TABELAS
-- ============================================

CREATE TABLE Usuaria (
    Id_Usuaria INTEGER PRIMARY KEY IDENTITY(1000,1),
    Nome VARCHAR(50) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Telefone VARCHAR(15),
    CEP VARCHAR(10) NOT NULL,
    Rua_Avenida VARCHAR(30) NOT NULL,
    Num_Imovel INTEGER NOT NULL,
    Bairro VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,
    Estado CHAR(2) NOT NULL,
    Email VARCHAR(30) UNIQUE NOT NULL,
    Senha VARCHAR(256) NOT NULL
);

CREATE TABLE Rede_Apoio (
    Id_Rede_Apoio INTEGER PRIMARY KEY IDENTITY(1000,1),
    Nome VARCHAR(50) NOT NULL,
    Responsavel VARCHAR(30) NOT NULL,
    Descricao VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    Rua_Avenida VARCHAR(30) NOT NULL,
    Num_Imovel INTEGER NOT NULL,
    Bairro VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,
    Estado CHAR(2) NOT NULL,
    Horario VARCHAR(15) NOT NULL
);

CREATE TABLE Conteudo_Informativo (
    Id_Conteudo INTEGER PRIMARY KEY IDENTITY(1000,1),
    Conteudo VARCHAR(30) NOT NULL,
    Descricao VARCHAR(100) NOT NULL,
    Data_Hora DATETIME DEFAULT GETDATE()
);

CREATE TABLE Tipo_Violencia (
    Id_Tipo_Violencia INTEGER PRIMARY KEY IDENTITY(1000,1),
    Sessao INTEGER NOT NULL,
    Pergunta VARCHAR(50) NOT NULL,
    Resposta VARCHAR(50) NOT NULL,
    Status BIT
);

CREATE TABLE Classificacao (
    Id_Classificacao INTEGER PRIMARY KEY IDENTITY(1000,1),
    Descricao VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    Rua_Avenida VARCHAR(30) NOT NULL,
    Num_Imovel INTEGER NOT NULL,
    Bairro VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,
    Estado CHAR(2) NOT NULL
);

CREATE TABLE Orgao (
    Id_Orgao INTEGER PRIMARY KEY IDENTITY(1000,1),
    Nome VARCHAR(50) NOT NULL,
    Descricao_Alerta VARCHAR(100) NOT NULL,
    Solicitacao BIT DEFAULT 0,
    Id_Classificacao INTEGER NOT NULL,
    FOREIGN KEY (Id_Classificacao) REFERENCES Classificacao(Id_Classificacao)
);

CREATE TABLE Alerta (
    Id_Alerta INTEGER PRIMARY KEY IDENTITY(1000,1),
    Status_Alerta BIT NOT NULL,
    Data_Hora DATETIME DEFAULT GETDATE(),
    CEP VARCHAR(10) NOT NULL,
    Rua_Avenida VARCHAR(30) NOT NULL,
    Num_Imovel INTEGER NOT NULL,
    Bairro VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,
    Estado CHAR(2) NOT NULL,
    Id_Orgao INTEGER NOT NULL,
    Id_Usuaria INTEGER NOT NULL,
    FOREIGN KEY (Id_Orgao) REFERENCES Orgao(Id_Orgao),
    FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria)
);

CREATE TABLE Denuncia (
    Id_Denuncia INTEGER PRIMARY KEY IDENTITY(1000,1),
    Violencia_Sofrida VARCHAR(20) CHECK (Violencia_Sofrida IN ('Física', 'Psicológica', 'Sexual', 'Patrimonial', 'Moral')) NOT NULL,
    Situacao_Atual VARCHAR(15) CHECK (Situacao_Atual IN ('Em perigo', 'Controlada', 'Fora de perigo')) NOT NULL,
    Descricao VARCHAR(100) NOT NULL,
    Data_Hora DATETIME DEFAULT GETDATE(),
    Status_Denuncia BIT DEFAULT 0,
    Id_Usuaria INTEGER NOT NULL,
    Id_Orgao INTEGER NOT NULL,
    FOREIGN KEY (Id_Orgao) REFERENCES Orgao(Id_Orgao),
    FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria)
);

CREATE TABLE Utiliza_Rede_Apoio_Usuaria (
    Id_Rede_Apoio INTEGER NOT NULL,
    Id_Usuaria INTEGER NOT NULL,
    FOREIGN KEY (Id_Rede_Apoio) REFERENCES Rede_Apoio(Id_Rede_Apoio) ON DELETE NO ACTION,
    FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria) ON DELETE CASCADE,
    PRIMARY KEY (Id_Rede_Apoio, Id_Usuaria)
);

CREATE TABLE Acessa_Usuaria_Conteudo (
    Id_Usuaria INTEGER NOT NULL,
    Id_Conteudo INTEGER NOT NULL,
    Data_Acesso DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria),
    FOREIGN KEY (Id_Conteudo) REFERENCES Conteudo_Informativo(Id_Conteudo),
    PRIMARY KEY (Id_Usuaria, Id_Conteudo)
);

CREATE TABLE Sofre_Tipo_Violencia_Usuaria (
    Id_Usuaria INTEGER NOT NULL,
    Id_Tipo_Violencia INTEGER NOT NULL,
    FOREIGN KEY (Id_Usuaria) REFERENCES Usuaria(Id_Usuaria) ON DELETE NO ACTION,
    FOREIGN KEY (Id_Tipo_Violencia) REFERENCES Tipo_Violencia(Id_Tipo_Violencia) ON DELETE CASCADE,
    PRIMARY KEY (Id_Usuaria, Id_Tipo_Violencia)
);

-- ============================================
-- INDEX (ADICIONADAS AQUI)
-- ============================================

CREATE INDEX IX_Alerta_Id_Orgao   ON dbo.Alerta(Id_Orgao);
CREATE INDEX IX_Alerta_Id_Usuaria ON dbo.Alerta(Id_Usuaria);
CREATE INDEX IX_Denuncia_Id_Orgao ON dbo.Denuncia(Id_Orgao);
GO

-- ============================================
-- ALIMENTAÇÃO DAS TABELAS
-- ============================================

INSERT INTO Usuaria (Nome, Data_Nascimento, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Email, Senha)
VALUES
('Julia Manuelly', '2000/10/02', '8191234-5678', '00000-000', 'Rua das Flores', 123, 'Assunção', 'Recife', 'PE', 'julia@gmail.com', '12345678'),
('Maria Estela', '1980/08/10', '8191234-5678', '00000-000', 'Av.Recife', 456, 'Magalhães', 'Recife', 'PE', 'maria@gmail.com', '12345678'),
('Ana Maria', '1999/01/27', '8191234-5678', '00000-000', 'Rua da Alegria', 789, 'Pontezinha', 'Cabo de Santo Agostinho', 'PE', 'ana@gmail.com', '12345678');

INSERT INTO Rede_Apoio (Nome, Responsavel, Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Horario)
VALUES
('ONG Marias', 'Maria José', 'Cuidamos de você com paciência...', '81912345678', '0000-0000', 'Av.Recife', 456, 'Magalhães', 'Recife', 'PE', 'Das 8hrs ás 19hrs'),
('ONG Malala', 'Augusta Lima', 'Acolhendo mulheres...', '81900000000', '0000-0000', 'Rua da Alegria', 789, 'Cabo-Centro', 'Cabo de Santo Agostinho', 'PE', 'Das 8hrs ás 19hrs'),
('ONG Renascer', 'Margarida Silva', 'Rompa o ciclo da violência...', '81912345678', '0000-0000', 'Av.Recife', 456, 'Das graças', 'Recife', 'PE', 'Das 8hrs ás 19hrs');

INSERT INTO Classificacao (Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado)
VALUES
('Especializada em violência', 180, '00000-000', 'Av.Boa Viagem', 000, 'Boa Viagem', 'Recife', 'PE'),
('Atendimento mulher e criança', 100, '00000-000', 'Av.Rosa Branca', 000, 'Boa Viagem', 'Recife', 'PE'),
('Atende violência física', 190, '00000-000', 'Av.Francisco da Cunha', 123, 'Boa viagem', 'Recife', 'PE');

INSERT INTO Orgao (Nome, Descricao_Alerta, Solicitacao, Id_Classificacao)
VALUES
('Delegacia da Mulher', 'Mulher com supostas agressões...', 1, 1000),
('Direitos Humanos', 'Mulher e criança...', 0, 1001),
('Polícia Militar', 'Indícios de violência física...', 0, 1002);

INSERT INTO Alerta (Status_Alerta, Data_Hora, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Id_Orgao, Id_Usuaria)
VALUES
(1, GETDATE(), '00000-000', 'Rua da Alegria', 789, 'Pontezinha', 'Cabo de Santo Agostinho', 'PE', 1002, 1000);

INSERT INTO Denuncia (Violencia_Sofrida, Situacao_Atual, Descricao, Data_Hora, Status_Denuncia, Id_Usuaria, Id_Orgao)
VALUES
('Física', 'Em perigo', 'Vítima apresenta sinais...', GETDATE(), 0, 1000, 1002);

INSERT INTO Tipo_Violencia (Sessao, Pergunta, Resposta, Status)
VALUES
(1, 'Possui filhos com o agressor?', 'Sim/Não', 1),
(4, 'Você está passando por xingamentos...', 'Sim/Não', 0),
(1, 'Contato com agressor por causa dos filhos', 'Sim/Não', 1);

INSERT INTO Conteudo_Informativo (Conteudo, Descricao)
VALUES
('Violência Física', 'Socos, tapas e empurrões'),
('Violência Moral', 'Xingamentos, humilhações'),
('Violência Patrimonial', 'Subtração de bens financeiros');

INSERT INTO Utiliza_Rede_Apoio_Usuaria (Id_Rede_Apoio, Id_Usuaria)
VALUES (1000, 1000);

INSERT INTO Acessa_Usuaria_Conteudo (Id_Usuaria, Id_Conteudo, Data_Acesso)
VALUES (1001, 1000, GETDATE());

INSERT INTO Sofre_Tipo_Violencia_Usuaria (Id_Usuaria, Id_Tipo_Violencia)
VALUES (1002, 1002);

-- ============================================
-- TRIGGERS
-- ============================================

CREATE TABLE Verifica_Delete_Usuaria (
    Id_Usuaria INT,
    Nome VARCHAR(50),
    Data_Nascimento DATE,
    Telefone VARCHAR(15),
    CEP VARCHAR(10),
    Rua_Avenida VARCHAR(30),
    Num_Imovel INT,
    Bairro VARCHAR(30),
    Cidade VARCHAR(30),
    Estado CHAR(2),
    Email VARCHAR(30),
    Senha VARCHAR(256)
);

CREATE TABLE Verifica_Delete_Alerta (
    Id_Alerta INT,
    Status_Alerta BIT,
    Data_Hora DATETIME,
    CEP VARCHAR(10),
    Rua_Avenida VARCHAR(30),
    Num_Imovel INT,
    Bairro VARCHAR(30),
    Cidade VARCHAR(30),
    Estado CHAR(2),
    Id_Orgao INT,
    Id_Usuaria INT
);

CREATE TABLE Verifica_Delete_Denuncia (
    Id_Denuncia INT,
    Violencia_Sofrida VARCHAR(20),
    Situacao_Atual VARCHAR(15),
    Descricao VARCHAR(100),
    Data_Hora DATETIME,
    Status_Denuncia BIT,
    Id_Usuaria INT,
    Id_Orgao INT
);

CREATE TABLE Verifica_Delete_Rede_Apoio (
    Id_Rede_Apoio INT,
    Nome VARCHAR(50),
    Responsavel VARCHAR(30),
    Descricao VARCHAR(100),
    Telefone VARCHAR(15),
    CEP VARCHAR(10),
    Rua_Avenida VARCHAR(30),
    Num_Imovel INT,
    Bairro VARCHAR(30),
    Cidade VARCHAR(30),
    Estado CHAR(2),
    Horario VARCHAR(15)
);

CREATE OR ALTER TRIGGER Controle_Delete_Usuaria
ON Usuaria
FOR DELETE
AS
    INSERT INTO Verifica_Delete_Usuaria SELECT * FROM DELETED;

CREATE OR ALTER TRIGGER Controle_Delete_Alerta
ON Alerta
FOR DELETE
AS
    INSERT INTO Verifica_Delete_Alerta SELECT * FROM DELETED;

CREATE OR ALTER TRIGGER Controle_Delete_Denuncia
ON Denuncia
FOR DELETE
AS
    INSERT INTO Verifica_Delete_Denuncia SELECT * FROM DELETED;

CREATE OR ALTER TRIGGER Controle_Delete_Rede_Apoio
ON Rede_Apoio
FOR DELETE
AS
    INSERT INTO Verifica_Delete_Rede_Apoio SELECT * FROM DELETED;

-- ============================================
-- FUNCTION
-- ============================================

CREATE OR ALTER FUNCTION Calcula_Idade_Usuaria(@Data_Nascimento DATE)
RETURNS INT
AS
BEGIN
    RETURN YEAR(GETDATE()) - YEAR(@Data_Nascimento);
END;

-- ============================================
-- VIEWS
-- ============================================

CREATE OR ALTER VIEW Idade_Usuaria AS
SELECT 
    Id_Usuaria,
    Nome,
    Data_Nascimento,
    dbo.Calcula_Idade_Usuaria(Data_Nascimento) AS Idade
FROM Usuaria;

-- ============================================
-- STORED PROCEDURES
-- ============================================

CREATE OR ALTER PROCEDURE Cancelar_Alerta
    @Id_Alerta INT
AS
BEGIN
    UPDATE Alerta
    SET Status_Alerta = 0
    WHERE Id_Alerta = @Id_Alerta;
END;

CREATE OR ALTER PROCEDURE Retirar_Denuncia
    @Id_Denuncia INT
AS
BEGIN
    UPDATE Denuncia
    SET Status_Denuncia = 0
    WHERE Id_Denuncia = @Id_Denuncia;
END;

-- ============================================
-- CONSULTAS
-- ============================================

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
