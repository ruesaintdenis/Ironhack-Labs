use publications;

select Author_ID, First_Name, Last_Name, floor(sum(SumRoyalty + SumAd)) as profit
from (
Select Author_ID, Title_ID, First_Name, Last_Name, Title, sum(sales_royalty) as SumRoyalty, sum(advance) as SumAd
from (
select A.au_id as Author_ID, T.title_id as Title_ID, A.au_fname as First_Name, A.au_lname as Last_Name, T.title as Title,
(T.advance * TA.royaltyper / 100) as advance, 
T.price * sales.qty * T.royalty / 100 * TA.royaltyper / 100 as sales_royalty
from publications.authors as A
inner join publications.titleauthor as TA
on A.au_id = TA.au_id
inner join publications.titles as T
on TA.title_id = T.title_id
inner join publications.Sales
on sales.title_id = T.title_id
order by Title_ID, Author_ID
) summary
group by Author_ID, Title_ID 
) royalty
group by Author_ID
order by profit desc
limit 3; 

CREATE TEMPORARY TABLE publications.summary
select A.au_id as Author_ID, T.title_id as Title_ID, A.au_fname as First_Name, A.au_lname as Last_Name, T.title as Title,
(T.advance * TA.royaltyper / 100) as advance, 
T.price * sales.qty * T.royalty / 100 * TA.royaltyper / 100 as sales_royalty
from publications.authors as A
inner join publications.titleauthor as TA
on A.au_id = TA.au_id
inner join publications.titles as T
on TA.title_id = T.title_id
inner join publications.Sales
on sales.title_id = T.title_id
order by Title_ID, Author_ID;

CREATE TEMPORARY TABLE publications.royalty
select Author_ID, Title_ID, First_Name, Last_Name, Title, sum(sales_royalty) as SumRoyalty, sum(advance) as SumAd
from publications.summary
group by Author_ID, Title_ID;

select Author_ID, First_Name, Last_Name, floor(sum(SumRoyalty + SumAd)) as profit
from publications.royalty
group by Author_ID
order by profit desc
limit 3; 
