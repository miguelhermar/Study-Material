EXPLAIN ANALYZE
SELECT fsm.date, fsm.product_code, dp.product, dp.variant, fsm.sold_quantity, fgp.gross_price,
	round((fsm.sold_quantity*fgp.gross_price), 2) as gross_price_total,
    pre.pre_invoice_discount_pct
from fact_sales_monthly fsm
JOIN dim_product dp
ON fsm.product_code=dp.product_code
JOIN fact_gross_price fgp
ON fsm.product_code=fgp.product_code AND get_fiscal_year(fsm.date)=fgp.fiscal_year
JOIN fact_pre_invoice_deductions pre
ON pre.customer_code = fsm.customer_code AND pre.fiscal_year=get_fiscal_year(fsm.date)
where get_fiscal_year(date)=2021
LIMIT 10000000;