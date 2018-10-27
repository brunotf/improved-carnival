 --ADICIONA SETE DIAS NA DATA DE HOJE
SELECT DATEADD(DAY, 7, GETDATE())

--CONVERTE PARA DD/MM/YYYY
SELECT CONVERT(CHAR, DATEADD(DAY, 4, GETDATE()), 103)

--RETORNA O NOME DO DIA DA SEMANA
 SELECT DATENAME(W, DATEADD(DAY, 3, GETDATE()))
 
 --ARREDONDA NUMERO ALEATORIO PARA BAIXO ATE 12 
 SELECT ROUND(RAND() * 12, 0, 1);
 
DECLARE @saida VARCHAR(MAX)
EXEC sp_gerarDatas @saida
PRINT @saida

SELECT * FROM rodada

DROP PROCEDURE sp_gerarDatas
GO
CREATE PROCEDURE sp_gerarDatas(@OUT VARCHAR(MAX) OUTPUT)
AS
	DECLARE @contador INT,
			@dataInicial DATETIME,
			@dataAtual DATETIME

	SET @contador = 1
	SET @dataInicial = '30/01/2019'
	SET @dataAtual = @dataInicial

	WHILE @contador <= 15
	BEGIN
		IF (UPPER(DATENAME(W, @dataAtual)) = 'QUARTA-FEIRA')
		BEGIN
			INSERT INTO rodada VALUES (@contador, CONVERT(CHAR, @dataAtual, 103))
			SET @dataAtual = DATEADD(DAY, 4, @dataAtual)
			SET @contador = @contador + 1
		END
		ELSE
		BEGIN
			IF(UPPER(DATENAME(W, @dataAtual)) = 'DOMINGO')
			BEGIN
				INSERT INTO rodada VALUES (@contador, CONVERT(CHAR, @dataAtual, 103))
				SET @dataAtual = DATEADD(DAY, 3, @dataAtual)
				SET @contador = @contador + 1
			END
		END
	END
		