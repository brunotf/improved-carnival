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
(1, 'Esporte Clube �gua Santa', 'Diadema', 'Distrital do Inamar'),
(2, 'Gr�mio Osasco Audax', 'Osasco', 'Jos� Liberatti'),
(3, 'Botafogo Futebol Clube', 'Ribeir�o Preto', 'Santa Cruz'),
(4, 'Capivariano Futebol Clube', 'Capivari', 'Arena Capivari'),
(5, 'Sport Club Corinthians Paulista', 'S�o Paulo', 'Arena Corinthians'),
(6, 'Associa��o Ferrovi�ria de Esportes', 'Araraquara', 'Fonte Luminosa'),
(7, 'Ituano Futebol Clube', 'Itu', 'Novelli J�nior'),
(8, 'Clube Atl�tico Linense', 'Lins', 'Gilberto Siqueira Lopes'),
(9, 'Mogi Mirim Esporte Clube', 'Mogi Mirim', 'Vail Chaves'),
(10, 'Gr�mio Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi'),
(11, 'Oeste Futebol Clube', 'It�polis', 'Amaros'),
(12, 'Sociedade Esporte Palmeiras', 'S�o Paulo', 'Allianz Parque'),
(13, 'Associa��o Atl�tica Ponte Preta', 'Campinas', 'Mois�s Lucarelli'),
(14, 'Red Bull Brasil', 'Campinas', 'Mois�s Lucarelli'),
(15, 'Rio Clario Futebol Clube', 'Rio Claro', 'Augusto Schmidt Filho'),
(16, 'Santos Futebol Clube', 'Santos', 'Vila Belmiro'),
(17, 'Esporte Clube S�o Bento', 'Sorocaba', 'Walter Ribeiro'),
(18, 'S�o Bernardo Futebol Clube', 'S�o Bernardo do Campo', 'Primeiro de Maio'),
(19, 'S�o Paulo Futebol Clube', 'S�o Paulo', 'Morumbi'),
(20, 'Esporte Clube XV de Novembro', 'Piracicaba', 'Bar�o de Serra Negra')

SELECT COUNT (idTime) FROM times AS QTD WHERE idTime <= 5 

CREATE TABLE grupos (
	grupo CHAR(1) NOT NULL,
	idTime INT,
	FOREIGN KEY (idTime) REFERENCES times(idTime)
)

CREATE TABLE jogos (
	idTimeA INT NOT NULL,
	idTimeB INT NOT NULL,
	golsTimeA INT NULL,
	golsTimeB INT NULL,
	dataJogo DATETIME
)

CREATE TABLE rodada (
	dataRodada DATETIME,
	idRodada INT NOT NULL,
	FOREIGN KEY (dataRodada) REFERENCES jogos(dataJogo)
)

CREATE PROCEDURE sp_dividirGrupos(@CLUBE VARCHAR(100), @out VARCHAR(MAX) OUTPUT)
AS
	DECLARE @CONTADOR INT,
			@IDTIME INT,
			@CABECADECHAVE INT,
			@SAOPAULO INT,
			@SANTOS INT,
			@PALMEIRAS INT,
			@CURINTIA INT

	SET @SAOPAULO = (SELECT idTime FROM times WHERE nomeTime = 'S�o Paulo Futebol Clube')
	SET @SANTOS = (SELECT idTime FROM times WHERE nomeTime = 'Santos Futebol Clube')
	SET @PALMEIRAS = (SELECT idTime FROM times WHERE nomeTime = 'Sociedade Esporte Palmeiras')
	SET @CURINTIA = (SELECT idTime FROM times WHERE nomeTime = 'Sport Club Corinthians Paulista')

	SET @IDTIME = (SELECT idTime FROM times WHERE nomeTime = @CLUBE)

	IF (@CLUBE = 'S�o Paulo Futebol Clube' OR 
		@CLUBE = 'Sociedade Esporte Palmeiras' OR
		@CLUBE = 'Sport Club Corinthians Paulista' OR
		@CLUBE = 'Santos Futebol Clube')
	BEGIN
		IF (@CLUBE = 'S�o Paulo Futebol Clube')
		BEGIN
			SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE grupo = 'A' AND idTime = @SANTOS OR idTime = @CURINTIA OR idTime = @PALMEIRAS)
			IF (@SAOPAULO != @CABECADECHAVE)
			BEGIN
				SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'A')
				IF (@CONTADOR < 5)
				BEGIN 
					INSERT INTO grupos VALUES ('A', @SAOPAULO)
				END
				ELSE
				BEGIN
					SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE grupo = 'B' AND idTime = @SANTOS OR idTime = @CURINTIA OR idTime = @PALMEIRAS)
					IF (@SAOPAULO != @CABECADECHAVE)
					BEGIN
						SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'B')
						IF (@CONTADOR < 5)
						BEGIN 
							INSERT INTO grupos VALUES ('B', @SAOPAULO)
						END
						ELSE
						BEGIN
							SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE grupo = 'C' AND idTime = @SANTOS OR idTime = @CURINTIA OR idTime = @PALMEIRAS)
							IF (@SAOPAULO != @CABECADECHAVE)
							BEGIN
								SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'C')
								IF (@CONTADOR < 5)
								BEGIN 
									INSERT INTO grupos VALUES ('C', @SAOPAULO)
								END
								ELSE
								BEGIN
									SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE grupo = 'D' AND idTime = @SANTOS OR idTime = @CURINTIA OR idTime = @PALMEIRAS)
									IF (@SAOPAULO != @CABECADECHAVE)
									BEGIN
										SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'D')
										IF (@CONTADOR < 5)
										BEGIN
											INSERT INTO grupos VALUES ('D', @SAOPAULO)
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
			SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE grupo = 'B' AND idTime = @SANTOS OR idTime = @CURINTIA OR idTime = @PALMEIRAS)
			IF (@SAOPAULO != @CABECADECHAVE)
			BEGIN
				SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'B')
				IF (@CONTADOR < 5)
				BEGIN 
					INSERT INTO grupos VALUES ('B', @SAOPAULO)
				END
				ELSE
				BEGIN
					SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE grupo = 'C' AND idTime = @SANTOS OR idTime = @CURINTIA OR idTime = @PALMEIRAS)
					IF (@SAOPAULO != @CABECADECHAVE)
					BEGIN
						SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'C')
						IF (@CONTADOR < 5)
						BEGIN 
							INSERT INTO grupos VALUES ('C', @SAOPAULO)
						END
						ELSE
						BEGIN
							SET @CABECADECHAVE = (SELECT idTime FROM grupos WHERE grupo = 'D' AND idTime = @SANTOS OR idTime = @CURINTIA OR idTime = @PALMEIRAS)
							IF (@SAOPAULO != @CABECADECHAVE)
							BEGIN
								SET @CONTADOR = (SELECT COUNT(idTime) FROM grupos WHERE grupo = 'D')
								IF (@CONTADOR < 5)
								BEGIN
									INSERT INTO grupos VALUES ('D', @SAOPAULO)
								END
							END
						END
					END
				END
			END




		END
	END
									


	--	BEGIN TRY
	--		INSERT INTO grupos VALUES
	--	END TRY
	--	BEGIN CATCH
	--		RAISERROR ('Time j� inserido', 16, 1)
	--	END CATCH

