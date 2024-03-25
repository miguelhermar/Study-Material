-- Backup Automation Event

CREATE EVENT nightly_backup
on schedule every 1 month
starts current_timestamp
comment "nightly_backup_event"
DO 
	create database my_database_backup;
    create table my_database_backup.sales_backup
		as select * from alex_freber_tutorial.EmployeeDemographics;