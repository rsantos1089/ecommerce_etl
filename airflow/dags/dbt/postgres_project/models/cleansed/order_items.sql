{{
    config(
        materialized = 'incremental'
    )
}}

WITH sources_order_items AS (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY order_item_id ORDER BY price DESC) AS row_num
    FROM {{ ref('sources_order_items') }}
)

select
 trim(order_item_id) order_item_id,
 trim(order_id) order_id,
 trim(product_id) product_id,
 quantity,
 price,
 date_load
 from sources_order_items
 WHERE row_num = 1
 {% if is_incremental() %}
  AND order_item_id > COALESCE((select max(order_item_id) from {{ this }}) ,'OI000')
{% endif %}
