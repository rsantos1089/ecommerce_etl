WITH raw_products as (
    select * from {{ source('airflow','raw_products') }}
)
SELECT
 product_id ,
 product_name ,
 category ,
 price,
 current_date date_load
 FROM raw_products