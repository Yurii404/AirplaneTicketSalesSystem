use booking_system;

drop procedure if exists uspParsingAddSeat;
 
delimiter $$

create procedure uspParsingAddSeat(in addSeatJson json)
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
	
		user_login 			varchar(20),
        seat_number			int,
		seat_status    		varchar(20),
		seat_class			varchar(20),
		seat_price			int,
		airplane_code		varchar(20)
       
		);

		insert into tempJson(user_login ,
							seat_number,
							seat_status,
							seat_class,
							seat_price,
							airplane_code
					)
		select 	new_seat.user_login ,
				new_seat.seat_number,
				new_seat.seat_status,
				new_seat.seat_class,
				new_seat.seat_price,
				new_seat.airplane_code
							 
		from json_table(addSeatJson, '$' columns (
					user_login 			varchar(20) 	path '$.users.login',
					seat_number			int				path '$.seat.number',
                    seat_status    		varchar(20)		path '$.seat.status',
                    seat_class			varchar(20)		path '$.seat.class',
                    seat_price			int				path '$.seat.price',
                    airplane_code		varchar(20)		path '$.airplane.code'
				)
             ) as new_seat;
        
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
        insert into seat ( `number`, 
							airplane_id, 
                            class_id, 
                            status_id,
                            price)
		select  tempJson.seat_number, 
				airplane.airplane_id, 
                seat_classes.class_id, 
				seat_statuses.status_id, 
                tempJson.seat_price
		from tempJson
        inner join airplane ON airplane.`code` = tempJson.airplane_code
        inner join seat_classes ON seat_classes.`name` = tempJson.seat_class
        inner join seat_statuses ON seat_statuses.`name` = tempJson.seat_status;
        
        commit;
	
end$$

delimiter ;