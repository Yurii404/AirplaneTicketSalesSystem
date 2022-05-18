use booking_system;

drop procedure if exists uspParsingAddUsers;
 
delimiter $$

create procedure uspParsingAddUsers(in addUsersJson json)
begin

		drop table if exists tempJson;
		create temporary table tempJson
		(
        -- describe table columns
	
        full_name varchar(30),
        login varchar(20),
        hash_of_password varchar(16),
        phone_number varchar(25),
        email varchar(60)
        
		);

		insert into tempJson(
						full_name, login, hash_of_password, phone_number, email
					)
		select new_countries.full_name, new_countries.login, new_countries.hash_of_password,
				new_countries.phone_number, new_countries.email
		from json_table(addUsersJson, '$."users"' columns (
                    full_name varchar(30)        	path '$.fullName',
                    login varchar(20) 				path '$.login',
					hash_of_password varchar(16) 	path '$.hashOfPassport',
					phone_number varchar(25)		path '$.phoneNumber',	
					email varchar(60)				path '$.email'
				)
             ) as new_countries;
        
        insert into users (full_name, login, hash_of_password, phone_number, email, role_id, datetime_registration, datetime_last_visit )
		select tempJson.full_name, tempJson.login, tempJson.hash_of_password, 
        tempJson.phone_number, tempJson.email, 1, now(), now()
		from tempJson;
        
end$$

delimiter ;