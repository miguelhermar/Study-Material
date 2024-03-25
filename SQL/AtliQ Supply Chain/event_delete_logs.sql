show events;

show variables like "%event%"; -- if event_scheduler is ON, one can directly create an event

CREATE EVENT e_daily_log_purge
on schedule every 1 day
starts current_timestamp
comment "purge logs that are 5 days or older"
DO 
	delete from random_tables.session_logs
	where date(ts) < curdate() - interval 5 day;
    
drop event if exists e_daily_log_purge;