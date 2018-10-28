CREATE TRIGGER t_protegerodada
ON rodada
FOR INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é possivel adicionar ou excluir resultados.', 16, 1)
END