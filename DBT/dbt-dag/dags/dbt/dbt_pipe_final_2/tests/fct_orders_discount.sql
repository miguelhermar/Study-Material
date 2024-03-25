-- In dbt, if a test query returns no rows, that means the test has "passed" 
-- because it didn't find any data violating the condition being tested. 
-- In this case, it seems you expect no positive item_discount_amount values, 
-- and since dbt isn't finding any, dbt is reporting that as the test passing — no errors mean no unexpected positive discount amounts were found.

select
    *
from
    {{ref('fct_orders')}}
where
    item_discount_amount > 0