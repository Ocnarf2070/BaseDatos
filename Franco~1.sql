--ej1

select initcap(nombre) "NOMBRE",initcap(apellido1) "APELLIDO1" ,initcap(apellido2) "APELLIDO2", email  from alumnos
where trunc(months_between(sysdate,fecha_nacimiento)/12)<27 and email is not null;

--ej2

select  nombre, apellido1,apellido2,next_day(to_date(to_char(antiguedad,'dd/mm/')||to_char(sysdate,'yy')),'Viernes')  from profesores 
where trunc(months_between(sysdate,antiguedad)/12)>20

;--ej3

select nombre, apellido1,apellido2, avg(decode(calificacion,'AP',1,'NT',2,'SB',3,'MH',4,0)) from alumnos join matricular on dni=alumno
where calificacion in ('AP','NT','SB','MH') 
and dni in
(select alumno 
from matricular where calificacion in ('AP','NT','SB','MH') 
) group by nombre, apellido1, apellido2 
order by avg(decode(calificacion,'AP',1,'NT',2,'SB',3,'MH',4,0)) desc
;
select * from (select NOMBRE, APELLIDO1, APELLIDO2, ROUND (avg (decode (calificacion, 'AP',1,'NT',2,'SB',3,'MH',4)),2) NOTA
from matricular JOIN ALUMNOS ON ALUMNO=DNI WHERE CALIFICACION IN ('AP','NT','SB','MH') 
group by NOMBRE, APELLIDO1, APELLIDO2 having count (*) >1 order by 4 desc ) where rownum <=3

;--ej4

select al.nombre,al.apellido1,al.apellido2,pr.nombre,pr.apellido1,pr.apellido2 
from alumnos al join matricular m on dni=alumno join asignaturas on m.asignatura=codigo 
join impartir i on (i.asignatura=codigo and i.curso=m.curso and i.grupo = m.grupo) 
join profesores pr on profesor=id
where substr(al.nombre,0,1)=substr(pr.nombre,0,1) and substr(al.apellido1,0,1)=substr(pr.apellido1,0,1)
;
select distinct p.nombre,p.apellido1,a.nombre, a.apellido1 

from alumnos a join matricular m on alumno=dni,

impartir i join profesores p on profesor=id

where i.asignatura =m.asignatura and i.curso=m.curso and i.grupo = m.grupo

and substr(p.apellido1,1,1) = substr (a.apellido1,1,1) and 

substr(p.nombre,1,1) = substr (a.nombre,1,1)
;--ej5

select distinct asi1.codigo, asi1.nombre, asi2.codigo, asi2.nombre from asignaturas asi1,
asignaturas asi2
where asi1.codigo<asi2.codigo and (asi1.codigo,asi2.codigo) in
(select m1.asignatura, m2.asignatura from matricular m1, matricular m2 
group by m1.asignatura, m2.asignatura
having count(m1.alumno)=count(m2.alumno) and count(m1.alumno)!=0 and count(m2.alumno)!=0);

select a1.codigo,a1.nombre, a2.codigo,a2.nombre from asignaturas a1, asignaturas a2 where

a1. codigo < a2.codigo and 

(select count (distinct alumno) from matricular m1 where asignatura = a1.codigo) = 

(select count (distinct alumno) from matricular m2 where asignatura = a2.codigo) and 

(select count (distinct alumno) from matricular m1 where asignatura = a1.codigo) <> 0

and  (select count (distinct alumno) from matricular m1 where asignatura = a2.codigo) <> 0

;--ej6
select pr.nombre,apellido1,apellido2 from profesores pr join impartir i on profesor=id join asignaturas on codigo=i.asignatura join matricular m on (m.asignatura=codigo and m.curso=i.curso and m.grupo=i.grupo)
where alumno not in
(select dni from alumnos where to_char(fecha_nacimiento,'yyyy') between 1990 and 1999)
and trunc(months_between(sysdate,fecha_nacimiento)/12) in (select max(trunc(months_between(sysdate,fecha_nacimiento)/12))from profesores group by departamento);

select d.nombre, p.nombre, p.apellido1, p.apellido2

from profesores p join departamentos d on departamento = codigo

where (departamento, fecha_nacimiento) in (

select departamento, min(fecha_nacimiento) from profesores 

where id not in

(select profesor from impartir natural join matricular join alumnos on alumno = dni 

 where to_char(fecha_nacimiento,'yyyy') between '1990' and '1999')

group by departamento);

