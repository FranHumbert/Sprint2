-- Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.
SELECT count(p.id_producte) FROM detalls_comanda d JOIN productes p ON d.id_producte = p.id_producte JOIN comandes com ON d.id_comanda= com.id_comanda JOIN botigues b ON com.id_botiga = b.id_botiga WHERE p.tipus_producte = 'beguda' AND b.localitat = 'Barcelona';
-- Llista quantes comandes ha efectuat un determinat empleat/da.
SELECT e.id_empleat, e.nom, e.cognoms, COUNT(c.id_comanda) AS total_comandes FROM empleats e JOIN comandes c ON e.id_empleat = c.id_repartidor GROUP BY id_empleat, e.nom, e.cognoms;