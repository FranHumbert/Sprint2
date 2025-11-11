-- 1.Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select apellido1, apellido2, nombre, tipo from persona where tipo = "alumno" order by apellido1 asc, apellido2 asc, nombre asc;
-- 2.Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
select nombre, apellido1, apellido2, tipo, telefono from persona where tipo = "alumno" and telefono is null;
-- 3.Retorna el llistat dels/les alumnes que van néixer en 1999.
select nombre, apellido1, tipo, fecha_nacimiento from persona where tipo = "alumno" and year (fecha_nacimiento) = 1999;
-- 4.Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades 
-- i a més el seu NIF acaba en K.
select nombre, apellido1, apellido2, tipo, telefono, nif from persona where tipo = "profesor" and telefono is null and nif like "%k";
-- 5.Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, 
-- en el tercer curs del grau que té l'identificador 7.
select nombre, cuatrimestre, curso, id_grado from asignatura where cuatrimestre = 1 and curso = 3 and id_grado = 7;
-- 6.Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. 
-- El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
-- El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
select per.apellido1, per.apellido2, per.nombre, dep.nombre as departamento from profesor pro join persona per on pro.id_profesor = per.id join departamento dep on pro.id_departamento = dep.id order by apellido1 asc, apellido2 asc, nombre asc;
-- 7.Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
select asi.nombre as asignatura, curso.anyo_inicio, curso.anyo_fin from persona per join alumno_se_matricula_asignatura matricula on per.id = matricula.id_alumno join asignatura asi on matricula.id_asignatura = asi.id join curso_escolar curso on matricula.id_curso_escolar = curso.id where per.nif = "26902806M";
-- 8.Retorna un llistat amb el nom de tots els departaments que tenen professors/es que 
-- imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

-- 9.Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- 1.Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat.
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select d.nombre as departamento, p.apellido1, p.apellido2, p.nombre from persona p left join profesor pro on p.id = pro.id_profesor left join departamento d on pro.id_departamento = d.id where p.tipo = 'profesor' order by d.nombre, p.apellido1, p.apellido2, p.nombre;
-- 2.Retorna un llistat amb els professors/es que no estan associats a un departament.
select dep.nombre as departamento, p.apellido1, p.nombre from persona p right join profesor prof  on p.id = prof.id_profesor left join departamento dep on prof.id_profesor = dep.id where dep.nombre is null;
-- 3.Retorna un llistat amb els departaments que no tenen professors/es associats.
select dep.nombre as departamento from departamento dep left join profesor prof on dep.id = prof.id_departamento where prof.id_departamento is null;
-- 4.Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
select p.nombre, p.apellido1 from persona p right join profesor prof on p.id = prof.id_profesor left join asignatura a on prof.id_profesor = a.id_profesor where a.nombre is null;
-- 5.Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
select a.nombre from asignatura a left join profesor prof  on a.id_profesor = prof.id_profesor where prof.id_profesor is null;
-- 6.Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.


-- Consultes resum:
-- 1.Retorna el nombre total d'alumnes que hi ha.
select count(*) as total_alumnos from persona where tipo = 'alumno';
-- 2.Calcula quants/es alumnes van néixer en 1999.
SELECT count(*) AS alumnos_del_99 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
-- 3.Calcula quants/es professors/es hi ha en cada departament. 
-- El resultat només ha de mostrar dues columnes, 
-- una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
select dep.nombre as departamento, count(prof.id_profesor) as numero_profes from departamento dep left join profesor prof on dep.id = prof.id_departamento group by dep.nombre order by numero_profes desc;
-- 4.Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
-- Té en compte que poden existir departaments que no tenen professors/es associats/des.
-- Aquests departaments també han d'aparèixer en el llistat.
select dep.nombre as departamento, count(prof.id_profesor) as numero_profes from departamento dep left join profesor prof on dep.id = prof.id_departamento group by dep.nombre order by numero_profes desc;
-- 5.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun.
-- Té en compte que poden existir graus que no tenen assignatures associades.
-- Aquests graus també han d'aparèixer en el llistat.
-- El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
select g.nombre as grado, count(a.id) as numero_asignaturas from grado g left join asignatura a on g.id = a.id_grado group by g.id, g.nombre;
-- 6.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun,
--  dels graus que tinguin més de 40 assignatures associades.
select g.nombre as grado, count(a.id) as numero_asignatura from grado g join asignatura a on g.id = a.id_grado group by g.id, g.nombre having count(a.id) > 40;
-- 7.Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura.
-- El resultat ha de tenir tres columnes: nom del grau,
-- tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

-- 8.Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars.
-- El resultat haurà de mostrar dues columnes,
-- una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats/des.
select c.anyo_inicio, COUNT(m.id_alumno) as num_alumnos_matriculados from curso_escolar c left join alumno_se_matricula_asignatura m on c.id = m.id_alumno group by c.id, c.anyo_inicio;
-- 9.Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a.
-- El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura.
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures.
-- El resultat estarà ordenat de major a menor pel nombre d'assignatures.

-- 10.Retorna totes les dades de l'alumne més jove.
select * from persona where tipo = 'alumno' order by fecha_nacimiento desc limit 1;
-- 11.Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
select p.nombre, p.apellido1, p.apellido2 from persona p left join profesor on p.id = profesor.id_profesor left join departamento dep on profesor.id_departamento = dep.id left join asignatura a on profesor.id_profesor = a.id_profesor group by p.nombre, p.apellido1, p.apellido2 having count(a.nombre) = 0;
