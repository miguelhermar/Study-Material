/*
As a product owner, I want to generate a report of individual product sales (aggregated on a monthly basis at the product code level) for Croma India customer for FY=2021 so that I can track individual
product sales and run further product analytics on it in excel.
The report should have the following fields,
1. Month
2. Product Name
3. Variant
4. Sold Quantity
5. Gross Price Per Item
6. Gross Price Total
*/


-- Important to join fsm table with fgp on product_code AND also fiscal_year, 
-- otherwise the result will have info from multiple fiscal years.

SELECT fsm.date, fsm.product_code, dp.product, dp.variant, fsm.sold_quantity, fgp.gross_price,
	round((fsm.sold_quantity*fgp.gross_price), 2) as gross_price_total
from fact_sales_monthly fsm
JOIN dim_product dp
ON fsm.product_code=dp.product_code
JOIN fact_gross_price fgp
ON fsm.product_code=fgp.product_code AND get_fiscal_year(fsm.date)=fgp.fiscal_year
where customer_code=90002002 
	and get_fiscal_year(date)=2021;
    
CREATE VIEW monthly_sales_report as
SELECT fsm.date, fsm.product_code, dp.product, dp.variant, fsm.sold_quantity, fgp.gross_price,
	round((fsm.sold_quantity*fgp.gross_price), 2) as gross_price_total
from fact_sales_monthly fsm
JOIN dim_product dp
ON fsm.product_code=dp.product_code
JOIN fact_gross_price fgp
ON fsm.product_code=fgp.product_code  AND get_fiscal_year(fsm.date)=fgp.fiscal_year
where customer_code=90002002 
	and get_fiscal_year(date)=2021;
    
-- SELECT * FROM monthly_sales_report;
-- drop view monthly_sales_report;