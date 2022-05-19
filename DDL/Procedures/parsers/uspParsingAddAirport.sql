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
        
        if not exists (select user_id from users where role_id = (
						select role_id from system_roles where `name` = "Administrator"))
		then
        -- error message output
        select 'This can do only administartor';

        -- exit parser procedure 
        leave proc_body;
		end if;
        
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
        inner join countries ON countries.`name` = tempJson.country;
        
        commit;
end$$

delimiter ;