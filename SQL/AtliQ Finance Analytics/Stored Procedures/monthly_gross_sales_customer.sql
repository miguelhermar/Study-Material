CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
	c_code INT 
    )
BEGIN
	SELECT fsm.date, 
		sum(round((sold_quantity*gross_price), 2)) as total_gross_sales  
	FROM fact_sales_monthly fsm
	JOIN fact_gross_price fgp
	ON fsm.product_code=fgp.product_code 
		AND get_fiscal_year(fsm.date)=fgp.fiscal_year
	WHERE fsm.customer_code=c_code
	GROUP BY fsm.date;
END