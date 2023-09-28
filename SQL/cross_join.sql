use food_db;

select *, concat(name, ' - ', variant_name) as full_name, 
(price+variant_price) as full_price
from items
cross join variants;

