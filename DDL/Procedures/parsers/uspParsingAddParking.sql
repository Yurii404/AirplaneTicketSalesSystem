use booking_system;

drop procedure if exists uspParsingAddParking;
 
delimiter $$

create procedure uspParsingAddParking(in addParkingJson json)
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
	
		user_login 					varchar(20),
        airport_code				varchar(3),
        parking_code				int,
        parking_name				varchar(30),
        parking_price  				int,
        parking_num_of_places		int		
       
		);

		insert into tempJson(user_login ,
							 airport_code,
							 parking_code,
							 parking_name,
							 parking_price ,
							 parking_num_of_places
					)
		select 	new_parking.user_login ,
							 new_parking.airport_code,
							 new_parking.parking_code,
							 new_parking.parking_name,
							 new_parking. parking_price ,
							 new_parking.parking_num_of_places
				
		from json_table(addParkingJson, '$' columns (
					user_login 					varchar(20) 	path '$.users.login',
					airport_code				varchar(3)		path '$.airport.code',
					parking_code				int				path '$.parking.code',
					parking_name				varchar(30)		path '$.parking.name',
					parking_price  				int				path '$.parking.price',
					parking_num_of_places		int				path '$.parking.numOfPlaces'
				)
             ) as new_parking;
        
        start transaction;

        
        -- insert new user
        insert into parking ( `code`, 
							`name`, 
                            airport_id, 
                            price,
                            num_of_places)
		select  tempJson.parking_code, 
				tempJson.parking_name, 
                airport.airport_id, 
				tempJson.parking_price, 
                tempJson.parking_num_of_places
                
		from tempJson
        inner join airport ON airport.`code` = tempJson.airport_code
		inner join users on (users.login = tempJson.user_login)
        inner join system_roles on (users.role_id = system_roles.role_id)
        where system_roles.`name` = "Administrator";
        
        commit;
	
end$$

delimiter ;