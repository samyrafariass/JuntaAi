USE DBJuntaai;
GO

SELECT 'Usuaria' Tabela, COUNT(*) Qtde FROM dbo.Usuaria
UNION ALL SELECT 'Rede_Apoio', COUNT(*) FROM dbo.Rede_Apoio
UNION ALL SELECT 'Conteudo_Informativo', COUNT(*) FROM dbo.Conteudo_Informativo
UNION ALL SELECT 'Tipo_Violencia', COUNT(*) FROM dbo.Tipo_Violencia
UNION ALL SELECT 'Classificacao', COUNT(*) FROM dbo.Classificacao
UNION ALL SELECT 'Orgao', COUNT(*) FROM dbo.Orgao
UNION ALL SELECT 'Alerta', COUNT(*) FROM dbo.Alerta
UNION ALL SELECT 'Denuncia', COUNT(*) FROM dbo.Denuncia
UNION ALL SELECT 'Utiliza_Rede_Apoio_Usuaria', COUNT(*) FROM dbo.Utiliza_Rede_Apoio_Usuaria
UNION ALL SELECT 'Acessa_Usuaria_Conteudo', COUNT(*) FROM dbo.Acessa_Usuaria_Conteudo
UNION ALL SELECT 'Sofre_Tipo_Violencia_Usuaria', COUNT(*) FROM dbo.Sofre_Tipo_Violencia_Usuaria
UNION ALL SELECT 'Gera_Denuncia_Usuaria', COUNT(*) FROM dbo.Gera_Denuncia_Usuaria;
GO

SELECT Id_Usuaria, Nome
FROM dbo.Usuaria
ORDER BY Id_Usuaria;
GO

SELECT *
FROM dbo.Idade_Usuaria
ORDER BY Id_Usuaria;
GO

SELECT *
FROM dbo.Qtd_Denuncia_Por_Tipo_E_Status
ORDER BY Tipo, Status;
GO

SELECT
    o.Id_Orgao,
    o.Nome AS Orgao,
    SUM(CASE WHEN a.Status_Alerta = 1 THEN 1 ELSE 0 END) AS QtdAtivos,
    SUM(CASE WHEN a.Status_Alerta = 0 THEN 1 ELSE 0 END) AS QtdCancelados
FROM dbo.Orgao o
LEFT JOIN dbo.Alerta a ON a.Id_Orgao = o.Id_Orgao
GROUP BY o.Id_Orgao, o.Nome
ORDER BY o.Id_Orgao;
GO

SELECT
    u.Nome AS Nome_Usuaria,
    COUNT(DISTINCT d.Id_Denuncia) AS Total_Denuncias,
    MAX(d.Data_Hora) AS Data_Ultima_Denuncia,
    COUNT(DISTINCT ura.Id_Rede_Apoio) AS Total_Redes_Apoio
FROM dbo.Usuaria u
LEFT JOIN dbo.Gera_Denuncia_Usuaria g ON g.Id_Usuaria = u.Id_Usuaria
LEFT JOIN dbo.Denuncia d ON d.Id_Denuncia = g.Id_Denuncia
LEFT JOIN dbo.Utiliza_Rede_Apoio_Usuaria ura ON ura.Id_Usuaria = u.Id_Usuaria
GROUP BY u.Nome
ORDER BY u.Nome;
GO

DECLARE @IdAlerta INT;

SELECT TOP (1) @IdAlerta = Id_Alerta
FROM dbo.Alerta
ORDER BY Id_Alerta;

SELECT Id_Alerta, Status_Alerta
FROM dbo.Alerta
WHERE Id_Alerta = @IdAlerta;

EXEC dbo.Cancelar_Alerta @Id_Alerta = @IdAlerta;

SELECT Id_Alerta, Status_Alerta
FROM dbo.Alerta
WHERE Id_Alerta = @IdAlerta;
GO

DECLARE @IdDenuncia INT;

SELECT TOP (1) @IdDenuncia = Id_Denuncia
FROM dbo.Denuncia
ORDER BY Id_Denuncia;

SELECT Id_Denuncia, Status_Denuncia
FROM dbo.Denuncia
WHERE Id_Denuncia = @IdDenuncia;

EXEC dbo.Retirar_Denuncia @Id_Denuncia = @IdDenuncia;

SELECT Id_Denuncia, Status_Denuncia
FROM dbo.Denuncia
WHERE Id_Denuncia = @IdDenuncia;
GO

BEGIN TRAN;

DECLARE @idRede INT = (SELECT TOP (1) Id_Rede_Apoio FROM dbo.Rede_Apoio ORDER BY Id_Rede_Apoio);

DELETE FROM dbo.Utiliza_Rede_Apoio_Usuaria WHERE Id_Rede_Apoio = @idRede;

DELETE FROM dbo.Rede_Apoio WHERE Id_Rede_Apoio = @idRede;

SELECT TOP (5) *
FROM dbo.Verifica_Delete_Rede_Apoio
ORDER BY Data_Exclusao DESC;

ROLLBACK;
GO

SELECT i.name, i.type_desc, OBJECT_NAME(i.object_id) AS Tabela
FROM sys.indexes i
WHERE OBJECT_NAME(i.object_id) IN ('Alerta','Denuncia','Gera_Denuncia_Usuaria','Usuaria')
  AND i.name IS NOT NULL
ORDER BY Tabela, i.name;
GO
