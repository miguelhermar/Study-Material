-- DELIMITER //

-- CREATE PROCEDURE test()
-- BEGIN
--     SELECT * FROM EmployeeDemographics;
-- END //

-- DELIMITER ;

-- CALL test;

-- DELIMITER //

-- CREATE PROCEDURE Temp_Employee()
-- BEGIN
-- 	DROP TABLE IF EXISTS temp_employee;
-- 	Create table temp_employee (
-- 	JobTitle varchar(100),
-- 	EmployeesPerJob int ,
-- 	AvgAge int,
-- 	AvgSalary int
-- 	);
--     
--  Insert into temp_employee
-- 	SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
-- 	FROM EmployeeDemographics emp
-- 	JOIN EmployeeSalary sal
-- 		ON emp.EmployeeID = sal.EmployeeID
-- 	group by JobTitle
-- 	HAVING temp_employee.JobTitle = JobTitle;
--     
--     SELECT * FROM temp_employee;
-- END //

-- DELIMITER ;

-- CALL Temp_Employee("Salesman");


-- with 'out' parameter

-- DELIMITER //

-- CREATE PROCEDURE test_out(out records int)
-- BEGIN
--     SELECT count(*) into records FROM EmployeeDemographics;
-- END //

-- DELIMITER ;

-- CALL test_out(@record);

-- SELECT @record as TotalRecords;


-- with 'in' and 'out' parameters

DELIMITER //

CREATE PROCEDURE test_in_out(inout records int, in JobTitle varchar(100))
BEGIN
	DROP TABLE IF EXISTS temp_employee;
	Create table temp_employee (
	JobTitle varchar(100),
	EmployeesPerJob int ,
	AvgAge int,
	AvgSalary int
	);
    
    Insert into temp_employee
	SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
	FROM EmployeeDemographics emp
	JOIN EmployeeSalary sal
		ON emp.EmployeeID = sal.EmployeeID
	group by JobTitle
    HAVING temp_employee.JobTitle = JobTitle;
    
    SELECT count(*) into records FROM temp_employee;
END //

DELIMITER ;

CALL test_in_out(@record, 'Salesman');

SELECT @record as TotalRecords;

