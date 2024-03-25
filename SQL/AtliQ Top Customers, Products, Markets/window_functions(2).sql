-- Market Share Global
with cte1 as (
	SELECT customer,
		round(SUM(net_sales)/1000000,2) as net_sales_mln
	FROM net_sales s
	JOIN dim_customer dc
		ON dc.customer_code=s.customer_code
	WHERE fiscal_year=2021
	GROUP BY customer
	ORDER BY net_sales_mln DESC)
SELECT *,
	net_sales_mln*100/SUM(net_sales_mln) over() as pct_contribution
FROM cte1;


-- Market Share per Region
with cte2 as (	
	SELECT customer, region,
		round(SUM(net_sales)/1000000,2) as net_sales_mln
	FROM net_sales s
	JOIN dim_customer dc
		ON dc.customer_code=s.customer_code
	WHERE fiscal_year=2021
	GROUP BY customer, region
	ORDER BY region, net_sales_mln DESC
	)
SELECT *, 
	net_sales_mln*100/SUM(net_sales_mln) over(partition by region) as pct_share_region
FROM cte2