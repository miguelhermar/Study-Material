-- 1. Indexes occupy extra storage
-- 2. When indexes are used in writing and updating the process is actually slower (it rearranges the B Tree structure)

EXPLAIN ANALYZE
SELECT * FROM gdb0041.fact_act_est
WHERE fiscal_year=2020
LIMIT 10000000;

-- Alternatives for creating an index
ALTER TABLE `gdb0041`.`fact_act_est` 
ADD INDEX `idx_fyear` (`fiscal_year` ASC) VISIBLE;

CREATE index idx_fyear on fact_act_est (fiscal_year);

-- show indexes (collation: ascending, descending) (cardinality: rough number of unique values)
show indexes in gdb0041.fact_act_est;
show indexes in languages;


-- FULLTEXT index: it can be useful when you want to perform advanced search operations on text columns.
ALTER TABLE `sakila`.`film` 
ADD FULLTEXT INDEX `idx_description` (`description`) VISIBLE;

-- using fulltext index after creating it (find the descriptions that have either the word "car" or "boat")
select * from sakila.film 
where match(description) against("car boat")
limit 10000;

-- description where there is "car" but not "boat"
select * from sakila.film 
where match(description) against("car -boat" in boolean mode)
limit 10000;

-- droppping index
alter table fact_act_est drop index idx_fyear;