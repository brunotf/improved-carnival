CREATE DATABASE paulistao
GO
USE paulistao

CREATE TABLE times (
	idTime INT NOT NULL IDENTITY PRIMARY KEY,
	nomeTime VARCHAR(50) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estadio VARCHAR(100) NOT NULL 
)

CREATE TABLE grupo(
	grupo CHAR(1) NOT NULL,
	idTime INT,
	FOREIGN KEY (idTime) REFERENCES times(idTime)
)


CREATE TABLE jogos(
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

CREATE PROCEDURE sp_dividirGrupos(@out VARCHAR(MAX) OUTPUT)
AS
	DECLARE @CLUBE VARCHAR(100),
			@GRUPOID INT,
			@EQUIPEID INT

	SET @CLUBE = (SELECT nomeTime FROM times WHERE idTime = @ALEATORIO)

	IF (@CLUBE = 'São Paulo Futebol Clube')
	BEGIN
		INSERT INTO grupo VALUES ('A', @CLUBE)
	END

	IF (@CLUBE = 'Sociedade Esporte Palmeiras')
	BEGIN
		INSERT INTO grupo VALUES ('B', @CLUBE)
	END

	IF (@CLUBE = 'Sport Club Corinthians Paulista')
	BEGIN
		INSERT INTO grupo VALUES ('C', @CLUBE)
	END

	IF (@CLUBE = 'Santos Futebol Clube')
	BEGIN
		INSERT INTO grupo VALUES ('D', @CLUBE)
	END


	IF (UPPER(@CLUBE) != 'São Paulo Futebol Clube'
		AND UPPER(@CLUBE) != 'Sociedade Esporte Palmeiras'
		AND UPPER(@CLUBE) != 'Sport Club Corinthians Paulista'
		AND UPPER(@CLUBE) != 'Santos Futebol Clube')
	BEGIN
		IF (UPPER(@GRUPO) = 'A')
		BEGIN
		SET @GRUPOID = (SELECT idEquipe FROM grupo WHERE grupo = 'A') 
		SET @EQUIPEID = (SELECT idEquipe FROM equipe WHERE idEquipe = @ALEATORIO)
			IF (@GRUPOID != @EQUIPEID)
			BEGIN
				INSERT INTO grupo VALUES ('A', @ALEATORIO)
			END
		END

		IF (UPPER(@GRUPO) = 'B')
		BEGIN
		SET @GRUPOID = (SELECT idEquipe FROM grupo WHERE grupo = 'B') 
		SET @EQUIPEID = (SELECT idEquipe FROM equipe WHERE idEquipe = @ALEATORIO)
			IF (@GRUPOID != @EQUIPEID)
			BEGIN
				INSERT INTO grupo VALUES ('B', @ALEATORIO)
			END
		END

		IF (UPPER(@GRUPO) = 'C')
		BEGIN
		SET @GRUPOID = (SELECT idEquipe FROM grupo WHERE grupo = 'C') 
		SET @EQUIPEID = (SELECT idEquipe FROM equipe WHERE idEquipe = @ALEATORIO)
			IF (@GRUPOID != @EQUIPEID)
			BEGIN
				INSERT INTO grupo VALUES ('C', @ALEATORIO)
			END
		END

		IF (UPPER(@GRUPO) = 'D')
		BEGIN
		SET @GRUPOID = (SELECT idEquipe FROM grupo WHERE grupo = 'D') 
		SET @EQUIPEID = (SELECT idEquipe FROM equipe WHERE idEquipe = @ALEATORIO)
			IF (@GRUPOID != @EQUIPEID)
			BEGIN
				INSERT INTO grupo VALUES ('D', @ALEATORIO)
			END
		END

	ELSE
	BEGIN
		RAISERROR ('Time já inserido', 16, 1)
	END
	END