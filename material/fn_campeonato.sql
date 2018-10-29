DROP FUNCTION fn_campeonato
GO
CREATE FUNCTION fn_campeonato()
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

			SET @vitorias = 0
			SET @empates = 0
			SET @derrotas = 0
			SET @golsMarcados = 0
			SET @golsSofridos = 0
			SET @saldoGols = 0

			DECLARE c_time CURSOR FOR SELECT idTime FROM times
			OPEN c_time
			FETCH NEXT FROM c_time INTO @idTime
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @numJogosDisputados = (SELECT COUNT(*) FROM jogos WHERE idTimeA = @idTime OR idTimeB = @idTime) 
				SET @nomeTime = (SELECT nomeTime FROM times WHERE idTime = @idTime)

				DECLARE c_jogos CURSOR FOR SELECT idTimeA, idTimeB, golsTimeA, golsTimeB FROM jogos WHERE idTimeA = @idTime OR idTimeB = @idTime
				OPEN c_jogos
				FETCH NEXT FROM c_jogos INTO @timeA, @timeB, @golsA, @golsB
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@timeA = @idTime)
					BEGIN
						IF (@golsA > @golsB)
						BEGIN
							SET @vitorias = @vitorias + 1
							SET @golsMarcados = @golsMarcados + @golsA
							SET @golsSofridos = @golsSofridos + @golsB
						END
						ELSE
						BEGIN
							IF (@golsA = @golsB)
							BEGIN
								SET @empates = @empates + 1
								SET @golsMarcados = @golsMarcados + @golsA
								SET @golsSofridos = @golsSofridos + @golsB
							END
							ELSE
							BEGIN
								IF (@golsA < @golsB)
								BEGIN
									SET @derrotas = @derrotas + 1
									SET @golsMarcados = @golsMarcados + @golsA
									SET @golsSofridos = @golsSofridos + @golsB
								END
							END
						END
					END
					ELSE
					BEGIN
						IF (@timeB = @idTime)
						BEGIN
							IF (@golsB > @golsA)
							BEGIN
								SET @vitorias = @vitorias + 1
								SET @golsMarcados = @golsMarcados + @golsB
								SET @golsSofridos = @golsSofridos + @golsA
							END
							ELSE
							BEGIN
								IF (@golsA = @golsB)
								BEGIN
									SET @empates = @empates + 1
									SET @golsMarcados = @golsMarcados + @golsB
									SET @golsSofridos = @golsSofridos + @golsA
								END
								ELSE
								BEGIN
									IF (@golsA < @golsB)
									BEGIN
										SET @derrotas = @derrotas + 1
										SET @golsMarcados = @golsMarcados + @golsB
										SET @golsSofridos = @golsSofridos + @golsA
									END
								END
							END
						END
					END

					SET @saldoGols = @golsMarcados - @golsSofridos
					SET @pontos = (@vitorias * 3) + @empates

					FETCH NEXT FROM c_jogos INTO @timeA, @timeB, @golsA, @golsB
				END

				INSERT INTO @tabela VALUES(@nomeTime, @numJogosDisputados, @vitorias, @empates, @derrotas, @golsMarcados, @golsSofridos, @saldoGols, @pontos)

				CLOSE c_jogos
				DEALLOCATE c_jogos

				SET @numJogosDisputados = 0
				SET @vitorias = 0
				SET @empates = 0
				SET @derrotas = 0
				SET @golsMarcados = 0
				SET @golsSofridos = 0
				SET @saldoGols = 0
				SET @pontos = 0

				FETCH NEXT FROM c_time INTO @idTime
			END

			CLOSE c_time
			DEALLOCATE c_time

			RETURN

END

select * from fn_campeonato() ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT TOP(4) * FROM fn_campeonato() ORDER BY pontos ASC, vitorias ASC, golsMarcados ASC