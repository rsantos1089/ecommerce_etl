select a.category, (sum(a.price)/(select sum(price) from model.products )) performance
from model.products a
group by category ;