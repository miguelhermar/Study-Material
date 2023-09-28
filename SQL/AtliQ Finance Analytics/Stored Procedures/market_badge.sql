CREATE DEFINER=`root`@`localhost` PROCEDURE `market_badge`(
	IN market_name varchar(30), 
    IN f_year year,
    OUT badge varchar(6)
)
BEGIN

	-- Declare a variable to hold the total_sold_quantity
    DECLARE total_sold_quantity INT DEFAULT 0;
	
    -- Set default market to India
    IF market_name="" THEN 
		SET market_name="India";
    END IF;
    
	SET total_sold_quantity =
    (SELECT sum(sold_quantity)
	FROM fact_sales_monthly fsm
	JOIN dim_customer dc
	ON fsm.customer_code=dc.customer_code
	WHERE get_fiscal_year(fsm.date)=f_year 
		AND dc.market=market_name
	GROUP BY market);
        
    /* Alternative:
    SELECT sum(sold_quantity) into total_sold_quantity
	FROM fact_sales_monthly fsm
	JOIN dim_customer dc
	ON fsm.customer_code=dc.customer_code
	WHERE get_fiscal_year(fsm.date)=f_year 
		AND dc.market=market_name
	GROUP BY market
    */
    
    -- Determine the badge based on the total_sold_quantity
    IF total_sold_quantity > 5000000 THEN
        SET badge = 'Gold';
    ELSE
        SET badge = 'Silver';
    END IF;
END