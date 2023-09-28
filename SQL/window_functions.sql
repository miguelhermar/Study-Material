-- select FirstName, Salary,
-- rank() over (order by Salary DESC) as salary_rank, -- skips in a tie
-- dense_rank() over (order by Salary DESC) as salary_dense_rank, -- doesn't skip in a tie
-- row_number() over (order by Salary DESC) as salary_row_number -- row number
-- from EmployeeDemographics ed
-- JOIN EmployeeSalary es
-- using (EmployeeID);

/*
Partition By
*/

SELECT FirstName, LastName, Gender, Salary,
COUNT(GENDER) OVER (Partition by Gender) as TotalGender
FROM EmployeeDemographics ed
JOIN EmployeeSalary es
ON  ed.EmployeeID = es.EmployeeID;

SELECT FirstName, LastName, Gender, Salary,
COUNT(GENDER) OVER (Partition by Gender order by Salary) as TotalGender # ther order by here keeps the "groupby" chunked and it actually orders the salary column within that partition and starts counting
FROM EmployeeDemographics ed
JOIN EmployeeSalary es
ON  ed.EmployeeID = es.EmployeeID;


SELECT Gender, count(Gender)
FROM EmployeeDemographics ed
JOIN EmployeeSalary es
ON  ed.EmployeeID = es.EmployeeID
group by gender;

------

SELECT FirstName, LastName, Gender, Salary,
COUNT(GENDER) OVER (Partition by Gender) as TotalGender,
AVG(Salary) OVER (Partition by Gender) as AvgSalary
FROM EmployeeDemographics ed
JOIN EmployeeSalary es
ON ed.EmployeeID = es.EmployeeID;

SELECT Gender, Count(Gender), AVG(Salary)
FROM EmployeeDemographics ed
JOIN EmployeeSalary es
ON  ed.EmployeeID = es.EmployeeID
group by gender;

