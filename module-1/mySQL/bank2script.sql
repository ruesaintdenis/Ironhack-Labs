SELECT district_id, count(client_id)
from bank.client 
where district_id < 10
group by(district_id);
select card.type as Type2, count(card_id)
from bank.card
group by(Type2)
order by count(card_id) desc; 
select account_id, sum(amount)
from bank.loan
group by account_id
order by sum(amount) desc;
select loan.date, count(loan.date)
from bank.loan
where loan.date < 930907
group by loan.date 
order by loan.date desc;


select loan.date, count(loan.date), duration
from bank.loan
where loan.date between 971200 and 971232
group by loan.date, duration
order by loan.date asc, duration asc; 