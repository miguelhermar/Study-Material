-- VIEW: It doesn’t store the data itself, but rather a reference to the underlying tables.

CREATE VIEW employee_info as
select FirstName, LastName, Age, Salary
FROm EmployeeDemographics ed
join EmployeeSalary es
on ed.EmployeeID=es.EmployeeID;

SELECT * FROM employee_info;

drop view employee_info;

-- Queries that don't support views: update statement, aggregate functions, groupby, having, union,
-- left join, right join (except inner join), subqueries