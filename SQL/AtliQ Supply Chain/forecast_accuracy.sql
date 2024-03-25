/*
As a product owner, I need an aggregate forecast accuracy report for all the customers for
a given fiscal year so that I can track the accuracy of the forecast we
make for these customers.

The report should have the following fields,
1. Customer Code, Name, Market
2. Total Sold Quantity
3. Total Forecast Quantity
4. Net Error
5. Absolute Error
6. Forecast Accuracy%
*/

CREATE TEMPORARY TABLE forecast_error_table 
	SELECT 
		s.customer_code as customer_code,
		c.customer as customer_name,
		c.market as market,
        sum(s.sold_quantity) as total_sold_qty,
        sum(s.forecast_quantity) as total_forecast_qty,
		sum(s.forecast_quantity-s.sold_quantity) as net_error,
		round(sum(s.forecast_quantity-s.sold_quantity)*100/sum(s.forecast_quantity),1) as net_error_pct,
		sum(abs(s.forecast_quantity-s.sold_quantity)) as abs_error,
		round(sum(abs(s.forecast_quantity-sold_quantity))*100/sum(s.forecast_quantity),2) as abs_error_pct
	FROM fact_act_est s
    JOIN dim_customer c
    ON s.customer_code = c.customer_code
	WHERE s.fiscal_year=2021
	GROUP BY customer_code;
    
    
SELECT customer_code, customer_name, market,
	total_sold_qty, total_forecast_qty, net_error, net_error_pct, abs_error, abs_error_pct,
	if (abs_error_pct > 100, 0, 100-abs_error_pct)  as forecast_accuracy
FROM forecast_error_table 
ORDER BY forecast_accuracy DESC;
