CREATE PROCEDURE sp_dividirGrupos(@CLUBE VARCHAR(100), @out VARCHAR(MAX) OUTPUT)
AS
	DECLARE @CONTADOR INT,
			@CLUBEID INT,
			@CABECADECHAVE INT,
			@SAOPAULO INT,
			@SANTOS INT,
			@PALMEIRAS INT,
			@CURINTIA INT

	SET @SAOPAULO = (SELECT idTime FROM times WHERE nomeTime = 'São Paulo Futebol Clube')
	SET @SANTOS = (SELECT idTime FROM times WHERE nomeTime = 'Santos Futebol Clube')
	SET @PALMEIRAS = (SELECT idTime FROM times WHERE nomeTime = 'Sociedade Esporte Palmeiras')
	SET @CURINTIA = (SELECT idTime FROM times WHERE nomeTime = 'Sport Club Corinthians Paulista')

	SET @CLUBEID = (SELECT idTime FROM times WHERE nomeTime = @CLUBE)

	IF (@CLUBE = 'São Paulo Futebol Clube' OR
		@CLUBE = 'Sociedade Esporte Palmeiras' OR
		@CLUBE = 'Sport Club Corinthians Paulista' OR
		@CLUBE = 'Santos Futebol Clube')
	BEGIN
		IF (@CLUBE = 'São Paulo Futebol Clube')
		BEGIN
			IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
														(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
			BEGIN
				SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
																		(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
			END
			ELSE
			BEGIN
				SET @CABECADECHAVE = 0
			END
			SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'A')
			IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
			BEGIN
				BEGIN TRY
					INSERT INTO grupos VALUES ('A', @SAOPAULO)
				END TRY
				BEGIN CATCH
					RAISERROR('TIME JA INSERIDO', 16, 1)
				END CATCH
			END
			ELSE
			BEGIN
				IF EXISTS(SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
															(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
				BEGIN
					SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																			(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
				END
				ELSE
				BEGIN
					SET @CABECADECHAVE = 0
				END
				SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'B')
				IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
				BEGIN
					BEGIN TRY
						INSERT INTO grupos VALUES ('B', @SAOPAULO)
					END TRY
					BEGIN CATCH
						RAISERROR('TIME JA INSERIDO', 16, 1)
					END CATCH
				END
				ELSE
				BEGIN
					IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
					BEGIN
						SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																				(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
					END
					ELSE
					BEGIN
						SET @CABECADECHAVE = 0
					END
					SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'C')
					IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
					BEGIN
						BEGIN TRY 
							INSERT INTO grupos VALUES ('C', @SAOPAULO)
						END TRY
						BEGIN CATCH
							RAISERROR('TIME JA INSERIDO', 16, 1)
						END CATCH
					END
					ELSE
					BEGIN
						IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																	(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
						BEGIN
							SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																					(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
						END
						ELSE
						BEGIN 
							SET @CABECADECHAVE = 0
						END
						SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'D')
						IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
						BEGIN
							BEGIN TRY
								INSERT INTO grupos VALUES ('D', @SAOPAULO)
							END TRY
							BEGIN CATCH
								RAISERROR('TIME JA INSERIDO', 16, 1)
							END CATCH
						END
					END
				END
			END
		END
		ELSE
		BEGIN
			IF (@CLUBE = 'Sociedade Esporte Palmeiras')
			BEGIN
				IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
															(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
				BEGIN
					SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
																			(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
				END
				ELSE
				BEGIN
					SET @CABECADECHAVE = 0
				END
				SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'A')
				IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
				BEGIN
					BEGIN TRY
						INSERT INTO grupos VALUES ('A', @PALMEIRAS)
					END TRY
					BEGIN CATCH
						RAISERROR('TIME JA INSERIDO', 16, 1)
					END CATCH
				END
				ELSE
				BEGIN
					IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
					BEGIN
						SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																				(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
					END
					ELSE
					BEGIN
						SET @CABECADECHAVE = 0
					END
					SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'B')
					IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
					BEGIN
						BEGIN TRY
							INSERT INTO grupos VALUES ('B', @PALMEIRAS)
						END TRY
						BEGIN CATCH
							RAISERROR('TIME JA INSERIDO', 16, 1)
						END CATCH
					END
					ELSE
					BEGIN
						IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																	(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
						BEGIN
							SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																					(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
						END
						ELSE
						BEGIN
							SET @CABECADECHAVE = 0
						END
						SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'C')
						IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
						BEGIN
							BEGIN TRY
								INSERT INTO grupos VALUES ('C', @PALMEIRAS)
							END TRY
							BEGIN CATCH
								RAISERROR('TIME JA INSERIDO', 16, 1)
							END CATCH
						END
						ELSE
						BEGIN
							IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																		(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
							BEGIN
								SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																						(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
							END
							ELSE
							BEGIN
								SET @CABECADECHAVE = 0
							END
							SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'D')
							IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
							BEGIN
								BEGIN TRY
									INSERT INTO grupos VALUES ('D', @PALMEIRAS)
								END TRY
								BEGIN CATCH
									RAISERROR('TIME JA INSERIDO', 16, 1)
								END CATCH
							END
						END
					END
				END
			END
			ELSE
			BEGIN
				IF (@CLUBE = 'Sport Club Corinthians Paulista')
				BEGIN
					IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
																(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
					BEGIN
						SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
																				(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
					END
					ELSE
					BEGIN
						SET @CABECADECHAVE = 0
					END
					SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'A')
					IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
					BEGIN
						BEGIN TRY
							INSERT INTO grupos VALUES ('A', @CURINTIA)
						END TRY
						BEGIN CATCH
							RAISERROR('TIME JA INSERIDO', 16, 1)
						END CATCH
					END
					ELSE
					BEGIN
						IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																	(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
						BEGIN
							SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																					(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
						END
						ELSE
						BEGIN
							SET @CABECADECHAVE = 0
						END
						SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'B')
						IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
						BEGIN
							BEGIN TRY
								INSERT INTO grupos VALUES ('B', @CURINTIA)
							END TRY
							BEGIN CATCH
								RAISERROR('TIME JA INSERIDO', 16, 1)
							END CATCH
						END
						ELSE
						BEGIN
							IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																		(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
							BEGIN
								SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																						(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
							END
							ELSE
							BEGIN
								SET @CABECADECHAVE = 0
							END
							SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'C')
							IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
							BEGIN
								BEGIN TRY
									INSERT INTO grupos VALUES ('C', @CURINTIA)
								END TRY
								BEGIN CATCH
									RAISERROR('TIME JA INSERIDO', 16, 1)
								END CATCH
							END
							ELSE
							BEGIN
								IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																			(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
								BEGIN
									SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																							(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
								END
								ELSE
								BEGIN
									SET @CABECADECHAVE = 0
								END
								SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'D')
								IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
								BEGIN
									BEGIN TRY
										INSERT INTO grupos VALUES ('D', @CURINTIA)
									END TRY
									BEGIN CATCH
										RAISERROR('TIME JA INSERIDO', 16, 1)
									END CATCH
								END
							END
						END
					END
				END
				ELSE
				BEGIN
					IF (@CLUBE = 'Santos Futebol Clube')
					BEGIN
						IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
																	(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
						BEGIN
							SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
																					(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
						END
						ELSE
						BEGIN
							SET @CABECADECHAVE = 0
						END
						SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'A')
						IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
						BEGIN
							BEGIN TRY
								INSERT INTO grupos VALUES ('A', @SANTOS)
							END TRY
							BEGIN CATCH
								RAISERROR('TIME JA INSERIDO', 16, 1)
							END CATCH
						END
						ELSE
						BEGIN
							IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																		(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
							BEGIN
								SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																						(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
							END
							ELSE
							BEGIN
								SET @CABECADECHAVE = 0
							END
							SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'B')
							IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
							BEGIN
								BEGIN TRY
									INSERT INTO grupos VALUES ('B', @SANTOS)
								END TRY
								BEGIN CATCH
									RAISERROR('TIME JA INSERIDO', 16, 1)
								END CATCH
							END
							ELSE
							BEGIN
								IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																			(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
								BEGIN
									SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																							(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
								END
								ELSE
								BEGIN
									SET @CABECADECHAVE = 0
								END
								SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'C')
								IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
								BEGIN
									BEGIN TRY
										INSERT INTO grupos VALUES ('C', @SANTOS)
									END TRY
									BEGIN CATCH
										RAISERROR('TIME JA INSERIDO', 16, 1)
									END CATCH
								END
								ELSE
								BEGIN
									IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																				(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
									BEGIN
										SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																								(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
									END
									ELSE
									BEGIN
										SET @CABECADECHAVE = 0
									END
									SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'D')
									IF (@CABECADECHAVE = 0 AND @CONTADOR < 5)
									BEGIN
										BEGIN TRY
											INSERT INTO grupos VALUES ('D', @SANTOS)
										END TRY
										BEGIN CATCH
											RAISERROR('TIME JA INSERIDO', 16, 1)
										END CATCH
									END
								END
							END
						END
					END				
				END
			END
		END
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
													(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
		BEGIN
			SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'A' AND idTime = @SANTOS) OR (grupo = 'A' AND idTime = @CURINTIA) OR
																	(grupo = 'A' AND idTime = @PALMEIRAS) OR (grupo = 'A' AND idTime = @SAOPAULO))
		END
		ELSE
		BEGIN
			SET @CABECADECHAVE = 0
		END
		SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'A')
		IF ((@CABECADECHAVE = 0 AND @CONTADOR < 4) OR (@CABECADECHAVE != 0 AND @CONTADOR < 5))
		BEGIN
			BEGIN TRY
				INSERT INTO grupos VALUES ('A', @CLUBEID)
			END TRY
			BEGIN CATCH
				RAISERROR('TIME JA INSERIDO', 16, 1)
			END CATCH
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
														(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
			BEGIN
				SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'B' AND idTime = @SANTOS) OR (grupo = 'B' AND idTime = @CURINTIA) OR
																		(grupo = 'B' AND idTime = @PALMEIRAS) OR (grupo = 'B' AND idTime = @SAOPAULO))
			END
			ELSE
			BEGIN
				SET @CABECADECHAVE = 0
			END
			SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'B')
			IF ((@CABECADECHAVE = 0 AND @CONTADOR < 4) OR (@CABECADECHAVE != 0 AND @CONTADOR < 5))
			BEGIN
				BEGIN TRY
					INSERT INTO grupos VALUES ('B', @CLUBEID)
				END TRY
				BEGIN CATCH
					RAISERROR('TIME JA INSERIDO', 16, 1)
				END CATCH		
			END
			ELSE
			BEGIN
				IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
															(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
				BEGIN
					SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'C' AND idTime = @SANTOS) OR (grupo = 'C' AND idTime = @CURINTIA) OR
																			(grupo = 'C' AND idTime = @PALMEIRAS) OR (grupo = 'C' AND idTime = @SAOPAULO))
				END
				ELSE
				BEGIN
					SET @CABECADECHAVE = 0
				END
				SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'C')
				IF ((@CABECADECHAVE = 0 AND @CONTADOR < 4) OR (@CABECADECHAVE != 0 AND @CONTADOR < 5))
				BEGIN
					BEGIN TRY
						INSERT INTO grupos VALUES ('C', @CLUBEID)
					END TRY
					BEGIN CATCH
						RAISERROR('TIME JA INSERIDO', 16, 1)
					END CATCH
				END
				ELSE
				BEGIN
					IF EXISTS (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
					BEGIN
						SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE (grupo = 'D' AND idTime = @SANTOS) OR (grupo = 'D' AND idTime = @CURINTIA) OR
																				(grupo = 'D' AND idTime = @PALMEIRAS) OR (grupo = 'D' AND idTime = @SAOPAULO))
					END
					ELSE
					BEGIN
						SET @CABECADECHAVE = 0
					END
					SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'D')
					IF ((@CABECADECHAVE = 0 AND @CONTADOR < 4) OR (@CABECADECHAVE != 0 AND @CONTADOR < 5))
					BEGIN
						BEGIN TRY
							INSERT INTO grupos VALUES ('D', @CLUBEID)
						END TRY
						BEGIN CATCH
							RAISERROR('TIME JA INSERIDO', 16, 1)
						END CATCH
					END
				END
			END
		END
	END