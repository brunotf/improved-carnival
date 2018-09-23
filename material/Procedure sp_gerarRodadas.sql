--ADICIONA SETE DIAS NA DATA DE HOJE
SELECT DATEADD(DAY, 7, GETDATE())

--CONVERTE PARA DD/MM/YYYY
SELECT CONVERT(CHAR, DATEADD(DAY, 4, GETDATE()), 103)

--RETORNA O NOME DO DIA DA SEMANA
 SELECT DATENAME(W, DATEADD(DAY, 3, GETDATE()))
 
 --ARREDONDA NUMERO ALEATORIO PARA BAIXO ATE 12 
 SELECT ROUND(RAND() * 12, 0, 1);

SELECT * FROM grupos WHERE grupo = 'A'

select * from v_grupos v
INNER JOIN grupos g
ON
v.grupo = g.grupo
WHERE g.grupo = 'A'

CREATE PROCEDURE sp_inserirRodadas(@CLUBEA INT, @CLUBEB INT, @GOLSA INT, @GOLSB INT,
								     @DATAJOGO DATETIME, @OUT VARCHAR(MAX) OUTPUT)
AS
	IF EXISTS (SELECT * FROM jogos)
	BEGIN
		INSERT INTO jogos VALUES (@CLUBEA, @CLUBEB, @GOLSA, @GOLSB, @DATAJOGO)
	END
	ELSE
	BEGIN
		RAISERROR('RODADAS JA DEFINIDAS', 16, 1)
	END		



