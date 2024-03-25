show databases;
create database krish_naik;

create table customer_info (
id int auto_increment, 
first_name varchar(25), 
last_name varchar(25),
salary int,
primary key(id)
);

insert into customer_info(first_name, last_name, salary) values
('John', 'Daniel', 50000),
('Krish', 'Naik', 60000),
('Darius', 'Bengali', 70000),
('Chandan', 'Kumar', 40000),
('Ankit', 'Sharma', NULL);

SELECT * FROM customer_info WHERE salary is null;
SELECT * FROM customer_info WHERE salary is not null;

update customer_info set salary = 50000 where id=5;

SELECT * FROM customer_info;

-- alter table

alter table customer_info add email varchar(40);
alter table customer_info add dob date;

desc customer_info;

alter table customer_info drop column dob;