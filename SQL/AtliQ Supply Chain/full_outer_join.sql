CREATE TABLE fact_act_est
(
	SELECT 
		fsm.date as date, 
		fsm.fiscal_year as fiscal_year, 
		fsm.product_code as product_code, 
		fsm.customer_code as customer_code,
		fsm.sold_quantity as sold_quantity, 
		ffm.forecast_quantity as forecast_quantity
	FROM fact_sales_monthly fsm
	LEFT JOIN fact_forecast_monthly ffm
	USING (date, product_code, customer_code)

	UNION

	SELECT 
		ffm.date as date, 
		ffm.fiscal_year as fiscal_year, 
		ffm.product_code as product_code, 
		ffm.customer_code as customer_code,
		fsm.sold_quantity as sold_quantity, 
		ffm.forecast_quantity as forecast_quantity
	FROM fact_sales_monthly fsm 
	RIGHT JOIN fact_forecast_monthly ffm
	USING (date, product_code, customer_code)
);




