use booking_system;

drop procedure if exists uspParsingDeleteAirport;
 
delimiter $$

create procedure uspParsingDeleteAirport(in deleteAirportJson json)
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
		users_login 		varchar(30),		
        airport_code		varchar(3) 
		
		);

		insert into tempJson(users_login,
                         airport_code
					)
		select new_airport.users_login,
				new_airport.airport_code 
			
		from json_table(deleteAirportJson, '$' columns (
					users_login			varchar(30)       path '$.users.login',
                    airport_code        varchar(3)        path '$.airport.code'
				)
             ) as new_airport;
        
       
        start transaction;
        
        if exists(select parking_id from parking
					inner join tempJson 
					inner join airport on airport.`code` = tempJson.airport_code
					where parking.airport_id = airport.airport_id)
        then
					delete parking from parking
					inner join tempJson 
					inner join airport on airport.`code` = tempJson.airport_code
					where parking.airport_id = airport.airport_id;
        end if;
        
        delete airport from airport
        inner join tempJson
        where airport.`code` = tempJson.airport_code;
        
        commit;
end$$

delimiter ;