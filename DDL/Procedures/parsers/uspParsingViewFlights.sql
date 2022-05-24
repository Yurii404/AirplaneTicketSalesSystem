use booking_system;

drop procedure if exists uspParsingViewFlight;

delimiter $$
create procedure uspParsingViewFlight(in viewFlightJson json)
begin    
    drop table if exists tempJson;
	create temporary table tempJson (
		user_login 				varchar(50),
		fromDatetimaDeparture  	datetime,
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
						
		
        
        set @DepartureCity =  '';              
        set @ArrivalCity =  '';              
		set @WhereQuery = '';                   
		set @ResultQuery := '
			select  flight.`number`, 
					flight.datetime_departure,
                    flight.datetime_arrival,
					departureCity.`name` as departureCity,
					arrivalCity.`name` as arrivalCity
			from flight
				inner join tempJson
				inner join cities as departureCity on departureCity.`name` {departureCity}   
                inner join cities as arrivalCity on arrivalCity.`name` {arrivalCity}
                inner join airport as departureAirport on departureAirport.city_id = departureCity.city_id
                inner join airport as arrivalAirport on arrivalAirport.city_id = arrivalCity.city_id
                {WhereQuery}
                order by datetime_departure ASC;';

		
		if exists (select * from tempJson where departureCity is not null) 
		then
				set @DepartureCity = '= tempJson.departureCity';
		else
				set @DepartureCity = 'in (select name from cities)';
        end if;


		if exists (select * from tempJson where arrivalCity is not null) 
		then
				set @ArrivalCity = '= tempJson.arrivalCity';
		else
				set @ArrivalCity = 'in (select name from cities)';
        end if;
        
        if exists (select * from tempJson where fromDatetimaDeparture is not null) 
		then
				set @WhereQuery = 'where DATE(datetime_departure) > DATE(tempJson.fromDatetimaDeparture)
                AND flight.departure_airport_id = departureAirport.airport_id  
                AND flight.arrival_airport_id = arrivalAirport.airport_id';
		else
				set @WhereQuery = 'where DATE(datetime_departure) > now()
                AND flight.departure_airport_id = departureAirport.airport_id  
                AND flight.arrival_airport_id = arrivalAirport.airport_id';
        end if;
        
		set @ResultQuery := replace(@ResultQuery, '{WhereQuery}', @WhereQuery);
        set @ResultQuery := replace(@ResultQuery, '{departureCity}', @DepartureCity);
        set @ResultQuery := replace(@ResultQuery, '{arrivalCity}', @ArrivalCity);
        
        prepare stmt from @ResultQuery;
		execute stmt;
		deallocate prepare stmt;

end$$
delimiter ;
