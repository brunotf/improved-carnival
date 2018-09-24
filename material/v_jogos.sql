DROP VIEW v_jogos
GO
CREATE VIEW v_jogos
AS
	SELECT ta.nomeTime AS 'TIME A', tb.nomeTime AS 'TIME B', j.golsTimeA AS GOLS_A, j.golsTimeB AS GOLS_B, j.dataJogo AS DATA_JOGO FROM jogos j
	INNER JOIN times ta
	ON
	j.idTimeA = ta.idTime
	INNER JOIN times tb
	ON
	j.idTimeB = tb.idTime

SELECT * FROM v_jogos WHERE DATA_JOGO = '30/01/2019'