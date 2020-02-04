SELECT * FROM bank.client;
select * from bank.client order by district_id asc, client_id asc; 
select * from bank.client order by district_id desc, client_id asc; 
select * from bank.loan order by amount asc; 
select * from bank.loan order by payments desc; 
select account_id, amount from bank.loan order by account_id asc; 
select duration, amount, account_id from bank.loan where duration = 60 order by amount asc; 
select distinct k_symbol from bank.order; 
select order_id, account_id from bank.order where account_id =34; 
select order_id, account_id from bank.order where order_id between 29540 and 29560;
select amount, account_to from bank.order where account_to = 30067122;
select trans.trans_id, trans.date as DATE1, trans.type as TYPE1, trans.amount, account_id
 from bank.trans 
 where account_id = 793 
 order by trans_id desc, account_id desc;  