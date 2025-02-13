{{
    config(
        materialized = 'incremental'
    )
}}

WITH sources_orders AS (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY total_amount DESC) AS row_num
    FROM {{ ref('sources_orders') }}
)

select
 trim(order_id) order_id,
 trim(customer_id) customer_id,
 cast(trim(order_date) as date) order_date,
 total_amount,
 date_load
 from sources_orders
 WHERE row_num = 1
 {% if is_incremental() %}
  AND order_id > COALESCE((select max(order_id) from {{ this }}) ,'O000')
{% endif %}

