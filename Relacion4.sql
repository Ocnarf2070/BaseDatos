select p1.profesor, p2.profesor from impartir p1, impartir p2
where p1.asignatura = p2.asignatura and p1.profesor<p2.profesor 
group by p1.profesor,p2.profesor, p1.asignatura,p2.asignatura;

select count(p1.asignatura),p1.profesor,count(p2.asignatura), p2.profesor from impartir p1 join impartir p2 on p1.asignatura = p2.asignatura
where p1.profesor<p2.profesor
group by p1.profesor, p2.profesor
;
SELECT p1.Id
FROM profesores p1 JOIN impartir ip1 ON p1.id=ip1.profesor
WHERE ip1.asignatura IN(
	SELECT i1.asignatura
	FROM (profesores pro1 JOIN impartir i1 ON pro1.id=i1.profesor) JOIN (profesores pro2 JOIN impartir i2 ON pro2.id=i2.profesor) ON i1.asignatura=i2.asignatura
	WHERE pro1.id<>pro2.id
AND pro1.id=p1.id);

-------------------------------------------------------

select 

;-------------------------------------------------------
select distinct count( m1.alumno), count(m2.alumno) from matricular m1, matricular m2
where  m1.alumno<m2.alumno and (m1.alumno, m2.alumno) not in(
select distinct m1.alumno, m2.alumno from matricular m1, matricular m2
where (m1.asignatura = m2.asignatura and m1.curso = m2.curso and m1.grupo = m2.grupo))

;-------------------------------------------------------

select 

;------------------------------------------------------

select 

;--------------------------------------------------------

select p.id, sum(((0.5*practicos + teoricos)*count(alumno))*(carga_creditos/creditos)) 
from profesores p left outer join impartir i on p.id=i.profesor
left outer join asignaturas asi on i.asignatura=asi.codigo
left outer join matricular m on asi.codigo = m.asignatura
;

select i.profesor, sum(((0.5*practicos + teoricos)*(select count(alumno)
from matricular m2 join asignaturas on codigo=m2.asignatura join impartir i2 on i2.asignatura=codigo
where i2.profesor = i.profesor and m2.asignatura = m.asignatura))*(i.carga_creditos/creditos)) "CNTP"
from impartir i join asignaturas on i.asignatura = codigo join matricular m on codigo=m.asignatura 

group by i.profesor;

select profesor, asignatura,grupo,curso, count(alumno)
from matricular natural join impartir
where profesor='A-89-CEU-99' and asignatura='112'
group by profesor, asignatura,grupo,curso;
select * from impartir where profesor = 'A-89-CEU-99';

-------------------------------------

select pr.nombre, mu.nombre, count(dni)
from alumnos al right outer join municipio mu on (al.cpro=mu.cpro and al.cmun=mu.cmun)
right outer join provincia pr on codigo=mu.cpro
group by pr.nombre, mu.nombre
order by count(dni) desc;

------------------------------------

select al.nombre, apellido1, apellido2, asi.nombre from alumnos al join provincia pro on cpro=pro.codigo 
join matricular m on dni=alumno join asignaturas asi on asignatura=asi.codigo join departamentos d on d.codigo=asi.departamento
where pro.nombre = 'Córdoba' and d.nombre='Lenguajes y Ciencias de la Computacion';

------------------------------------
select pr.nombre, count (distinct alumno) "MUJERES"
from alumnos al join provincia pr on codigo=cpro join matricular m on alumno=dni
where genero = 'FEM'
group by pr.nombre
having count(distinct alumno)=(select max(count (distinct alumno)) from alumnos join matricular m on alumno=dni where genero = 'FEM' group by cpro);

select * from sol_4_8
