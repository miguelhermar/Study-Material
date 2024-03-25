DROP TRIGGER IF EXISTS `gdb0041`.`fact_sales_monthly_AFTER_INSERT`;

DELIMITER $$
USE `gdb0041`$$
CREATE DEFINER = CURRENT_USER TRIGGER `gdb0041`.`fact_sales_monthly_AFTER_INSERT` AFTER INSERT ON `fact_sales_monthly` FOR EACH ROW
BEGIN
	insert into fact_act_est 
		(date, product_code, customer_code, sold_quantity)
	values (
		new.date,
        new.product_code,
        new.customer_code,
        new.sold_quantity
    )
    on duplicate key update
		sold_quantity = values(sold_quantity);
END$$
DELIMITER ;

Show triggers;