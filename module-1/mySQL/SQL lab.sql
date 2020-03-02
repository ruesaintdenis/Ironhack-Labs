Create database Project;

use Project; 

CREATE TABLE faculty (
fac_N int primary key, 
fac_First_M VARCHAR(20), 
fac_Last_M VARCHAR(20),
fac_Rank_C VARCHAR(7) 
);

insert into faculty 
values 
(13443, 'Iris', 'Martinez', 'ASCP'),
(66234, 'Aura', 'Matias', 'PROF'),
(45463, 'Lorelie', 'Grepo', 'ASTP'),
(44556, 'Mickey','Mancenido','ASTP'); 

Create table courses (
course_C varchar(20) primary key, 
course_M varchar(50), 
course_units int
);

insert into courses
values
('IDOE', 'Design of Experients', 3),
('IBDM', 'Business Intelligence and Data Mining', 3),
('MSCM', 'Supply Chain Management', 3),
('SRES', 'Research Methods', 1),
('SSIM', 'Simulation', 4);

create table faculty_courses (
Course_C varchar(20) references courses(course_C),
Fac_N int references faculty(fac_N), 
Student_Count int, 
Sem_C varchar(20)
);

insert into faculty_courses
values
('MSCM', 13443, 34, '2012-1'),
('MSCM', 66234, 32, '2012-2'),
('IDOE', 44556, 56, '2012-1'),
('SRES', 13443, 12, '2012-1'),
('IBDM', 66234, 40, '2012-2'),
('MSCM', 44556, 32, '2013-1');
 
 SELECT * FROM faculty; 
 select * from courses; 
 select * from faculty_courses; 
 
 select Student_Count from faculty_courses where Course_C = 'MSCM'; 
 
 select faculty.fac_N, fac_Last_M, sum(Student_Count)
 from faculty_courses, faculty
 where faculty_courses.Fac_N = faculty.fac_N 
 group by fac_Last_M
 order by fac_Last_M; 
 
 select course_M, course_units, Sem_C, fac_Last_M, fac_Rank_C
 from courses
 inner join faculty_courses
 on courses.course_C = faculty_courses.Course_C
 inner join faculty
 on faculty.fac_N = faculty_courses.Fac_N; 
 
 Create table rank_description (
fac_rank_C varchar(4) NOT NULL DEFAULT 'inst' primary key, 
fac_rank_M varchar(50), 
min_sal_grade int CHECK(min_sal_grade < 10)
);

insert into rank_description
values
('INST','Instructor',1), 
('ASTP','Assistant Professor',3),
('ASCP','Associate Professor',5),
('PROF','Professor',7),
('UPRF','University Professor',9);

