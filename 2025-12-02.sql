/* =========================================================
   RESET (pra testar do zero)
   ========================================================= */
USE master;
GO

IF DB_ID('DBJuntaai') IS NOT NULL
BEGIN
    ALTER DATABASE DBJuntaai SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DBJuntaai;
END
GO

CREATE DATABASE DBJuntaai;
GO
USE DBJuntaai;
GO

/* =========================================================
   TABELAS PRINCIPAIS
   ========================================================= */

-- 1) Usuaria (aqui vai a exigência de AUTONUMERAÇÃO 1000 com incremento 10)
CREATE TABLE dbo.Usuaria (
    Id_Usuaria       INT IDENTITY(1000,10) PRIMARY KEY,
    Nome             VARCHAR(50)  NOT NULL,
    Data_Nascimento  DATE         NOT NULL,
    Telefone         VARCHAR(15)  NULL,
    CEP              VARCHAR(10)  NOT NULL,
    Rua_Avenida      VARCHAR(60)  NOT NULL,
    Num_Imovel        INT         NOT NULL,
    Bairro           VARCHAR(30)  NOT NULL,
    Cidade           VARCHAR(40)  NOT NULL,
    Estado           CHAR(2)      NOT NULL,
    Email            VARCHAR(80)  NOT NULL UNIQUE,
    Senha            VARCHAR(256) NOT NULL
);

CREATE TABLE dbo.Rede_Apoio (
    Id_Rede_Apoio INT IDENTITY(1000,1) PRIMARY KEY,
    Nome          VARCHAR(60)  NOT NULL,
    Responsavel   VARCHAR(60)  NOT NULL,
    Descricao     VARCHAR(200) NOT NULL,
    Telefone      VARCHAR(15)  NOT NULL,
    CEP           VARCHAR(10)  NOT NULL,
    Rua_Avenida   VARCHAR(60)  NOT NULL,
    Num_Imovel    INT          NOT NULL,
    Bairro        VARCHAR(30)  NOT NULL,
    Cidade        VARCHAR(40)  NOT NULL,
    Estado        CHAR(2)      NOT NULL,
    Horario       VARCHAR(40)  NOT NULL
);

CREATE TABLE dbo.Conteudo_Informativo (
    Id_Conteudo INT IDENTITY(1000,1) PRIMARY KEY,
    Conteudo    VARCHAR(80)  NOT NULL,
    Descricao   VARCHAR(200) NOT NULL,
    Data_Hora   DATETIME     NOT NULL DEFAULT GETDATE()
);

CREATE TABLE dbo.Tipo_Violencia (
    Id_Tipo_Violencia INT IDENTITY(1000,1) PRIMARY KEY,
    Sessao            INT          NOT NULL,
    Pergunta          VARCHAR(200) NOT NULL,
    Resposta          VARCHAR(20)  NOT NULL DEFAULT 'Sim/Não',
    Status            BIT          NOT NULL DEFAULT 1
);

CREATE TABLE dbo.Classificacao (
    Id_Classificacao INT IDENTITY(1000,1) PRIMARY KEY,
    Descricao        VARCHAR(200) NOT NULL,
    Telefone         VARCHAR(15)  NOT NULL,
    CEP              VARCHAR(10)  NOT NULL,
    Rua_Avenida      VARCHAR(60)  NOT NULL,
    Num_Imovel       INT          NOT NULL,
    Bairro           VARCHAR(30)  NOT NULL,
    Cidade           VARCHAR(40)  NOT NULL,
    Estado           CHAR(2)      NOT NULL
);

CREATE TABLE dbo.Orgao (
    Id_Orgao         INT IDENTITY(1000,1) PRIMARY KEY,
    Nome             VARCHAR(60)  NOT NULL,
    Descricao_Alerta VARCHAR(200) NOT NULL,
    Solicitacao      BIT          NOT NULL DEFAULT 0,
    Id_Classificacao INT          NOT NULL,
    CONSTRAINT FK_Orgao_Classificacao
        FOREIGN KEY (Id_Classificacao) REFERENCES dbo.Classificacao(Id_Classificacao)
);

CREATE TABLE dbo.Alerta (
    Id_Alerta     INT IDENTITY(1000,1) PRIMARY KEY,
    Status_Alerta BIT      NOT NULL DEFAULT 1,  -- 1=ativo 0=cancelado
    Data_Hora     DATETIME NOT NULL DEFAULT GETDATE(),
    CEP           VARCHAR(10) NOT NULL,
    Rua_Avenida   VARCHAR(60) NOT NULL,
    Num_Imovel    INT         NOT NULL,
    Bairro        VARCHAR(30) NOT NULL,
    Cidade        VARCHAR(40) NOT NULL,
    Estado        CHAR(2)     NOT NULL,
    Id_Orgao      INT         NOT NULL,
    Id_Usuaria    INT         NOT NULL,
    CONSTRAINT FK_Alerta_Orgao   FOREIGN KEY (Id_Orgao)   REFERENCES dbo.Orgao(Id_Orgao),
    CONSTRAINT FK_Alerta_Usuaria FOREIGN KEY (Id_Usuaria) REFERENCES dbo.Usuaria(Id_Usuaria)
);

CREATE TABLE dbo.Denuncia (
    Id_Denuncia        INT IDENTITY(1000,1) PRIMARY KEY,
    Violencia_Sofrida  VARCHAR(20) NOT NULL
        CHECK (Violencia_Sofrida IN ('Física','Psicológica','Sexual','Patrimonial','Moral')),
    Situacao_Atual     VARCHAR(15) NOT NULL
        CHECK (Situacao_Atual IN ('Em perigo','Controlada','Fora de perigo')),
    Descricao          VARCHAR(200) NOT NULL,
    Data_Hora          DATETIME     NOT NULL DEFAULT GETDATE(),
    Status_Denuncia    BIT          NOT NULL DEFAULT 1, -- 1=ativa 0=retirada
    Id_Orgao           INT          NOT NULL,
    CONSTRAINT FK_Denuncia_Orgao FOREIGN KEY (Id_Orgao) REFERENCES dbo.Orgao(Id_Orgao)
);

/* =========================================================
   TABELAS ASSOCIATIVAS (N:N)
   ========================================================= */

CREATE TABLE dbo.Utiliza_Rede_Apoio_Usuaria (
    Id_Rede_Apoio INT NOT NULL,
    Id_Usuaria    INT NOT NULL,
    CONSTRAINT PK_Utiliza_Rede_Apoio_Usuaria PRIMARY KEY (Id_Rede_Apoio, Id_Usuaria),
    CONSTRAINT FK_Utiliza_Rede FOREIGN KEY (Id_Rede_Apoio)
        REFERENCES dbo.Rede_Apoio(Id_Rede_Apoio) ON DELETE NO ACTION,
    CONSTRAINT FK_Utiliza_Usuaria FOREIGN KEY (Id_Usuaria)
        REFERENCES dbo.Usuaria(Id_Usuaria) ON DELETE CASCADE
);

CREATE TABLE dbo.Acessa_Usuaria_Conteudo (
    Id_Usuaria  INT NOT NULL,
    Id_Conteudo INT NOT NULL,
    Data_Acesso DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Acessa_Usuaria_Conteudo PRIMARY KEY (Id_Usuaria, Id_Conteudo),
    CONSTRAINT FK_Acessa_Usuaria  FOREIGN KEY (Id_Usuaria)  REFERENCES dbo.Usuaria(Id_Usuaria),
    CONSTRAINT FK_Acessa_Conteudo FOREIGN KEY (Id_Conteudo) REFERENCES dbo.Conteudo_Informativo(Id_Conteudo)
);

CREATE TABLE dbo.Sofre_Tipo_Violencia_Usuaria (
    Id_Usuaria        INT NOT NULL,
    Id_Tipo_Violencia INT NOT NULL,
    CONSTRAINT PK_Sofre_Tipo_Violencia_Usuaria PRIMARY KEY (Id_Usuaria, Id_Tipo_Violencia),
    CONSTRAINT FK_Sofre_Usuaria FOREIGN KEY (Id_Usuaria)
        REFERENCES dbo.Usuaria(Id_Usuaria) ON DELETE NO ACTION,
    CONSTRAINT FK_Sofre_TipoViolencia FOREIGN KEY (Id_Tipo_Violencia)
        REFERENCES dbo.Tipo_Violencia(Id_Tipo_Violencia) ON DELETE CASCADE
);

-- Aqui você queria permitir usuária NULL. PK não aceita NULL.
-- Solução: PK própria + Id_Usuaria NULL permitido.
CREATE TABLE dbo.Gera_Denuncia_Usuaria (
    Id_Gera     INT IDENTITY(1000,1) PRIMARY KEY,
    Id_Usuaria  INT NULL,
    Id_Denuncia INT NOT NULL,
    CONSTRAINT FK_Gera_Usuaria  FOREIGN KEY (Id_Usuaria)  REFERENCES dbo.Usuaria(Id_Usuaria),
    CONSTRAINT FK_Gera_Denuncia FOREIGN KEY (Id_Denuncia) REFERENCES dbo.Denuncia(Id_Denuncia) ON DELETE CASCADE
);

/* =========================================================
   TABELAS “MORTO” (AUDITORIA DE DELETE) + TRIGGERS
   ========================================================= */

CREATE TABLE dbo.Verifica_Delete_Usuaria (
    Id_Usuaria      INT,
    Nome            VARCHAR(50),
    Data_Nascimento DATE,
    Telefone        VARCHAR(15),
    CEP             VARCHAR(10),
    Rua_Avenida     VARCHAR(60),
    Num_Imovel      INT,
    Bairro          VARCHAR(30),
    Cidade          VARCHAR(40),
    Estado          CHAR(2),
    Email           VARCHAR(80),
    Senha           VARCHAR(256),
    Data_Exclusao   DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE dbo.Verifica_Delete_Alerta (
    Id_Alerta     INT,
    Status_Alerta BIT,
    Data_Hora     DATETIME,
    CEP           VARCHAR(10),
    Rua_Avenida   VARCHAR(60),
    Num_Imovel    INT,
    Bairro        VARCHAR(30),
    Cidade        VARCHAR(40),
    Estado        CHAR(2),
    Id_Orgao      INT,
    Id_Usuaria    INT,
    Data_Exclusao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE dbo.Verifica_Delete_Denuncia (
    Id_Denuncia       INT,
    Violencia_Sofrida VARCHAR(20),
    Situacao_Atual    VARCHAR(15),
    Descricao         VARCHAR(200),
    Data_Hora         DATETIME,
    Status_Denuncia   BIT,
    Id_Orgao          INT,
    Data_Exclusao     DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE dbo.Verifica_Delete_Rede_Apoio (
    Id_Rede_Apoio  INT,
    Nome           VARCHAR(60),
    Responsavel    VARCHAR(60),
    Descricao      VARCHAR(200),
    Telefone       VARCHAR(15),
    CEP            VARCHAR(10),
    Rua_Avenida    VARCHAR(60),
    Num_Imovel     INT,
    Bairro         VARCHAR(30),
    Cidade         VARCHAR(40),
    Estado         CHAR(2),
    Horario        VARCHAR(40),
    Data_Exclusao  DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE OR ALTER TRIGGER dbo.Controle_Delete_Usuaria
ON dbo.Usuaria
AFTER DELETE
AS
BEGIN
    INSERT INTO dbo.Verifica_Delete_Usuaria
    (Id_Usuaria, Nome, Data_Nascimento, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Email, Senha)
    SELECT Id_Usuaria, Nome, Data_Nascimento, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Email, Senha
    FROM deleted;
END;
GO

CREATE OR ALTER TRIGGER dbo.Controle_Delete_Alerta
ON dbo.Alerta
AFTER DELETE
AS
BEGIN
    INSERT INTO dbo.Verifica_Delete_Alerta
    (Id_Alerta, Status_Alerta, Data_Hora, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Id_Orgao, Id_Usuaria)
    SELECT Id_Alerta, Status_Alerta, Data_Hora, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Id_Orgao, Id_Usuaria
    FROM deleted;
END;
GO

CREATE OR ALTER TRIGGER dbo.Controle_Delete_Denuncia
ON dbo.Denuncia
AFTER DELETE
AS
BEGIN
    INSERT INTO dbo.Verifica_Delete_Denuncia
    (Id_Denuncia, Violencia_Sofrida, Situacao_Atual, Descricao, Data_Hora, Status_Denuncia, Id_Orgao)
    SELECT Id_Denuncia, Violencia_Sofrida, Situacao_Atual, Descricao, Data_Hora, Status_Denuncia, Id_Orgao
    FROM deleted;
END;
GO

CREATE OR ALTER TRIGGER dbo.Controle_Delete_Rede_Apoio
ON dbo.Rede_Apoio
AFTER DELETE
AS
BEGIN
    INSERT INTO dbo.Verifica_Delete_Rede_Apoio
    (Id_Rede_Apoio, Nome, Responsavel, Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Horario)
    SELECT Id_Rede_Apoio, Nome, Responsavel, Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Horario
    FROM deleted;
END;
GO

/* =========================================================
   FUNCTION + VIEW
   ========================================================= */

CREATE OR ALTER FUNCTION dbo.Calcula_Idade_Usuaria(@Data_Nascimento DATE)
RETURNS INT
AS
BEGIN
    DECLARE @idade INT;
    SET @idade =
        DATEDIFF(YEAR, @Data_Nascimento, GETDATE())
        - CASE
            WHEN DATEADD(YEAR, DATEDIFF(YEAR, @Data_Nascimento, GETDATE()), @Data_Nascimento) > GETDATE()
            THEN 1 ELSE 0
          END;
    RETURN @idade;
END;
GO

CREATE OR ALTER VIEW dbo.Idade_Usuaria AS
SELECT
    u.Id_Usuaria,
    u.Nome,
    u.Data_Nascimento,
    dbo.Calcula_Idade_Usuaria(u.Data_Nascimento) AS Idade
FROM dbo.Usuaria u;
GO

-- View corrigida: tipo (anônima vs identificada) e status (ativa vs retirada)
CREATE OR ALTER VIEW dbo.Qtd_Denuncia_Por_Tipo_E_Status AS
SELECT
    CASE WHEN g.Id_Usuaria IS NULL THEN 'Anônima' ELSE 'Identificada' END AS Tipo,
    CASE WHEN d.Status_Denuncia = 1 THEN 'Ativa' ELSE 'Retirada' END AS Status,
    COUNT(*) AS Quantidade
FROM dbo.Denuncia d
JOIN dbo.Gera_Denuncia_Usuaria g ON g.Id_Denuncia = d.Id_Denuncia
GROUP BY
    CASE WHEN g.Id_Usuaria IS NULL THEN 'Anônima' ELSE 'Identificada' END,
    CASE WHEN d.Status_Denuncia = 1 THEN 'Ativa' ELSE 'Retirada' END;
GO

/* =========================================================
   STORED PROCEDURES (corrigidas)
   ========================================================= */

CREATE OR ALTER PROCEDURE dbo.Cancelar_Alerta
    @Id_Alerta INT
AS
BEGIN
    UPDATE dbo.Alerta
    SET Status_Alerta = 0
    WHERE Id_Alerta = @Id_Alerta;
END;
GO

CREATE OR ALTER PROCEDURE dbo.Retirar_Denuncia
    @Id_Denuncia INT
AS
BEGIN
    UPDATE dbo.Denuncia
    SET Status_Denuncia = 0
    WHERE Id_Denuncia = @Id_Denuncia;
END;
GO

/* =========================================================
   INDEX (mín. 1)
   ========================================================= */

-- Índices úteis (e já mata o requisito de INDEX)
CREATE INDEX IX_Alerta_Id_Orgao   ON dbo.Alerta(Id_Orgao);
CREATE INDEX IX_Alerta_Id_Usuaria ON dbo.Alerta(Id_Usuaria);
CREATE INDEX IX_Denuncia_Id_Orgao ON dbo.Denuncia(Id_Orgao);

-- Evita duplicar vínculo de denúncia identificada (usuária não nula)
CREATE UNIQUE INDEX UX_GeraDenuncia_Identificada
ON dbo.Gera_Denuncia_Usuaria(Id_Usuaria, Id_Denuncia)
WHERE Id_Usuaria IS NOT NULL;
GO

/* =========================================================
   INSERTS (3 REGISTROS EM CADA TABELA)
   - sem hardcode de IDs (pra não quebrar com IDENTITY 10)
   ========================================================= */

DECLARE @u1 INT, @u2 INT, @u3 INT;
DECLARE @r1 INT, @r2 INT, @r3 INT;
DECLARE @c1 INT, @c2 INT, @c3 INT;
DECLARE @tv1 INT, @tv2 INT, @tv3 INT;
DECLARE @cl1 INT, @cl2 INT, @cl3 INT;
DECLARE @o1 INT, @o2 INT, @o3 INT;
DECLARE @a1 INT, @a2 INT, @a3 INT;
DECLARE @d1 INT, @d2 INT, @d3 INT;

-- Usuaria (3)
INSERT INTO dbo.Usuaria (Nome, Data_Nascimento, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Email, Senha)
VALUES ('Julia Manuelly', '2000-10-02', '8191234-5678', '00000-000', 'Rua das Flores', 123, 'Assunção', 'Recife', 'PE', 'julia@gmail.com', '12345678');
SET @u1 = SCOPE_IDENTITY();

INSERT INTO dbo.Usuaria (Nome, Data_Nascimento, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Email, Senha)
VALUES ('Maria Estela', '1980-08-10', '8191234-5678', '00000-000', 'Av. Recife', 456, 'Magalhães', 'Recife', 'PE', 'maria@gmail.com', '12345678');
SET @u2 = SCOPE_IDENTITY();

INSERT INTO dbo.Usuaria (Nome, Data_Nascimento, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Email, Senha)
VALUES ('Ana Maria', '1999-01-27', '8191234-5678', '00000-000', 'Rua da Alegria', 789, 'Pontezinha', 'Cabo de Santo Agostinho', 'PE', 'ana@gmail.com', '12345678');
SET @u3 = SCOPE_IDENTITY();

-- Rede_Apoio (3)
INSERT INTO dbo.Rede_Apoio (Nome, Responsavel, Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Horario)
VALUES ('ONG Marias', 'Maria José', 'Acolhimento e independência', '81912345678', '00000-000', 'Av. Recife', 456, 'Magalhães', 'Recife', 'PE', '08h às 19h');
SET @r1 = SCOPE_IDENTITY();

INSERT INTO dbo.Rede_Apoio (Nome, Responsavel, Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Horario)
VALUES ('ONG Malala', 'Augusta Lima', 'Acolhendo mulheres em risco', '81900000000', '00000-000', 'Rua da Alegria', 789, 'Centro', 'Cabo de Santo Agostinho', 'PE', '08h às 19h');
SET @r2 = SCOPE_IDENTITY();

INSERT INTO dbo.Rede_Apoio (Nome, Responsavel, Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Horario)
VALUES ('ONG Renascer', 'Margarida Silva', 'Rompa o ciclo e recomece', '81988887777', '00000-000', 'Av. Boa Viagem', 10, 'Boa Viagem', 'Recife', 'PE', '08h às 17h');
SET @r3 = SCOPE_IDENTITY();

-- Conteudo_Informativo (3)
INSERT INTO dbo.Conteudo_Informativo (Conteudo, Descricao) VALUES
('Violência Física', 'Socos, tapas e empurrões'),
('Violência Moral', 'Xingamentos, humilhações'),
('Violência Patrimonial', 'Subtração de bens e controle financeiro');

SELECT @c1 = MIN(Id_Conteudo), @c3 = MAX(Id_Conteudo) FROM dbo.Conteudo_Informativo;
-- pega o do meio
SELECT @c2 = Id_Conteudo FROM dbo.Conteudo_Informativo
WHERE Id_Conteudo NOT IN (@c1, @c3);

-- Tipo_Violencia (3)
INSERT INTO dbo.Tipo_Violencia (Sessao, Pergunta) VALUES
(1, 'Possui filhos com o agressor?'),
(4, 'Você está sofrendo humilhações ou xingamentos?'),
(2, 'O agressor controla seu dinheiro ou bens?');

SELECT @tv1 = MIN(Id_Tipo_Violencia), @tv3 = MAX(Id_Tipo_Violencia) FROM dbo.Tipo_Violencia;
SELECT @tv2 = Id_Tipo_Violencia FROM dbo.Tipo_Violencia
WHERE Id_Tipo_Violencia NOT IN (@tv1, @tv3);

-- Classificacao (3)
INSERT INTO dbo.Classificacao (Descricao, Telefone, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado) VALUES
('Especializada em violência contra a mulher', '180', '00000-000', 'Av. Boa Viagem', 0, 'Boa Viagem', 'Recife', 'PE'),
('Atendimento em violência contra a mulher envolvendo crianças', '100', '00000-000', 'Av. Rosa Branca', 0, 'Boa Viagem', 'Recife', 'PE'),
('Atende em casos de violência física', '190', '00000-000', 'Av. Francisco da Cunha', 123, 'Boa Viagem', 'Recife', 'PE');

SELECT @cl1 = MIN(Id_Classificacao), @cl3 = MAX(Id_Classificacao) FROM dbo.Classificacao;
SELECT @cl2 = Id_Classificacao FROM dbo.Classificacao
WHERE Id_Classificacao NOT IN (@cl1, @cl3);

-- Orgao (3) (depende de Classificacao)
INSERT INTO dbo.Orgao (Nome, Descricao_Alerta, Solicitacao, Id_Classificacao) VALUES
('Delegacia da Mulher', 'Suspeita de agressão pelo parceiro', 1, @cl1),
('Direitos Humanos', 'Mulher e criança em risco', 0, @cl2),
('Polícia Militar', 'Indícios de violência física pelo (ex)parceiro', 0, @cl3);

SELECT @o1 = MIN(Id_Orgao), @o3 = MAX(Id_Orgao) FROM dbo.Orgao;
SELECT @o2 = Id_Orgao FROM dbo.Orgao
WHERE Id_Orgao NOT IN (@o1, @o3);

-- Alerta (3) (depende Orgao + Usuaria)
INSERT INTO dbo.Alerta (Status_Alerta, CEP, Rua_Avenida, Num_Imovel, Bairro, Cidade, Estado, Id_Orgao, Id_Usuaria)
VALUES
(1, '00000-000', 'Rua da Alegria', 789, 'Pontezinha', 'Cabo de Santo Agostinho', 'PE', @o3, @u1),
(1, '00000-000', 'Av. Recife', 456, 'Magalhães', 'Recife', 'PE', @o1, @u2),
(0, '00000-000', 'Av. Boa Viagem', 10, 'Boa Viagem', 'Recife', 'PE', @o2, @u3);

SELECT @a1 = MIN(Id_Alerta), @a3 = MAX(Id_Alerta) FROM dbo.Alerta;
SELECT @a2 = Id_Alerta FROM dbo.Alerta WHERE Id_Alerta NOT IN (@a1, @a3);

-- Denuncia (3) (depende Orgao)
INSERT INTO dbo.Denuncia (Violencia_Sofrida, Situacao_Atual, Descricao, Status_Denuncia, Id_Orgao)
VALUES
('Física', 'Em perigo', 'Vítima apresenta sinais de violência física', 1, @o3),
('Psicológica', 'Controlada', 'Relato de ameaças e intimidação', 1, @o1),
('Patrimonial', 'Fora de perigo', 'Controle de recursos e retenção de documentos', 0, @o2);

SELECT @d1 = MIN(Id_Denuncia), @d3 = MAX(Id_Denuncia) FROM dbo.Denuncia;
SELECT @d2 = Id_Denuncia FROM dbo.Denuncia WHERE Id_Denuncia NOT IN (@d1, @d3);

-- Utiliza_Rede_Apoio_Usuaria (3)
INSERT INTO dbo.Utiliza_Rede_Apoio_Usuaria (Id_Rede_Apoio, Id_Usuaria)
VALUES
(@r1, @u1),
(@r2, @u2),
(@r3, @u3);

-- Acessa_Usuaria_Conteudo (3)
INSERT INTO dbo.Acessa_Usuaria_Conteudo (Id_Usuaria, Id_Conteudo)
VALUES
(@u1, @c1),
(@u2, @c2),
(@u3, @c3);

-- Sofre_Tipo_Violencia_Usuaria (3)
INSERT INTO dbo.Sofre_Tipo_Violencia_Usuaria (Id_Usuaria, Id_Tipo_Violencia)
VALUES
(@u1, @tv1),
(@u2, @tv2),
(@u3, @tv3);

-- Gera_Denuncia_Usuaria (3) - 1 anônima + 2 identificadas
INSERT INTO dbo.Gera_Denuncia_Usuaria (Id_Usuaria, Id_Denuncia)
VALUES
(NULL, @d1),
(@u1, @d2),
(@u2, @d3);

/* =========================================================
   CONSULTAS (JOIN + alias + agregação)
   ========================================================= */

-- 1) Quantidade de alertas ativos x cancelados por órgão (agregação)
SELECT
    o.Id_Orgao,
    o.Nome AS Orgao,
    SUM(CASE WHEN a.Status_Alerta = 1 THEN 1 ELSE 0 END) AS QtdAtivos,
    SUM(CASE WHEN a.Status_Alerta = 0 THEN 1 ELSE 0 END) AS QtdCancelados
FROM dbo.Orgao o
LEFT JOIN dbo.Alerta a ON a.Id_Orgao = o.Id_Orgao
GROUP BY o.Id_Orgao, o.Nome;

-- 2) Conteúdo menos acessado (agregação + subquery + alias)
SELECT c.Id_Conteudo, c.Conteudo, c.Descricao, t.qtd_acessos
FROM (
    SELECT Id_Conteudo, COUNT(*) AS qtd_acessos
    FROM dbo.Acessa_Usuaria_Conteudo
    GROUP BY Id_Conteudo
) t
JOIN dbo.Conteudo_Informativo c ON c.Id_Conteudo = t.Id_Conteudo
WHERE t.qtd_acessos = (
    SELECT MIN(qtd_acessos)
    FROM (
        SELECT Id_Conteudo, COUNT(*) AS qtd_acessos
        FROM dbo.Acessa_Usuaria_Conteudo
        GROUP BY Id_Conteudo
    ) x
);

-- 3) Denúncias por usuária (2+ joins na mesma query)
SELECT
    u.Nome AS Nome_Usuaria,
    COUNT(DISTINCT d.Id_Denuncia) AS Total_Denuncias,
    MAX(d.Data_Hora) AS Data_Ultima_Denuncia,
    COUNT(DISTINCT ura.Id_Rede_Apoio) AS Total_Redes_Apoio
FROM dbo.Usuaria u
LEFT JOIN dbo.Gera_Denuncia_Usuaria g ON g.Id_Usuaria = u.Id_Usuaria
LEFT JOIN dbo.Denuncia d ON d.Id_Denuncia = g.Id_Denuncia
LEFT JOIN dbo.Utiliza_Rede_Apoio_Usuaria ura ON ura.Id_Usuaria = u.Id_Usuaria
GROUP BY u.Nome;

-- Views
SELECT * FROM dbo.Idade_Usuaria;
SELECT * FROM dbo.Qtd_Denuncia_Por_Tipo_E_Status;
GO