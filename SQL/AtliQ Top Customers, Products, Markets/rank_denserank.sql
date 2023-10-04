SELECT *,
	row_number() over(partition by category order by amount DESC) as row_n,
    rank() over(partition by category order by amount DESC) as rnk,
	dense_rank() over(partition by category order by amount DESC) as dense_rnk
FROM expenses
ORDER by category;


-- Show 2 Top Expenses in each category
with cte1 as (
	SELECT *,
		row_number() over(partition by category order by amount DESC) as row_n,
		rank() over(partition by category order by amount DESC) as rnk,
		dense_rank() over(partition by category order by amount DESC) as dense_rnk
	FROM expenses
	ORDER by category
    )
SELECT * FROM cte1 WHERE dense_rnk<=2;


-- top n products in each division by their quantity sold
with cte1 as (
	SELECT dp.division, dp.product, SUM(sold_quantity) as total_qty
	FROM fact_sales_monthly fsm
	JOIN dim_product dp
		ON fsm.product_code=dp.product_code
	WHERE fiscal_year=2021
	GROUP BY dp.division,dp.product),
	cte2 as (
		SELECT *,
			dense_rank() over(partition by division order by total_qty DESC) as dense_rnk
		FROM cte1)
SELECT * FROM cte2 where dense_rnk<=3;


-- exercise: retrieve the top 2 markets in every region by their gross sales amount in FY=2021

with cte1 as (
SELECT dc.market, region, 
	ROUND(SUM(gross_price_total)/1000000, 2) as gross_sales_mln
FROM `gross sales` gs
JOIN dim_customer dc
	ON gs.customer_code=dc.customer_code
WHERe fiscal_year=2021
GROUP BY dc.market, region
ORDER BY region, gross_sales_mln DESC),
cte2 as (
		SELECT *, 
			dense_rank() over(partition by region order by gross_sales_mln DESC) as rnk
		FROM cte1)
SELECT * FROM cte2 where rnk<=2;
