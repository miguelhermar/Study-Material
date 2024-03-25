/*
As a product owner, I need an aggregate monthly gross sales report for Croma India customer,
so that I can track how much sales this particular customer is generating for AtliQ and manage our relationships accordingly.
The report should have the following fields,
1. Month
2. Total gross sales amount to Croma India in this month
*/

SELECT fsm.date, sum(round((sold_quantity*gross_price), 2)) as total_gross_sales  
FROM fact_sales_monthly fsm
JOIN fact_gross_price fgp
ON fsm.product_code=fgp.product_code AND get_fiscal_year(fsm.date)=fgp.fiscal_year
WHERE fsm.customer_code=90002002
GROUP BY fsm.date;

