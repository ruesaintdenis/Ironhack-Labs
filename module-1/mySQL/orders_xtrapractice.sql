Create database Orders;

use Orders;

CREATE TABLE orders (
po_n int primary key, 
po_d VARCHAR(20), 
supplier_n int,
po_payterms VARCHAR(10) NOT NULL default 'NET30' 
);

insert into orders 
values 
(610557, '2/27/2013', 1335, 'NET30'),
(610558, '2/27/2013', 2652, '2/10NET20'),
(610559, '2/27/2013', 1335, 'COD'),
(610560, '2/28/2013', 1226, '2/10NET20'),
(610561, '3/01/2013', 2652,'2/10NET20'); 

CREATE TABLE order_items (
po_n int references orders(po_n), 
item_n int, 
item_q int,
item_price decimal (7,2)
);

insert into order_items 
values 
(610557, 36796, 15, 664.25),
(610557, 36224, 21, 224.54),
(610559, 36624, 100, 0.65),
(610560, 36547, 1, 10887.10),
(610561, 36869, 224, 336.65); 

CREATE TABLE suppliers (
supplier_n int primary key NOT NULL, 
supplier_m varchar(255), 
supplier_tier int CHECK(supplier_tier < 6),
default_payterms varchar(10) NOT NULL default 'NET30' 
);

insert into suppliers (supplier_n, supplier_m, supplier_tier)
values 
(1335, 'MacLarens Irish Pub', 4),
(2652, 'Central Park', 3),
(1226, 'Beltway Coffee', Null); 

select * from suppliers; 

select supplier_m, orders.po_n, item_n, item_q
from suppliers
join orders
on orders.supplier_n = suppliers.supplier_n 
left join order_items
on orders.po_n = order_items.po_n;

update suppliers
set supplier_tier = 3, default_payterms = '2/10NET20'
where supplier_n = 1226;

alter table orders 
add pay_status VARCHAR(3) default 'NYP'; 

select * from orders;
