/*

Today's Topic: String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

*/

-- Drop Table EmployeeErrors;

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
);

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired');

Select *
From EmployeeErrors;

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors;

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors;

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors;

-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors;

-- Using Substring

SELECT substring(ee.FirstName, 1, 3), substring(ed.FirstName, 1, 3), substring(ee.LastName, 1, 3), substring(ed.LastName, 1, 3)
FROM EmployeeErrors ee
JOIN EmployeeDemographics ed
on substring(ee.FirstName, 1, 3)=substring(ed.FirstName, 1, 3)
and substring(ee.LastName, 1, 3)=substring(ed.LastName, 1, 3);

-- Using UPPER and lower

Select firstname, LOWER(firstname)
from EmployeeErrors;

Select Firstname, UPPER(FirstName)
from EmployeeErrors;




