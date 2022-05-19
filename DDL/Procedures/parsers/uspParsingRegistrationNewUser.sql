use booking_system;

drop procedure if exists uspParsingAddUsers;
 
delimiter $$

create procedure uspParsingAddUsers(in addUsersJson json)
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
	
		guest_ip  						varchar(20),
        guest_datetime_of_start			datetime,
        user_full_name 					varchar(30),
        user_login 						varchar(20),
        user_hash_of_password			varchar(16),
        user_role						varchar(20),
        user_phone_number 				varchar(25),
        user_email 						varchar(60),
        user_datetime_registration		datetime,
        user_datetime_last_visit		datetime
	
		);

		insert into tempJson(
						guest_ip,
						guest_datetime_of_start	,
						user_full_name 	, 
                        user_login, 
                        user_hash_of_password, 
                        user_role, 
                        user_phone_number,
                        user_email,
                        user_datetime_registration,
                        user_datetime_last_visit
					)
		select 	new_user.guest_ip,
				new_user.guest_datetime_of_start,
				new_user.user_full_name , 
				new_user.user_login, 
				new_user.user_hash_of_password, 
				new_user.user_role, 
				new_user.user_phone_number,
				new_user.user_email,
				new_user.user_datetime_registration,
				new_user.user_datetime_last_visit
		from json_table(addUsersJson, '$' columns (
					guest_ip  						varchar(20)		path '$.guest.ip',
					guest_datetime_of_start			datetime		path '$.guest.dateTimeOfStart',
					user_full_name 					varchar(30)		path '$.users.fullName',
					user_login 						varchar(20)		path '$.users.login',
					user_hash_of_password			varchar(16)		path '$.users.hashOfPassport',
					user_role						varchar(20)		path '$.users.role',
					user_phone_number 				varchar(25)		path '$.users.phoneNumber',
					user_email 						varchar(60)		path '$.users.email',
					user_datetime_registration		datetime		path '$.users.dateTimeRegistration',
					user_datetime_last_visit		datetime		path '$.users.dateTimeLastVisit'
	
				)
             ) as new_user;
        
        start transaction;
        
        -- insert guest
        insert into guest(  ip,
							datetime_of_start)
        select  tempJson.guest_ip, 
				tempJson.guest_datetime_of_start
		from tempJson;
        
        -- insert new user
        insert into users ( full_name, 
							login, 
                            hash_of_password, 
                            phone_number, 
                            email, 
                            role_id, 
                            datetime_registration, 
                            datetime_last_visit )
		select  tempJson.user_full_name, 
				tempJson.user_login, 
                tempJson.user_hash_of_password, 
				tempJson.user_phone_number, 
                tempJson.user_email, 
                system_roles.role_id, 
                tempJson.user_datetime_registration,
                tempJson.user_datetime_last_visit
		from tempJson
        inner join system_roles ON system_roles.`name` = tempJson.user_role;
        
        commit;
	
end$$

delimiter ;