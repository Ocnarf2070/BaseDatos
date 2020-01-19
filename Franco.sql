SELECT COUNT( DISTINCT TELEFONO) FROM PROFESORES;
SELECT COUNT(calificacion) "Matriculados" ,
AVG(decode(calificacion,'MH',10,'SB',9,'NT',7,'AP',5,'SP', 0)) "Media"
FROM matricular M, asignaturas A
WHERE M.asignatura = A.codigo
AND upper(A.nombre) = 'BASES DE DATOS' ;

SELECT MIN(APELLIDO1) "APELLIDO MÍNIMO",DEPARTAMENTO FROM PROFESORES
GROUP BY DEPARTAMENTO;

SELECT trunc(months_between(sysdate,fecha_nacimiento)/12/10) "Decenio",
MIN(fecha_nacimiento) "Fecha"
FROM profesores
GROUP BY trunc(months_between(sysdate,fecha_nacimiento)/12/10)
ORDER BY trunc(months_between(sysdate,fecha_nacimiento)/12/10);
SELECT trunc(months_between(sysdate,fecha_nacimiento)/12/10) "Decenio",
MIN(fecha_nacimiento) "Fecha"
FROM profesores
GROUP BY trunc(months_between(sysdate,fecha_nacimiento)/12/10)
HAVING trunc(months_between(sysdate,fecha_nacimiento)/12/10) IS NOT NULL
ORDER BY "Decenio";

SELECT COUNT(*),DEPARTAMENTO FROM PROFESORES
GROUP BY DEPARTAMENTO
HAVING COUNT(*)>2;

SELECT A.NOMBRE, COUNT (DISTINCT ALUMNO) FROM MATRICULAR M JOIN ASIGNATURAS A ON A.CODIGO=M.ASIGNATURA  
GROUP BY ASIGNATURA,A.NOMBRE
HAVING COUNT(DISTINCT ALUMNO)>10;

SELECT GENERO,ROUND(AVG(decode(calificacion,'MH',10,'SB',9,'NT',8,'AP',5,'SP', 0)),2) "CALIFICACION MEDIA" FROM ALUMNOS JOIN MATRICULAR ON DNI=ALUMNO
WHERE CURSO='15/16'
GROUP BY GENERO;
SELECT NOMBRE,ROUND(AVG(decode(calificacion,'MH',10,'SB',9,'NT',8,'AP',5,'SP', 0)),2) "CALIFICACION MEDIA" FROM MATRICULAR JOIN ASIGNATURAS ON ASIGNATURA=CODIGO
GROUP BY ASIGNATURA,NOMBRE
HAVING AVG(decode(calificacion,'MH',10,'SB',9,'NT',8,'AP',5,'SP', 0))>4;

SELECT ID/*NOMBRE||' '||APELLIDO1||' '||APELLIDO2 "PROFESOR"*/, SUM(CARGA_CREDITOS), DEPARTAMENTO FROM IMPARTIR JOIN PROFESORES ON PROFESOR=ID
GROUP BY PROFESOR,DEPARTAMENTO,ID
ORDER BY DEPARTAMENTO DESC;

SELECT * FROM
(SELECT *
FROM ASIGNATURAS
WHERE CREDITOS IS NOT NULL
ORDER BY CREDITOS DESC)
WHERE ROWNUM<=3;
SELECT asig.*, numero
FROM asignaturas asig JOIN
(SELECT COUNT (DISTINCT alumno) as numero, asignatura
FROM matricular
GROUP BY asignatura)
ON (asig.codigo = asignatura)
WHERE numero >=25