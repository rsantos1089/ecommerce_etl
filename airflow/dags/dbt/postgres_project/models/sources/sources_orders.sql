WITH raw_orders as (
    select * from raw.orders
)
SELECT
order_id ,
customer_id ,
order_date ,
total_amount
FROM raw_orders