-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes.
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre, tipo FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
-- 2. Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2, telefono, tipo FROM persona  WHERE tipo = 'alumno' AND (telefono IS NULL);
-- 3. Retorna el llistat dels/les alumnes que van néixer en 1999.
Select * FROM persona WHERE tipo = 'alumno' AND YEAR (fecha_nacimiento) = 1999;
-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades
-- i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo = 'profesor' AND (telefono IS NULL) AND nif LIKE '%k';
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre,
-- en el tercer curs del grau que té l'identificador 7.
SELECT id, nombre AS asignatura, cuatrimestre, curso FROM asignatura WHERE curso = 3 AND cuatrimestre = 2;
-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des.
-- El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament.
-- El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS departamento FROM profesor pro JOIN persona p ON pro.id_profesor = p.id JOIN departamento d ON pro.id_departamento = d.id ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre AS asignatura, c.anyo_inicio, c.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura m ON p.id = m.id_alumno JOIN asignatura a ON m.id_asignatura = a.id JOIN curso_escolar c ON m.id_curso_escolar = c.id WHERE p.nif = '26902806M';
-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna
-- assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre AS departamento, per.nombre, per.apellido1, per.tipo, g.nombre AS grado FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN persona per ON per.id = p.id_profesor JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN grado g ON a.id_grado = g.id;
-- 9. Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019. per.nombre, per.apellido1, per.apellido2
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura m on p.id = m.id_alumno WHERE m.id_curso_escolar = (SELECT id FROM curso_escolar WHERE anyo_inicio = 2018  AND anyo_fin = 2019);

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des.
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat.
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a.
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pro ON p.id = pro.id_profesor LEFT JOIN departamento d ON pro.id_departamento = d.id WHERE p.tipo = 'profesor' ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;
-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE p.tipo = 'profesor' AND pr.id_departamento IS NULL;
-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT d.nombre AS departamento FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento WHERE p.id_departamento IS NULL;
-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN profesor pro ON p.id = pro.id_profesor LEFT JOIN asignatura a ON pro.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;
-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.nombre AS asignatura FROM asignatura a WHERE id_profesor IS NULL;
-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT d.nombre AS departamento FROM departamento d LEFT JOIN profesor p On d.id = p.id_departamento LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor LEFT JOIN alumno_se_matricula_asignatura m ON a.id = m.id_asignatura WHERE m.id_asignatura IS NULL;

-- Consultes resum:

-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) AS total_alumnos FROM persona WHERE tipo = 'alumno';
-- 2. Calcula quants/es alumnes van néixer en 1999.
SELECT COUNT(*) AS alumnos_del_99 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
-- 3. Calcula quants/es professors/es hi ha en cada departament.
-- El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament.
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS numero_profes FROM departamento d JOIN profesor p ON d.id = p.id_departamento GROUP BY d.id, d.nombre ORDER BY  numero_profes DESC;
-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells.
-- Té en compte que poden existir departaments que no tenen professors/es associats/des.
-- Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre AS departament, COUNT(p.id_profesor) AS numero_profes FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento GROUP BY d.id, d.nombre ORDER BY numero_profes DESC;
-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun.
-- Té en compte que poden existir graus que no tenen assignatures associades.
-- Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id, g.nombre;
-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun,
-- dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignatura FROM grado g JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id, g.nombre HAVING COUNT(a.id) > 40;
-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura.
-- El resultat ha de tenir tres columnes: nom del grau,
-- tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre AS grado, a.tipo, SUM(a.creditos) AS suma_creditos FROM grado g JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id, g.nombre, a.tipo;
-- 8. Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars.
-- El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats/des.
SELECT c.anyo_inicio, COUNT(m.id_alumno) AS num_alumnos_matriculados FROM curso_escolar c JOIN alumno_se_matricula_asignatura m ON c.id = m.id_alumno GROUP BY c.id, c.anyo_inicio;
-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a.
-- El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura.
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures.
-- El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS nombre_asignatura FROM persona p LEFT JOIN profesor pro ON p.id = pro.id_profesor LEFT JOIN asignatura a ON pro.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' GROUP BY p.id, p.nombre, p.apellido1, p.apellido2 ORDER BY nombre_asignatura DESC;
-- 10. Retorna totes les dades de l'alumne més jove.
SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN profesor pro ON p.id = pro.id_profesor LEFT JOIN asignatura a ON pro.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND pro.id_departamento IS NOT NULL AND a.id_profesor IS NULL ORDER BY nombre ASC;

