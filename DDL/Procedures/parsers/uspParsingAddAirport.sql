use booking_system;

drop procedure if exists uspParsingAddAirport;
 
delimiter $$

create procedure uspParsingAddAirport(in addAirportJson json)
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
        `code` 				varchar(3) ,
		`name`			    varchar(20) ,
		city 				varchar(20) ,
		country 			varchar(20) ,
		num_of_terminals	tinyint
        
		);

		insert into tempJson(users_login,
						`code`,
                        `name`, 
                        city, 
                        country,
                        num_of_terminals
					)
		select new_airport.users_login,
				new_airport.`code`, 
				new_airport.`name`, 
                new_airport.city,
				new_airport.country, 
                new_airport.num_of_terminals
		from json_table(addAirportJson, '$' columns (
					users_login			varchar(30)       path '$.users.login',
                    `code`              varchar(3)        path '$.airport.code',
					`name` 				varchar(20)       path '$.airport.name',
					num_of_terminals 	tinyint 		  path '$.airport.numOfTerminals',
                    city 				varchar(20)		  path '$.airport.city',
					country 			varchar(20)	 	  path '$.airport.country'
				)
             ) as new_airport;
        
       
        
        start transaction;
        
        insert into airport (
							`code`,
							`name`,
							city_id,
							country_id,
							num_of_terminals 
        )
		select  tempJson.`code`, 
				tempJson.`name`, 
				cities.city_id,
                countries.country_id , 
                tempJson.num_of_terminals
		from tempJson
        inner join cities ON cities.`name` = tempJson.city
        inner join countries ON countries.`name` = tempJson.country
		inner join users on (users.login = tempJson.user_login)
        inner join system_roles on (users.role_id = system_roles.role_id)
        where system_roles.`name` = "Administrator";
        
        commit;
end$$

delimiter ;