CREATE TRIGGER t_protegetimes
ON times
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é possível alterar os registros dos times.', 16, 1)
END
