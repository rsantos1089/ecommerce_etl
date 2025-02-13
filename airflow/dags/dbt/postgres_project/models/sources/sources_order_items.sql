WITH raw_order_items as (
    select * from {{ source('airflow','raw_order_items') }}
)
SELECT
order_item_id ,
order_id ,
product_id ,
quantity ,
price,
current_date date_load
from raw_order_items