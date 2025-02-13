CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS model;

CREATE TABLE IF NOT EXISTS model.products (
 product_id varchar(50) PRIMARY KEY,
 product_name varchar(50),
 category varchar(50),
 price float,
 date_load date default current_date
);

CREATE TABLE IF NOT EXISTS model.orders (
order_id varchar(50) PRIMARY KEY,
customer_id varchar(50),
order_date date,
total_amount float,
date_load date default current_date
);

CREATE TABLE IF NOT EXISTS model.order_items (
order_item_id varchar(50) PRIMARY KEY,
order_id varchar(50),
product_id varchar(50),
quantity int,
price float,
date_load date default current_date,
CONSTRAINT fk_products
FOREIGN KEY(product_id)
REFERENCES model.products(product_id),
CONSTRAINT fk_orders
FOREIGN KEY(order_id)
REFERENCES model.orders(order_id)
);
