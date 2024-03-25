-- Surrogate keys are useful in dimensional modeling when one has a lot of fact and
-- dim tables that are going to be connected.

-- Surrogate keys ensure that each row in a table has a unique identifier.
-- Here, l_orderkey and l_linenumber are combined to generate a unique order_item_key. 
-- This ensures that each line item in the lineitem table can be uniquely identified,
-- even if there are multiple line items associated with the same order (which l_orderkey by itself might not uniquely identify).

select
    {{
        dbt_utils.generate_surrogate_key([
            'l_orderkey',
            'l_linenumber'
        ])
    }} as order_item_key,
	l_orderkey as order_key,
	l_partkey as part_key,
	l_linenumber as line_number,
	l_quantity as quantity,
	l_extendedprice as extended_price,
	l_discount as discount_percentage,
	l_tax as tax_rate
from
    {{ source('tpch', 'lineitem') }}