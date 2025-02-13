select b.product_name  , (a.quantity * a.price) total
from model.order_items a
inner join model.products b
on a.product_id = b.product_id
order by 2 desc;