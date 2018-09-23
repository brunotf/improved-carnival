CREATE VIEW v_grupos
AS
SELECT nomeTime, grupo FROM times t
INNER JOIN grupos g
ON
g.idTime = t.idTime
ORDER BY grupo

SELECT * FROM v_grupos