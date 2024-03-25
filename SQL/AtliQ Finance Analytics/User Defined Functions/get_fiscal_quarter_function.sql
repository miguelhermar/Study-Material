CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_quarter`(
calendar_date DATE 
) RETURNS char(2) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE m tinyint;
    DECLARE qtr char(2);
	SET m = month(calendar_date);
    
    CASE
		WHEN m in (9, 10, 11) THEN set qtr = "Q1";
        WHEN m in (12, 1, 2) THEN set qtr = "Q2";
        WHEN m in (3, 4, 5) THEN set qtr = "Q3";
        ELSE set qtr = "Q4";
    END CASE;

RETURN qtr;
END