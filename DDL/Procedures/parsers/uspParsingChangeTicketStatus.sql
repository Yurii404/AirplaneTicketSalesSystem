use booking_system;

drop procedure if exists uspParsingChangeTicketStatus;
 
delimiter $$

create procedure uspParsingChangeTicketStatus(in changeTicketStatusJson json)
proc_body:
begin
		declare old_status_id int;
        
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
        ticket_number					int,
        new_data_new_status				varchar(20)
        
		);

		insert into tempJson(user_login ,
							ticket_number,
							new_data_new_status
					)
		select 	new_ticket.user_login ,
							new_ticket.ticket_number,
							new_ticket.new_data_new_status
		from json_table(changeTicketStatusJson, '$' columns (
					user_login 							varchar(20)		path '$.users.login',
					ticket_number						int				path '$.ticket.number',
					new_data_new_status					varchar(20)    	path '$.newData.newStatus'
				)
             ) as new_ticket;
		
        
		start transaction;
        
        select ticket.status_id 
        from ticket
		inner join tempJson on ticket.`number` = tempJson.ticket_number
        into @old_status_id;
        
		insert into change_ticket_status( ticket_id,
											user_id,
                                            datetime_change,
                                            old_status_id,
                                            new_status_id)
		select ticket.ticket_id,
				users.user_id,
                now(),
                @old_status_id,
                ticket_statuses.status_id
		from tempJson
        inner join ticket on ticket.`number` = tempJson.ticket_number
        inner join users on users.login = tempJson.user_login
        inner join ticket_statuses on ticket_statuses.`name` = tempJson.new_data_new_status
        inner join system_roles on (users.role_id = system_roles.role_id)
        where system_roles.`name` = "Administrator";
        
		update ticket
        inner join tempJson on tempJson.ticket_number = ticket.`number`
        inner join ticket_statuses on ticket_statuses.`name` = tempJson.new_data_new_status
        set ticket.status_id = ticket_statuses.status_id;
		
        
        commit;
	
end$$

delimiter ;