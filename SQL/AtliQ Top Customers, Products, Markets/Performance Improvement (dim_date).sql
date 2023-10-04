/*
First way to improve performance: create an extra table (dim_date) 
instead of calling the user defined function "get_fiscal_year".
New dim_date table has calendar_date and fiscal_year columns
*/

SELECT fsm.date, fsm.product_code, dp.product, dp.variant, fsm.sold_quantity, fgp.gross_price,
	round((fsm.sold_quantity*fgp.gross_price), 2) as gross_price_total,
    pre.pre_invoice_discount_pct
from fact_sales_monthly fsm
JOIN dim_product dp
ON fsm.product_code=dp.product_code
JOIN dim_date dt
	ON dt.calendar_date=fsm.date
JOIN fact_gross_price fgp
ON fsm.product_code=fgp.product_code AND dt.fiscal_year=fgp.fiscal_year
JOIN fact_pre_invoice_deductions pre
ON pre.customer_code=fsm.customer_code 
	AND pre.fiscal_year=dt.fiscal_year
WHERE dt.fiscal_year = 2021
LIMIT 1000000;