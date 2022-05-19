use booking_system;

drop procedure if exists uspParsingCreateFlight;
 
delimiter $$

create procedure uspParsingCreateFlight(in addFlightJson json)
proc_body:
begin

		declare exit handler for sqlexception
		 begin
			-- error message output
			get diagnostics @p1 = number;
			get diagnostics condition @p1 @p2 = message_text;
			select @p1, @p2;

			rollback;
		end;
		
		drop table if exists tempJson;
		create temporary table tempJson
		(
        -- describe table columns
	
		user_login 						varchar(20),
        airplane_code					varchar(20),
        arrival_airport_code			varchar(3),
        departure_airport_code			varchar(3),
        flight_number					int,
        flight_datetime_arrival			datetime,
        flight_datetime_departure		datetime,
        flight_flight_time				int
        
		);

		insert into tempJson(user_login ,
							airplane_code,
							arrival_airport_code,
							departure_airport_code,
							flight_number,
							flight_datetime_arrival	,
							flight_datetime_departure,
							flight_flight_time
					)
		select 	new_flight.user_login ,
							new_flight.airplane_code,
							new_flight.arrival_airport_code,
							new_flight.departure_airport_code,
							new_flight.flight_number,
							new_flight.flight_datetime_arrival	,
							new_flight.flight_datetime_departure,
							new_flight.flight_flight_time
							 
		from json_table(addFlightJson, '$' columns (
					user_login 						varchar(20)		path '$.users.login',
					airplane_code					varchar(20)		path '$.airplane.code',
					arrival_airport_code			varchar(3)		path '$.arrivalAirport.code',
					departure_airport_code			varchar(3)		path '$.departureAirport.code',
					flight_number					int				path '$.flight.number',
					flight_datetime_arrival			datetime		path '$.flight.dateTimeArrival',
					flight_datetime_departure		datetime		path '$.flight.dateTimeDeparture',
					flight_flight_time				int				path '$.flight.flightTime'
				)
             ) as new_flight;
        
        start transaction;
        
        if not exists (select user_id from users where role_id = (
						select role_id from system_roles where `name` = "Administrator"))
		then
        -- error message output
        select 'This can do only administartor';

        -- exit parser procedure 
        leave proc_body;
		end if;
        
        
        -- insert new user
        insert into flight ( `number`,
							airplane_id,
                            datetime_departure,
                            departure_airport_id,
                            datetime_arrival,
                            arrival_airport_id,
                            flight_time
                            )
		select  tempJson.flight_number,
				airplane.airplane_id,
                tempJson.flight_datetime_departure,
                departure_airport.airport_id as departure_airport,
                tempJson.flight_datetime_arrival,
                arrival_airport.airport_id as arrival_airport,
                tempJson.flight_flight_time
		from tempJson
        inner join airplane ON airplane.`code` = tempJson.airplane_code
        inner join airport as departure_airport ON departure_airport.`code` = tempJson.departure_airport_code
        inner join airport as arrival_airport ON arrival_airport.`code` = tempJson.arrival_airport_code;
        
        
        commit;
	
end$$

delimiter ;