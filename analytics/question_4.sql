select c.product_name ,a.order_date, sum(b.quantity * b.price) volume, sum(b.quantity * b.price - c.price) revenue
from model.orders a
inner join model.order_items b
on a.order_id  = b.order_id
inner join model.products c
on b.product_id = c.product_id
group by c.product_name,a.order_date
order by 4 desc