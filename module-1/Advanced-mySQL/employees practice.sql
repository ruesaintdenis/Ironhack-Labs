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
