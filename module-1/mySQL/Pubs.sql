Create temporary table JointAuthorss
SELECT au_lname, au_fname, title_id, A.au_id
from publications.authors as A
inner join publications.titleauthor as TA
on A.au_id = TA.au_id; 

Create temporary table Pub 
SELECT title, pub_name, title_id
from publications.titles as T
inner join publications.publishers as P
on T.pub_id = P.pub_id; 

select au_lname, au_fname, title, pub_name, JA.au_id
from publications.JointAuthorss as JA
inner join publications.Pub as Pubss
on JA.title_id = Pubss.title_id;

select au_lname, au_fname, count(title), pub_name, JA.au_id
from publications.JointAuthorss as JA
inner join publications.Pub as Pubss
on JA.title_id = Pubss.title_id
group by JA.au_id;

select au_lname, au_fname, count(title), JA.au_id
from publications.JointAuthorss as JA
left join publications.titles as Title
on JA.title_id = Title.title_id
group by JA.au_id
order by count(title) desc
limit 3;


select au_lname, au_fname, count(title), JA.au_id
from publications.titles as Title 
full join publications.JointAuthorss as JA
on JA.title_id = Title.title_id
group by JA.au_id
order by count(title) desc;



