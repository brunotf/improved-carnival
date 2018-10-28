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
			@idTime INT,
			@numJogosDisputados INT,
			@vitorias INT,
			@empates INT,
			@derrotas INT,
			@golsMarcados INT,
			@golsSofridos INT,
			@saldoGols INT,
			@pontos INT,

			@timeA INT,
			@timeB INT,
			@golsA INT,
			@golsB INT 

			DECLARE c_grupo CURSOR FOR SELECT idTime FROM grupos WHERE grupo = @GRUPO
			OPEN c_grupo
			FETCH NEXT FROM c_grupo INTO @idTime
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @numJogosDisputados = COUNT((SELECT * FROM jogos WHERE idTimeA = @idTime OR idTimeB = @idTime))

				DECLARE c_jogos CURSOR FOR SELECT idTimeA, idTimeB, golsTimeA, golsTimeB FROM jogos WHERE idTimeA = @idTime OR idTimeB = @idTime
				OPEN c_jogos
				FETCH NEXT FROM c_jogos INTO @timeA, @timeB, @golsA, @golsB
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@timeA = @idTime)
					BEGIN
						IF (@golsA > @golsB)
							SET @vitorias = @vitorias + 1
						END
					END
					ELSE
					BEGIN
						IF (@golsB > @golsB)
						BEGIN
							SET @vitorias = @vitorias + 1
						END
					END
				END



			END

END
