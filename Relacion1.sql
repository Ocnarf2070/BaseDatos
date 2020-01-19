--EJERCICIO 1
SELECT NOMBRE,APELLIDO1,APELLIDO2 FROM DOCENCIA.PROFESORES
WHERE  DEPARTAMENTO='1';

--EJERCICIO 2
SELECT NOMBRE,APELLIDO1,APELLIDO2 FROM DOCENCIA.PROFESORES
WHERE  DEPARTAMENTO<>'3';

--EJERCICIO 3
SELECT NOMBRE,APELLIDO1,APELLIDO2 FROM DOCENCIA.PROFESORES
WHERE  EMAIL LIKE '%lcc.uma.es';

--EJERCICIO 4
SELECT NOMBRE FROM DOCENCIA.ALUMNOS
WHERE EMAIL IS NULL;

--EJERCICIO 5
SELECT NOMBRE, CREDITOS, ((TEORICOS/(CREDITOS))*100) "TEORICO (%)",((PRACTICOS/(CREDITOS))*100) "PRACTICO (%)" FROM DOCENCIA.ASIGNATURAS
WHERE CURSO='3';

--EJERCICIO 6
SELECT ALUMNO,CALIFICACION FROM DOCENCIA.MATRICULAR
WHERE ASIGNATURA='112'
ORDER BY ALUMNO;

--EJERCICIO 7
SELECT NOMBRE, (HOMBRES+MUJERES) "POBLACION" FROM MUNICIPIO;

--EJERCICIO 8
SELECT 'El alumno '||NOMBRE||' no dispone de Correo' "CORREO" FROM DOCENCIA.ALUMNOS
WHERE EMAIL IS NULL AND GENERO='MASC'

UNION

SELECT 'La alumna '||NOMBRE||' no dispone de Correo' "CORREO" FROM DOCENCIA.ALUMNOS
WHERE EMAIL IS NULL AND GENERO='FEM';

--EJERCICIO 9
SELECT NOMBRE,APELLIDO1,APELLIDO2 FROM DOCENCIA.PROFESORES
WHERE  ANTIGUEDAD<(TO_DATE('01/01/1990','DD/MM/YYYY'));

--EJERCICIO 10
SELECT NOMBRE,APELLIDO1,APELLIDO2 FROM DOCENCIA.PROFESORES
WHERE (MONTHS_BETWEEN(SYSDATE,FECHA_NACIMIENTO)/12)<30;

--EJERCICIO 11
SELECT UPPER(NOMBRE) "NOMBRE",UPPER(APELLIDO1)"APELLIDO1",UPPER("APELLIDO2")"APELLIDO2",TRUNC((MONTHS_BETWEEN(SYSDATE,FECHA_NACIMIENTO)/12)/3) "TRIENIO" FROM DOCENCIA.PROFESORES
WHERE TRUNC((MONTHS_BETWEEN(SYSDATE,ANTIGUEDAD)/12)/3)>3;
--EJERCICIO 12
SELECT REPLACE (NOMBRE, 'Bases de Datos','Almacenes de Datos')"NOMBRE" FROM DOCENCIA.ASIGNATURAS
WHERE UPPER(NOMBRE) LIKE '%BASES DE DATOS%';

--EJERCICIO 13
SELECT NOMBRE ,REPLACE(NVL(CREDITOS,'0'),'0','NO ASIGNADO') "CREDITOS" FROM DOCENCIA.ASIGNATURAS
WHERE CARACTER LIKE 'O%';

--EJERCICIO 14
SELECT * FROM ALUMNOS WHERE (MONTHS_BETWEEN(SYSDATE,FECHA_PRIM_MATRICULA))<2;

--EJERCICIO 15
SELECT * FROM ALUMNOS WHERE TRUNC((MONTHS_BETWEEN(FECHA_PRIM_MATRICULA,FECHA_NACIMIENTO))/12)<18;

--EJERCICIO 16
SELECT * FROM ALUMNOS WHERE (TO_CHAR(FECHA_PRIM_MATRICULA,'DAY'))  LIKE '%LUNES%';
SELECT * FROM SOL_1_16;