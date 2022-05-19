use booking_system;

drop procedure if exists uspParsingAddAirplane;
 
delimiter $$

create procedure uspParsingAddAirplane(in addAirplaneJson json)
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
	
		user_login 							varchar(20),
        airplane_code						varchar(10),
        airplane_name						varchar(20),
        airplane_num_of_seats 				int,
        airplane_max_weight_of_luggage 		int,
        airplane_max_weight_of_carry_on 	int,
        airplane_price_of_luggage 			int
       
		);

		insert into tempJson(user_login ,
							 airplane_code,
							 airplane_name,
							 airplane_num_of_seats ,
							 airplane_max_weight_of_luggage,
							 airplane_max_weight_of_carry_on,
							 airplane_price_of_luggage
					)
		select 	new_airplane.user_login ,
							 new_airplane.airplane_code,
							 new_airplane.airplane_name,
							 new_airplane.airplane_num_of_seats ,
							 new_airplane.airplane_max_weight_of_luggage,
							 new_airplane.airplane_max_weight_of_carry_on,
							 new_airplane.airplane_price_of_luggage
				
		from json_table(addAirplaneJson, '$' columns (
					user_login 							varchar(20) 	path '$.users.login',
					airplane_code						varchar(10)		path '$.airplane.code',
					airplane_name						varchar(20)		path '$.airplane.name',
					airplane_num_of_seats 				int				path '$.airplane.numOfSeats',
					airplane_max_weight_of_luggage 		int				path '$.airplane.maxWeightOfLuggage',
					airplane_max_weight_of_carry_on 	int				path '$.airplane.maxWeightOfCarryOn',
					airplane_price_of_luggage 			int				path '$.airplane.priceOfLuggage'
		
				)
             ) as new_airplane;
        
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
        insert into airplane ( `code`, 
							`name`, 
                            num_of_seats, 
                            max_weight_of_luggage,
                            max_weight_of_carry_on,
                            price_of_luggage)
		select  tempJson.airplane_code, 
				tempJson.airplane_name, 
                tempJson.airplane_num_of_seats, 
				tempJson.airplane_max_weight_of_luggage, 
                tempJson.airplane_max_weight_of_carry_on,
                tempJson.airplane_price_of_luggage
		from tempJson;
        
        commit;
	
end$$

delimiter ;