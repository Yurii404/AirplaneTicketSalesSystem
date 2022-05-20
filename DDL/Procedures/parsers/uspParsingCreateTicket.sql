use booking_system;

drop procedure if exists uspParsingCreateTicket;
 
delimiter $$

create procedure uspParsingCreateTicket(in addTicketJson json)
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
        flight_number					int,
        seat_number						int,
        ticket_number					int,
        ticket_status					varchar(30),
        ticket_price					int,
        ticket_datetime_last_edit		datetime
        
		);

		insert into tempJson(user_login ,
							flight_number,
							seat_number,
							ticket_number,
                            ticket_status,
							ticket_price,
							ticket_datetime_last_edit
					)
		select 	new_ticket.user_login ,
							new_ticket.flight_number,
							new_ticket.seat_number,
							new_ticket.ticket_number,
                            new_ticket.ticket_status,
							new_ticket.ticket_price,
							new_ticket.ticket_datetime_last_edit
							 
		from json_table(addTicketJson, '$' columns (
					user_login 						varchar(20)		path '$.users.login',
					flight_number					int				path '$.flight.number',
					seat_number						int				path '$.seat.number',
					ticket_number					int				path '$.ticket.number',
                    ticket_status					varchar(30)		path '$.ticket.status',
					ticket_price					int				path '$.ticket.price',
					ticket_datetime_last_edit		datetime		path '$.ticket.dateTimeLastEdit'
				)
             ) as new_ticket;
        
        start transaction;
        
       
        -- insert new user
        insert into ticket ( `number`,
							seat_id,
                            flight_id,
                            price,
                            status_id,
                            datetime_last_edit,
                            creator_id
                            )
		select  tempJson.ticket_number,
				seat.seat_id,
                flight.flight_id,
                tempJson.ticket_price,
                ticket_statuses.status_id,
                tempJson.ticket_datetime_last_edit,
                users.user_id
		from tempJson
        inner join flight ON flight.`number` = tempJson.flight_number
        inner join seat ON seat.`number` = tempJson.seat_number AND seat.airplane_id = flight.airplane_id
        inner join ticket_statuses ON ticket_statuses.`name` = tempJson.ticket_status
		inner join users on (users.login = tempJson.user_login)
        inner join system_roles on (users.role_id = system_roles.role_id)
        where system_roles.`name` = "Administrator";
        
        
        commit;
	
end$$

delimiter ;