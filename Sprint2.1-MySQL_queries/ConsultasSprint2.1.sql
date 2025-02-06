--BASE DE DATOS TIENDA:

--1 Llista el nom de tots els productes que hi ha en la taula "producto".
SELECT nombre FROM producto;

--2 Llista els noms i els preus de tots els productes de la taula "producto"

SELECT nombre, precio From producto;

--3 Llista totes les columnes de la taula "producto".
SELECT * FROM producto;

--4 Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans (USD).
SELECT nombre, precio, precio*1.1 AS precio_en _dolares FROM producto;

--5 Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans. Utilitza els següents àlies per a les columnes: nom de "producto", euros, dòlars nord-americans.
SELECT nombre AS nombre_de_producto, precio AS euros, precio*1.1 AS dolares_nord_americanos FROM producto;

--6 Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a majúscula.
SELECT UPPER(nombre) AS nombre, precio FROM producto;

--7 Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a minúscula.
SELECT LOWER(nombre) AS nombre, precio FROM producto;

--8 Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(SUBSTRING(nombre,1, 2)) AS primeros_dos_caracteres_nombre FROM fabricante;

--9 Llista els noms i els preus de tots els productes de la taula "producto", arrodonint el valor del preu.
SELECT nombre, ROUND(precio) AS precio FROM producto;

--10 Llista els noms i els preus de tots els productes de la taula "producto", truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS precio FROM producto;

--11 Llista el codi dels fabricants que tenen productes en la taula "producto".
SELECT codigo FROM fabricante;

--12 Llista el codi dels fabricants que tenen productes en la taula "producto", eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo FROM fabricante;

--13 Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

--14 Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

--15 Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

--16 Retorna una llista amb les 5 primeres files de la taula "fabricante".
SELECT * FROM fabricante LIMIT 5;

--17 Retorna una llista amb 2 files a partir de la quarta fila de la taula "fabricante". La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 3,2;

--18 Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podries usar MIN(preu), necessitaries GROUP BY
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

--19 Llista el nom i el preu del producte més car. (Fes servir solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podries usar MAX(preu), necessitaries GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

--20 Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT producto.nombre
FROM fabricante
JOIN producto ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.codigo = 2;


BASE DE DATOS UNIVERSIDAD:

--1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1 AS primer_apellido, apellido2 AS segundo_apellido, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

--2 Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL; 

--3 Retorna el llistat dels/les alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999; 

--4 Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE %K;

--5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura
WHERE asignatura.cuatrimestre = 1 AND asignatura.curso = 3 AND id_grado = 7;

--6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, p.nombre, d.nombre AS nombre_departamento
FROM persona p 
JOIN profesor prof ON p.id = prof.id_profesor
JOIN departamento d ON d.id = prof.id_departamento
WHERE p.tipo = 'profesor'
ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

--7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre AS asignatura, ce.anyo_inicio, ce.anyo_fin FROM asignatura a
JOIN alumno_se_matricula_asignatura ama ON ama.id_asignatura = a.id
JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id
JOIN persona p ON p.id = ama.id_alumno
WHERE p.tipo = 'alumno' AND p.nif = '26902806M';

--8 Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre FROM departamento d
JOIN profesor prof ON prof.id_departamento = d.id
JOIN asignatura a ON a.id_profesor = prof.id
JOIN grado g ON g.id = a.id_grado
WHERE g.nombre = 'enginyeria Informàtica (Pla 2015)'


--9 Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.apellido1, p.apellido2, p.nombre
FROM persona p
JOIN alumno_se_matricula_asignatura ama ON ama.id_alumno = p.id
JOIN curso_escolar ce ON ce.id = ama.id_curso_escolar
WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;


--Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

--1 Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

SELECT p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, p.nombre, d.nombre AS nombre_departamento
FROM persona p
LEFT JOIN profesor prof ON prof.id_profesor = p.id
LEFT JOIN departamento d ON d.id = prof.id_departamento
ORDER BY d.nombre ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;


-- 2 Retorna un llistat amb els professors/es que no estan associats a un departament.

SELECT p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, p.nombre
FROM persona p
LEFT JOIN profesor prof ON prof.id_profesor = p.id
LEFT JOIN departamento d ON d.id = prof.id_departamento
WHERE d.nombre IS NULL;


--3 Retorna un llistat amb els departaments que no tenen professors/es associats.

SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
WHERE prof.id_profesor IS NULL;


--4 Retorna un llistat amb els professors/es que no imparteixen cap assignatura.

SELECT p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, p.nombre
FROM persona p
LEFT JOIN profesor prof ON prof.id_profesor = p.id
LEFT JOIN asignatura a ON a.id_profesor = prof.id_profesor
WHERE a.id IS NULL;


--5 Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.nombre AS nombre_asignatura
FROM asignatura a
LEFT JOIN profesor prof ON a.id_profesor = prof.id_profesor
WHERE prof.id_profesor IS NULL;


--6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
WHERE prof.id_profesor IS NULL;


--Consultes resum:

--1 Retorna el nombre total d'alumnes que hi ha.

SELECT COUNT(*) AS número_de_alumnos FROM persona
WHERE tipo = 'alumno';


--2 Calcula quants/es alumnes van néixer en 1999.

SELECT COUNT(*) AS número_de_alumnos FROM persona
WHERE tipo = 'alumno'AND YEAR(fecha_nacimiento) = 1999;


--3 Calcula quants/es professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

SELECT d.nombre AS nombre_departamento , COUNT(prof.id_profesor) AS número_profesores
FROM departamento d
JOIN profesor prof ON prof.id_departamento = d.id
GROUP BY d.nombre
ORDER BY COUNT(prof.id_profesor) DESC;


--4 Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Té en compte que poden existir departaments que no tenen professors/es associats/des. Aquests departaments també han d'aparèixer en el llistat.

SELECT d.nombre AS nombre_departamento, COUNT(prof.id_profesor) AS número_profesores
FROM departamento d
LEFT JOIN profesor prof ON prof.id_departamento = d.id
GROUP BY d.nombre
ORDER BY COUNT(prof.id_profesor) ASC;

--5 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Té en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.

SELECT g.nombre AS nombre_grado, COUNT(a.id) AS número_asignaturas
FROM grado g
LEFT JOIN asignatura a ON a.id_grado = g.id
GROUP BY g.nombre
ORDER BY COUNT(a.id) DESC;

--6 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.

SELECT g.nombre AS nombre_grado, COUNT(a.id) AS número_asignaturas
FROM grado g
LEFT JOIN asignatura a ON a.id_grado = g.id
GROUP BY g.nombre
HAVING COUNT(a.id) > 40
ORDER BY COUNT(a.id) ASC;


--XX 7 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
--XXXXXX

--8 Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats/des.

SELECT ce.anyo_inicio AS anyo_inicio, COUNT(ama.id_alumno) AS numero_alumnos_matriculados
FROM curso_escolar ce
JOIN alumno_se_matricula_asignatura ama ON ama.id_curso_escolar = ce.id
GROUP BY ce.anyo_inicio;


--9 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

SELECT p.id AS id_profesor, p.nombre AS nombre_profesor, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, COUNT(a.id) AS número_asignaturas
FROM persona p
JOIN profesor prof ON prof.id_profesor = p.id
JOIN asignatura a ON a.id_profesor = prof.id_profesor
GROUP BY prof.id_profesor;


--10 Retorna totes les dades de l'alumne més jove.

SELECT * FROM persona WHERE tipo ='alumno'
ORDER BY fecha_nacimiento ASC LIMIT 1


--11 Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.

SELECT * FROM persona p
JOIN profesor prof ON prof.id_profesor = p.id
JOIN departamento d ON prof.id_departamento = d.id
LEFT JOIN asignatura a ON a.id_profesor = prof.id_profesor
WHERE a.id IS NULL  


















