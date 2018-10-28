CREATE TRIGGER t_protegegrupos
ON grupos
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('N�o � poss�vel alterar os registros dos grupos', 16, 1)
END