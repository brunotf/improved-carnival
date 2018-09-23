CREATE VIEW v_jogos
AS
	SELECT ta.nomeTime AS 'TIME A', tb.nomeTime AS 'TIME B', j.golsTimeA AS GOLS_A, j.golsTimeB AS GOLS_B, CONVERT(CHAR, j.dataJogo, 103) AS DATA_JOGO FROM jogos j
	INNER JOIN times ta
	ON
	j.idTimeA = ta.idTime
	INNER JOIN times tb
	ON
	j.idTimeB = tb.idTime