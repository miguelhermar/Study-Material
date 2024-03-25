-- Calculates the percentage for each product with respect to the total expense
SELECT *,
	amount*100/SUM(amount) over () as pct
FROM expenses
ORDER BY category;


-- Calculates the percentage for each product with respect to the total for each category
SELECT *,
	amount*100/SUM(amount) over (partition by category) as pct
FROM expenses
ORDER BY category;


SELECT *, SUM(amount) over (partition by category order by date) as cum_sum
FROM expenses
ORDER BY category, date;
