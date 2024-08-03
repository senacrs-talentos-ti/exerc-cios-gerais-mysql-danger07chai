CREATE DATABASE FERRAGEM;
USE FERRAGEM;

CREATE TABLE CLIENTS(
ID INT(4) PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(50) NOT NULL,
EMAIL VARCHAR(50) NOT NULL
);
USE FERRAGEM;

CREATE TABLE PRODUCTS(
ID INT(4) PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(50) NOT NULL,
PRICE DECIMAL(5,2)
);
USE FERRAGEM;

CREATE TABLE ORDERS(
ID INT(4) PRIMARY KEY AUTO_INCREMENT,
CLIENT_ID INT, 
ORDER_DATE DATE NOT NULL,
TOTAL DECIMAL (5,2) NOT NULL,
FOREIGN KEY(CLIENT_ID) REFERENCES CLIENTS(ID)
);
USE FERRAGEM;

CREATE  TABLE ORDER_ITEMS(
ORDER_ID INT, 
PRODUCT_ID INT,
QUANTITY INT(4) NOT NULL,
PRICE DECIMAL (5,2) NOT NULL,
primary key(order_id,product_id),
FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ID),
FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS(ID)
);
USE FERRAGEM;

INSERT INTO CLIENTS (ID,NAME,EMAIL) VALUES
(DEFAULT, 'ANDRE B.','ANG@GMAIL.COM'),
(DEFAULT, 'BETANI C.','BET@GMAIL.COM'),
(DEFAULT, 'CAMILA D.','CAM@GMAIL.COM'),
(DEFAULT, 'DONAUDI E.','DON@GMAIL.COM'),
(DEFAULT, 'EDINA F.','EDI@GMAIL.COM'),
(DEFAULT, 'FABIO G.','FAB@GMAIL.COM'),
(DEFAULT, 'GABI H.','GAB@GMAIL.COM'),
(DEFAULT, 'HIMINI I.','HIM@GMAIL.COM'),
(DEFAULT, 'IGOR J.','IGO@GMAIL.COM'),
(DEFAULT, 'JAMILI L.','JAM@GMAIL.COM');
USE FERRAGEM;

INSERT INTO PRODUCTS (ID,NAME,PRICE) VALUES
(DEFAULT, 'MARTELOS',30.90),
(DEFAULT, 'ALICATES',25.50),
(DEFAULT, 'SERROTES',55.00),
(DEFAULT, 'BROCAS',15.90),
(DEFAULT, 'INCETICIDA',20.10),
(DEFAULT, 'CADEADOS',18.99),
(DEFAULT, 'FECHADURAS',66.25),
(DEFAULT, 'TESOURAS',10.00),
(DEFAULT, 'POLIAS',45.30),
(DEFAULT, 'PLACAS',190.99);
USE FERRAGEM;

INSERT INTO ORDERS (ID,CLIENT_ID,ORDER_DATE,TOTAL) VALUES
(DEFAULT,1, '2024-07-30',100.50),
(DEFAULT,2, '2024-05-31',250.00),
(DEFAULT,4, '2024-07-30',59.50),
(DEFAULT,6, '2024-04-28',180.10),
(DEFAULT,8, '2024-06-30',340.99),
(DEFAULT,1, '2024-06-30',150.50),
(DEFAULT,9, '2024-07-30',60.10),
(DEFAULT,2, '2024-05-30',100.50);
USE FERRAGEM;
INSERT INTO ORDER_ITEMS (ORDER_ID,PRODUCT_ID ,QUANTITY ,PRICE) VALUES
(1,1, 50,30.90),
(2, 2,30,25.50),
(3,3, 100,55.00),
(4,4,65,15.90),
(5,5, 85,20.10),
(6,6, 80,18.99);
USE FERRAGEM;

UPDATE products SET PRICE = 36.99 where ID =2;
UPDATE ORDER_ITEMS SET PRICE =36.99 where PRODUCT_ID = 2;
USE FERRAGEM;


ALTER TABLE clients ADD COLUMN Birthdate DATE;
USE FERRAGEM;

select clients.name as clients ,orders.ID as orders_id,order_items.PRODUCT_ID,PRODUCTS.NAME AS PRODUCTS
from clients
INNER join  orders oN CLIENTS.ID=orders.CLIENT_ID
inner JOIN ORDER_ITEMS ON ORDERS.ID=ORDER_ITEMS.order_id
inner join products on order_items.PRODUCT_ID=products.id;
use ferragem;

select clients.name as clients ,orders.ID as orders_id,order_items.PRODUCT_ID,PRODUCTS.NAME AS PRODUCTS
from clients
left join  orders oN CLIENTS.ID=orders.CLIENT_ID
left JOIN ORDER_ITEMS ON ORDERS.ID=ORDER_ITEMS.order_id
left join products on order_items.PRODUCT_ID=products.id;

select orders.ID as orders_id,order_items.PRODUCT_ID,PRODUCTS.NAME AS PRODUCTS
from orders 
left JOIN ORDER_ITEMS ON ORDERS.ID=ORDER_ITEMS.order_id
left join products on order_items.PRODUCT_ID=products.id;

select total, sum(total) as totalVendas, sum(quantity) as totalDeItemsVendidos
from orders, order_items
group by total,quantity;
use ferragem;

SELECT clients.name as clients, clients.id, COUNT(total) as total_Pedidos
FROM clients
left join orders on clients.id = orders.client_id
group by clients.id, orders.client_id
order by total_Pedidos desc;

SELECT products.name as products, products.id, COUNT(quantity) as quantity
FROM products
right join order_items on products.id=order_items.product_id
group by products.id, order_items.quantity
order by quantity desc;

SELECT clients.name as client, clients.id, COUNT(total) as total_Pedidos
FROM clients
left join orders on clients.id = orders.client_id
group by clients.id, orders.total
order by total desc;
use ferragem;

SELECT products.name as products, products.id, COUNT(quantity) as quantity
FROM products
right join order_items on products.id=order_items.product_id
group by products.id, order_items.quantity
order by quantity asc
limit 3;
use ferragem;

SELECT clients.name as client, clients.id, sum(total) as total_Pedidos
FROM clients
left join orders on clients.id = orders.client_id
group by clients.id, orders.total
order by total desc
limit 3;
use ferragem;

SELECT clients.name as cliente, clients.id, avg(quantity) as media_produtos, order_items.ORDER_ID, products.id as products_id,products.name as products
FROM clients
inner join orders on clients.id = orders.client_id
inner join order_items on orders.id = order_items.order_id
inner join products on order_items.product_id = products.id
group by clients.id, orders.id,order_items.order_id,products.id
order by media_produtos asc;
use ferragem;

select products.id, products.name as products,products.price, order_items.PRODUCT_ID
from products
left join order_items on products.id = order_items.PRODUCT_ID
where order_items.PRODUCT_ID is null;

use ferragem;

select order_items.ORDER_ID,orders.id, order_items.product_id
from orders
inner join order_items on orders.id=order_items.ORDER_ID
group by order_items.ORDER_ID, order_items.PRODUCT_ID
having count(order_items.product_id) > 2;
use ferragem;

select clients.id,clients.name, avg(total) as values_order
from clients
inner join orders on clients.id= orders.CLIENT_ID
group by clients.id,clients.name,orders.id
order by values_order desc;

use ferragem;

select products.id,products.name,sum(quantity) as quantity_total
from products
right join order_items on products.id= order_items.PRODUCT_ID
group by PRODUCT_ID, order_items.PRODUCT_ID
order by quantity_total desc;
