CREATE DEFINER=`root`@`localhost` PROCEDURE `monthly_gross_sales_mlt_cust`(
	in_customer_codes TEXT 
    )
BEGIN
	SELECT fsm.date, 
		sum(round((sold_quantity*gross_price), 2)) as total_gross_sales  
	FROM fact_sales_monthly fsm
	JOIN fact_gross_price fgp
	ON fsm.product_code=fgp.product_code 
		AND get_fiscal_year(fsm.date)=fgp.fiscal_year
	WHERE find_in_set(fsm.customer_code, in_customer_codes)>0
	GROUP BY fsm.date;
END