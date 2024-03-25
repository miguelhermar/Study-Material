-- The supply chain business manager wants to see which customers’ forecast accuracy has dropped from 2020 to 2021. 

drop table if exists forecast_accuracy_2020;
CREATE TEMPORARY TABLE forecast_accuracy_2020 
with forecast_err_table as (
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
	WHERE s.fiscal_year=2020
	GROUP BY customer_code)
SELECT 
        *,
    IF (abs_error_pct > 100, 0, 100.0 - abs_error_pct) as forecast_accuracy
FROM 
	forecast_err_table
ORDER BY forecast_accuracy desc;
    
    
drop table if exists forecast_accuracy_2021;
CREATE TEMPORARY TABLE forecast_accuracy_2021
with forecast_err_table as ( 
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
	GROUP BY customer_code)
select 
        *,
    if (abs_error_pct > 100, 0, 100.0 - abs_error_pct) as forecast_accuracy
from 
	forecast_err_table
order by forecast_accuracy desc;
    
SELECT * FROM forecast_accuracy_2020;
SELECT * FROM forecast_accuracy_2021;


with final_cte as (
	SELECT  f_20.customer_code, f_20.customer_name, f_20.market, 
		f_20.forecast_accuracy as forecast_acc_2020,
		f_21.forecast_accuracy as forecast_acc_2021
	FROM forecast_accuracy_2020 f_20
	JOIN forecast_accuracy_2021 f_21
	USING (customer_code)
	where f_21.forecast_accuracy < f_20.forecast_accuracy
)
SELECT *, 
	abs(forecast_acc_2021-forecast_acc_2020) as units_drop 
FROM final_cte
ORDER BY units_drop DESC;    