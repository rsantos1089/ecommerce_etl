CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS model;

CREATE TABLE IF NOT EXISTS model.products (
 product_id varchar(50) PRIMARY KEY,
 name varchar(50),
 category varchar(50),
 price float
);

CREATE TABLE IF NOT EXISTS model.orders (
order_id varchar(50) PRIMARY KEY,
customer_id varchar(50),
order_date date,
total_amount float
);

CREATE TABLE IF NOT EXISTS model.order_items (
order_item_id varchar(50) PRIMARY KEY,
order_id varchar(50),
product_id varchar(50),
quantity int,
price float,
CONSTRAINT fk_products
FOREIGN KEY(product_id)
REFERENCES data.products(product_id),
CONSTRAINT fk_orders
FOREIGN KEY(order_id)
REFERENCES data.orders(order_id)
);
