CREATE FUNCTION fn_validagrupo(@GRUPO CHAR(1))
RETURNS @tabela TABLE (
	 nomeTime VARCHAR(100),
	 numJogosDisputados INT,
	 vitorias INT,
	 empates INT,
	 derrotas INT,
	 golsMarcados INT,
	 golsSofridos INT,
	 saldoGols INT,
	 pontos INT
)
AS
BEGIN
	DECLARE @nomeTime VARCHAR(100),
			@numJogosDisputados INT,
			@vitorias INT,
			@empates INT,
			@derrotas INT,
			@golsMarcados INT,
			@golsSofridos INT,
			@saldoGols INT,
			@pontos INT



END