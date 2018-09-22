CREATE DATABASE paulistao
GO
USE paulistao

CREATE TABLE times (
	idTime INT NOT NULL PRIMARY KEY,
	nomeTime VARCHAR(50) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estadio VARCHAR(100) NOT NULL 
)

INSERT INTO times VALUES 
(1, 'Esporte Clube Água Santa', 'Diadema', 'Distrital do Inamar'),
(2, 'Grêmio Osasco Audax', 'Osasco', 'José Liberatti'),
(3, 'Botafogo Futebol Clube', 'Ribeirão Preto', 'Santa Cruz'),
(4, 'Capivariano Futebol Clube', 'Capivari', 'Arena Capivari'),
(5, 'Sport Club Corinthians Paulista', 'São Paulo', 'Arena Corinthians'),
(6, 'Associação Ferroviária de Esportes', 'Araraquara', 'Fonte Luminosa'),
(7, 'Ituano Futebol Clube', 'Itu', 'Novelli Júnior'),
(8, 'Clube Atlético Linense', 'Lins', 'Gilberto Siqueira Lopes'),
(9, 'Mogi Mirim Esporte Clube', 'Mogi Mirim', 'Vail Chaves'),
(10, 'Grêmio Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi'),
(11, 'Oeste Futebol Clube', 'Itápolis', 'Amaros'),
(12, 'Sociedade Esporte Palmeiras', 'São Paulo', 'Allianz Parque'),
(13, 'Associação Atlética Ponte Preta', 'Campinas', 'Moisés Lucarelli'),
(14, 'Red Bull Brasil', 'Campinas', 'Moisés Lucarelli'),
(15, 'Rio Clario Futebol Clube', 'Rio Claro', 'Augusto Schmidt Filho'),
(16, 'Santos Futebol Clube', 'Santos', 'Vila Belmiro'),
(17, 'Esporte Clube São Bento', 'Sorocaba', 'Walter Ribeiro'),
(18, 'São Bernardo Futebol Clube', 'São Bernardo do Campo', 'Primeiro de Maio'),
(19, 'São Paulo Futebol Clube', 'São Paulo', 'Morumbi'),
(20, 'Esporte Clube XV de Novembro', 'Piracicaba', 'Barão de Serra Negra')

SELECT COUNT (idTime) FROM times AS QTD WHERE idTime <= 5 

DROP TABLE grupos
GO
CREATE TABLE grupos (
	grupo CHAR(1) NOT NULL,
	idTime INT PRIMARY KEY,
	FOREIGN KEY (idTime) REFERENCES times(idTime)
)

CREATE TABLE jogos (
	idTimeA INT NOT NULL,
	idTimeB INT NOT NULL,
	golsTimeA INT NULL,
	golsTimeB INT NULL,
	dataJogo DATETIME PRIMARY KEY
)

CREATE TABLE rodada (
	dataRodada DATETIME,
	idRodada INT NOT NULL,
	FOREIGN KEY (dataRodada) REFERENCES jogos(dataJogo)
)

CREATE VIEW v_grupos
AS
SELECT nomeTime, grupo FROM times t
INNER JOIN grupos g
ON
g.idTime = t.idTime

SELECT * FROM v_grupos



DECLARE @SAIDA VARCHAR(MAX)
exec sp_dividirGrupos 'Ituano Futebol Clube', @SAIDA
PRINT @SAIDA

DECLARE @SAIDA VARCHAR(MAX)
exec sp_dividirGrupos 'São Paulo Futebol Clube', @SAIDA
PRINT @SAIDA

DECLARE @SAIDA VARCHAR(MAX)
EXEC sp_dividirGrupos 'Associação Ferroviária de Esportes', @SAIDA
PRINT @SAIDA

DECLARE @SAIDA VARCHAR(MAX)
EXEC sp_dividirGrupos 'Sport Club Corinthians Paulista', @SAIDA
PRINT @SAIDA

drop procedure sp_dividirGrupos

CREATE PROCEDURE sp_dividirGrupos(@CLUBE VARCHAR(MAX), @out VARCHAR(MAX) OUTPUT)
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
