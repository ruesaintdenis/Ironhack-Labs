USE employees;

SELECT first_name, last_name
From employees; 

select * from departments; 

select dept_no from departments; 

select * from employees where first_name = 'elvis'; 

select * from employees where (first_name = "kellie" or first_name = 'Aruna') and gender = 'F';

select * from employees where first_name NOT IN ('John', 'Mark', 'Jacob'); 

select * from employees where first_name LIKE ('Mark%'); 
select * from employees where first_name Not LIKE ('%Jack%'); 
select * from employees where hire_date LIKE ('2000-%%-%%'); 
select * from employees where hire_date LIKE ('%2000%'); 
select * from employees where emp_no LIKE ('1000_'); 
select * from salaries where salary between 66000 and 70000; 
select * from employees where emp_no not between 10004 and 10012; 
select * from departments where dept_no between 'd003' and 'd006';

select * from employees where gender = 'F' AND hire_date > ('2000-01-01'); 
select * from salaries where salary > 150000; 

Select count(*) from salaries where salary >= 100000; 
select count(*) from dept_manager; 

select * from employees order by hire_date desc; 

select salary, count(emp_no) as emps_with_same_salary from salaries where salary > 80000 group by salary order by salary; 

select *, avg(salary) from salaries group by emp_no having avg(salary) > 120000; 

select *, count(first_name) from employees where hire_date > '1999-01-01' group by first_name having count(first_name)<200;  

select emp_no from dept_emp where from_date > '2000-01-01' group by emp_no having count(from_date) > 1; 

select * from titles order by emp_no desc limit 10; 

insert into titles 
(emp_no, 
title, 
from_date
)
Values (
999903,
'Senior Engineer',
'1997-10-01'
); 

insert into employees 
values(
999903,
'1973-01-21',
'John',
'Smith',
'M',
'1990-06-01'
);

select count(distinct dept_no) from dept_emp; 

select round(avg(salary), 2) from salaries where from_date > '1997-01-01'; 

CREATE TABLE departments_dup 
( 
    dept_no CHAR(4) NULL, 
    dept_name VARCHAR(40) NULL 
); 
  
INSERT INTO departments_dup 
( 
    dept_no, 
    dept_name 
)
SELECT * 
FROM 
                departments; 
  
INSERT INTO departments_dup (dept_name) 
VALUES                ('Public Relations'); 
  
DELETE FROM departments_dup 
WHERE 
    dept_no = 'd002';  
    
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );
 
INSERT INTO dept_manager_dup
select * from dept_manager;
 
INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),
                                (999905, '2017-01-01'),
                               (999906, '2017-01-01'),
                               (999907, '2017-01-01');
 
DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
INSERT INTO departments_dup (dept_name)
VALUES                ('Public Relations');
 
DELETE FROM departments_dup
WHERE
    dept_no = 'd002';

select min(emp_no), max(emp_no) from employees; 

select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
inner join departments_dup d on m.dept_no = d.dept_no
order by m.dept_no; 

select e.first_name, e.last_name, e.hire_date, m.emp_no, m.dept_no
from employees e 
left join dept_manager m on e.emp_no = m.emp_no
where e.last_name = 'Markovitch'
order by m.dept_no desc, e.emp_no;  

select m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
from employees e, dept_manager m 
where e.emp_no = m.emp_no; 

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

select e.first_name, e.last_name, e.hire_date, e.emp_no, t.title
from employees e
join titles t on e.emp_no = t.emp_no
where e.first_name = 'Margareta' and e.last_name = 'Markovitch'; 

select m.*, d.*
from departments d
cross join
dept_manager m 
where d.dept_no = 'd009'; 

select e.*, d.*
from departments d
cross join
employees e 
where e.emp_no < 10011;

select e.first_name, e.last_name, e.hire_date, t.title, dm.from_date, d.dept_name
from employees e
join 
titles t on e.emp_no = t.emp_no
join
dept_manager dm on t.emp_no = dm.emp_no
join 
departments d on d.dept_no = dm.dept_no;

select e.gender, count(gender)
from employees e
join dept_manager dm on e.emp_no = dm.emp_no
group by e.gender; 

select * from dept_manager 
where emp_no IN (select emp_no from employees where hire_date between '1990-10-01' and '1995-01-01'); 

select * from employees e where exists( select * from titles t where t.emp_no = e.emp_no AND title = 'Assistant Engineer');

DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  manager int(11) NOT NULL);
 
 
 
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
  
  create or replace view v_avg_manager_salary as
  select round(avg(s.salary),2)
  from salaries s
  join dept_manager dm on dm.emp_no = s.emp_no; 

  
drop procedure if exists select_employees;

delimiter $$
  create procedure select_employees()
  begin 
  select * from employees.employees
  limit 1000;
  end$$
  
  delimiter ; 
  
  call employees.select_employees();
  
  drop procedure if exists avg_salary;

delimiter $$
  create procedure avg_salary()
  begin 
  select e.emp_no, avg(s.salary), e.first_name, e.last_name
  from employees e 
  join salaries s on e.emp_no = s.emp_no
  group by emp_no; 
  end$$
  
  delimiter ; 
  
  call employees.avg_salary();
 delimiter $$ 
create procedure emp_avg_salary(in p_emp_no int)
  begin 
  select e.emp_no, avg(s.salary), e.first_name, e.last_name
  from employees e 
  join salaries s on e.emp_no = s.emp_no
  where 
  e.emp_no = p_emp_no;
  end$$
  
  delimiter ; 
  
  call emp_avg_salary(11000);
  
  select e.emp_no, e.first_name, e.last_name, 
  case 
  when e.emp_no = dm.emp_no then 'Manager'
  Else 'Employee'
  end as status
  from employees e
  left join dept_manager dm on  dm.emp_no = e.emp_no
  where e.emp_no> 109990; 
  
  select e.emp_no, e.first_name, e.last_name, max(de.to_date),
  case 
  when max(de.to_date) > '2020-04-18' then 'Still employeed'
  else 'not currently employeed'
  end as status
  from employees e
  join dept_emp de on e.emp_no = de.emp_no
 group by e.emp_no
 order by e.emp_no 
 limit 100;