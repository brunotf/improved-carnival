DROP VIEW v_jogos
GO
CREATE VIEW v_jogos
AS
	SELECT ta.nomeTime AS 'TIME A', tb.nomeTime AS 'TIME B', j.golsTimeA AS 'GOLS A', j.golsTimeB AS 'GOLS B', j.dataJogo AS DATA_JOGO FROM jogos j
	INNER JOIN times ta
	ON
	j.idTimeA = ta.idTime
	INNER JOIN times tb
	ON
	j.idTimeB = tb.idTime

SELECT * FROM v_jogos WHERE DATA_JOGO = '30/01/2019'

SELECT * FROM v_jogos WHERE DATA_JOGO = '03/02/2019'

SELECT * FROM v_jogos WHERE DATA_JOGO = '06/02/2019'

SELECT * FROM v_jogos WHERE DATA_JOGO = '10/02/2019'

SELECT * FROM v_jogos WHERE DATA_JOGO = '13/02/2019'

SELECT * FROM v_jogos ORDER BY [TIME A]

SELECT * FROM v_jogos ORDER BY [TIME B]

SELECT * FROM jogos WHERE idTimeA = 1 OR idTimeB = 1