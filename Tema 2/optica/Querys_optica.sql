-- Llista el total de compres d’un client/a.
SELECT c.nom, c.cognom, COUNT(v.id) AS total_compras, SUM(v.preu_venda) AS import_total FROM clients c JOIN vendes v ON c.id = v.id_client WHERE c.id = 10 GROUP BY c.id, c.nom, c.cognom;
-- Llista les diferents ulleres que ha venut un empleat durant un any.
SELECT e.nom, e.cognom, COUNT(DISTINCT v.id_ulleres) AS ulleres_diferents_venudes, SUM(v.preu_venda) AS facturacio_total
FROM empleats e JOIN vendes v ON e.id = v.id_empleat
WHERE e.id = 1 GROUP BY e.id, e.nom, e.cognom;
-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
SELECT DISTINCT p.id, p.nom FROM proveidors p JOIN marques m ON p.id = m.id_proveidor JOIN ulleres u ON m.id = u.id_marca JOIN vendes v ON u.id = v.id_ulleres;
