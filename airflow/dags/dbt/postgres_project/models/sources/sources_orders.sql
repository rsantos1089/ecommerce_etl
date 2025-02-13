WITH raw_orders as (
    select * from {{ source('airflow','raw_orders') }}
)
SELECT
order_id ,
customer_id ,
order_date ,
total_amount,
current_date date_load
FROM raw_orders