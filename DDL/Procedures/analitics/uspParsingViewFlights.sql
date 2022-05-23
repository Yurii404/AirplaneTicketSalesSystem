use booking_system;

drop procedure if exists uspParsingViewFlight;

delimiter $$
create procedure uspParsingViewFlight(in viewFlightJson json)
begin    
    drop table if exists tempJson;
	create temporary table tempJson (
		user_login 				varchar(50),
		fromDatetimaDeparture  	datetime default now(),
		departureCity 			varchar(50),
		arrivalCity			 	varchar(50)
	);

    
	insert into tempJson (user_login,
							fromDatetimaDeparture, 
                            departureCity,
                            arrivalCity
                            )
	select js.user_login,
			js.fromDatetimaDeparture, 
            js.departureCity,
            js.arrivalCity
	from json_table(viewFlightJson, '$' columns (
						
                        user_login 				varchar(20) 	path '$.users.login',
                        fromDatetimaDeparture	datetime		path '$.filter.fromDateTimeDeparture',
                        
						nested path '$.filter.departureCities[*]' columns(
						departureCity 			varchar(50) 	path '$'
                                    ),
						arrivalCity 			varchar(50)		path '$.filter.arrivalCity')

					) as js;  
						
                            
		set @ResultQuery = '
			select  flight.`number`, 
					flight.datetime_departure,
                    flight.datetime_arrival,
					departureCity.`name` as departureCity,
					arrivalCity.`name` as arrivalCity
			from flight
				inner join tempJson
				inner join cities as departureCity on departureCity.`name` = tempJson.departureCity
                inner join cities as arrivalCity on arrivalCity.`name` = tempJson.arrivalCity
                where datetime_departure > tempJson.fromDatetimaDeparture
                order by datetime_departure ASC;';
                
        
       --  if exists (select * from tempJson where email is not null) 
		-- then
-- 			if exists (select * from tempJson where rating is not null) 
-- 			then
-- 				select concat('where ', @Email, ' and ', @Rating)
-- 				into @WhereQuery;
-- 			else
-- 				select concat('where ', @Email)
-- 				into @WhereQuery;
-- 			end if;
-- 		else
-- 			if exists (select * from tempJson where rating is not null) 
-- 			then
-- 				select concat('where ', @Rating)
-- 				into @WhereQuery;
-- 			end if;
--         end if;
--         
--         set @ResultQuery := replace(@ResultQuery, '{WhereQuery}', @WhereQuery);
        
        prepare stmt from @ResultQuery;
		execute stmt;
		deallocate prepare stmt;


end$$
delimiter ;
