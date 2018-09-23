CREATE DATABASE paulistao
GO
USE paulistao

CREATE TABLE times (
	idTime INT NOT NULL PRIMARY KEY,
	nomeTime VARCHAR(50) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estadio VARCHAR(100) NOT NULL 
)



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




