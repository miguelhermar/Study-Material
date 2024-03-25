use alex_freberg_tutorial;

show tables;

-- indexing
CREATE index idx_customer_name on EmployeeDemographics (FirstName);

desc EmployeeDemographics;

CREATE index idx_customer_first_last_name on EmployeeDemographics (FirstName, LastName);

alter table EmployeeDemographics drop index idx_customer_name;
alter table EmployeeDemographics drop index idx_customer_first_last_name;

-- analyzing query performance (explain)

EXPLAIN SELECT * FROM EmployeeDemographics;
EXPLAIN SELECT * FROM EmployeeDemographics ed JOIN EmployeeSalary es using(EmployeeID);

