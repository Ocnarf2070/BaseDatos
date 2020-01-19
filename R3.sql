select nombre from DOCENCIA.impartir join profesores on  (profesor=id)
where asignatura <> 112;

select nombre from profesores where id not in(
select profesor from DOCENCIA.impartir where asignatura = 112);

select nombre from profesores where not exists(
select profesor from DOCENCIA.impartir where profesor=profesores.id and asignatura = 112);


--relacion 3
--1.
select nombre from asignaturas where codigo in(
select DISTINCT asignatura from impartir 
where asignatura != 112 and profesor in (select profesor from impartir where asignatura = 112));

--2.
select distinct dep.nombre from departamentos dep where codigo not in(select departamento from asignaturas where creditos>6);
select distinct dep.nombre from departamentos dep where not exists(select * from asignaturas where creditos>6 and dep.codigo=departamento);
--3
select alumno from matricular where asignatura in( 
select asignatura from impartir
where profesor in(
select id from profesores 
where antiguedad >= ALL(select antiguedad from profesores)))