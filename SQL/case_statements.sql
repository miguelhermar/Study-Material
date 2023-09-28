-- SELECT FirstName, LastName, Age,
-- CASE
-- 	WHEN Age > 30 THEN "Old"
--     WHEN Age between 27 and 30 then "Young"
--     ELSE "Baby"
-- END as youth
-- from EmployeeDemographics
-- WHERE age is not null
-- order by age;

SELECT FirstName, LastName, JobTitle, Salary,
CASE 
	WHEN JobTitle = "Salesman" then Salary + (Salary * .10)
    WHEN JobTitle = "Accountant" then Salary + (Salary * .05)
    WHEN JobTitle = "HR" then Salary + (Salary * .001)
    ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
from EmployeeDemographics
join EmployeeSalary 
using (EmployeeID)
