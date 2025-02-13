WITH raw_order_items as (
    select * from raw.order_items
)
SELECT
order_item_id ,
order_id ,
product_id ,
quantity ,
price
FROM raw_order_items