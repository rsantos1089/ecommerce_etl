{{
    config(
        materialized = 'incremental'
    )
}}

WITH sources_products AS (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY price DESC) AS row_num
    FROM {{ ref('sources_products') }}
)
SELECT
  trim(product_id) product_id ,
 case when product_name is null or trim(product_name) = ''
 then TRIM(category) else initcap(trim(product_name))
 end product_name,
 case when category is null or trim(category) = ''
 then TRIM(product_name) else initcap(trim(category))
 end category,
 case when price is null then 0
 when trim(price) ='ten' then 10
 when position('$' in trim(price)) >0 then cast(replace(trim(price),'$','')as float)
 else cast(price as float)
 end price,
 date_load
FROM sources_products
WHERE row_num = 1
{% if is_incremental() %}
  AND product_id > COALESCE((select max(product_id) from {{ this }}) ,'P000')
{% endif %}

