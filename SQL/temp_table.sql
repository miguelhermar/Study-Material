 CREATE TEMPORARY TABLE _temp_Employee (
 EmployeeId int,
 JobTitle varchar(100),
 Salary int
 );
 
SELECT * from _temp_Employee;
 
Insert into _temp_Employee values (
'1001', 'HR', '45000'
);

Insert into _temp_Employee 
SELECT * From EmployeeSalary;

-- DROP TABLE IF EXISTS temp_Employee2;
Create TEMPORARY TABLE temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
);

SELECT * FROM temp_Employee2;

Insert into temp_Employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle;


