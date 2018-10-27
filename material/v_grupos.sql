CREATE VIEW v_grupos
AS
SELECT t.idTime, g.grupo, t.nomeTime FROM times t
INNER JOIN grupos g
ON
g.idTime = t.idTime
ORDER BY grupo

SELECT * FROM grupos

SELECT * FROM times

SELECT * FROM v_grupos WHERE grupo = 'A'