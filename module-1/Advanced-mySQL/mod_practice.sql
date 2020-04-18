use employees_mod; 

select count(e.emp_no), e.gender, year(d.from_date)
from t_employees e
join
t_dept_emp d on e.emp_no = d.emp_no
where year(from_date) >=1990
group by e.gender, year(d.from_date)
order by year(d.from_date);

select e.gender, d.dept_name, count(e.emp_no), year(dm.from_date)
from t_employees e
join t_dept_manager dm on dm.emp_no = e.emp_no
join t_departments d on d.dept_no = dm.dept_no
where year(dm.from_date) >1989
group by e.gender, d.dept_name, year(dm.from_date)
order by year(dm.from_date);

select e.gender, d.dept_name, avg(s.salary), year(de.from_date)
from t_employees e
join t_dept_emp de on de.emp_no = e.emp_no
join t_departments d on d.dept_no = de.dept_no
join t_salaries s on e.emp_no = s.emp_no
where year(de.from_date) <2002
group by e.gender, d.dept_name, year(de.from_date)
order by year(de.from_date);
