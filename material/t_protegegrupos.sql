CREATE TRIGGER t_protegegrupos
ON grupos
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é possível alterar os registros dos grupos', 16, 1)
END