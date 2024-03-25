WITH cte_employee as (
	SELECT FirstName, LastName, Gender, Salary,
	COUNT(GENDER) OVER (Partition by Gender) as TotalGender,
	AVG(Salary) OVER (Partition by Gender) as AvgSalary
	FROM EmployeeDemographics ed
	JOIN EmployeeSalary es
	ON ed.EmployeeID = es.EmployeeID
    WHERE Salary > 45000
    )
SELECT * 
FROM cte_employee;

-- The following works for renaming the column within the CTE creation (it has to match the number of columns within the cte)

WITH cte_employee (f, g, h, i, j, k) as (
	SELECT FirstName, LastName, Gender, Salary,
	COUNT(GENDER) OVER (Partition by Gender) as TotalGender,
	AVG(Salary) OVER (Partition by Gender) as AvgSalary
	FROM EmployeeDemographics ed
	JOIN EmployeeSalary es
	ON ed.EmployeeID = es.EmployeeID
    WHERE Salary > 45000
    )
SELECT * FROM cte_employee;

-- Movies Database

-- two tables inside a with clause 
WITH 
profitPCT as
	(SELECT *, (revenue-budget)*100/budget as profit_pct 
	FROM financials),
AVGrating as 
	(SELECT * FROM movies
	WHERE imdb_rating < (SELECT avg(imdb_rating) from movies))
SELECT pp.movie_id, pp.profit_pct, ar.title, ar.imdb_rating 
FROM profitPCT pp
JOIN AVGrating ar
ON pp.movie_id=ar.movie_id
WHERE profit_pct >= 500;

---

-- select all hollowood movies released after year 2000 that made 500 millions or more profit. 

-- join outside cte
WITH
	movies_ as 
    (SELECT * FROM movies
	WHERE release_year > 2000 and industry = "hollywood"),
    financials_ as 
    (SELECT *, (revenue-budget) as profit FROM financials)
SELECT m.title, m.release_year, f.profit 
FROM movies_ m
JOIN financials_ f
ON m.movie_id=f.movie_id
WHERE profit>500;

-- join inside cte
with cte as 
	(select title, release_year, (revenue-budget) as profit
	from movies m
	join financials f
	on m.movie_id=f.movie_id
	where release_year>2000 and industry="hollywood"
)
select * from cte where profit>500;
		

 