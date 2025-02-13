WITH raw_products as (
    select * from raw.products
)
SELECT
 product_id ,
 product_name ,
 category ,
 price
 FROM raw_products