use booking_system;

drop procedure if exists uspParsingBuyTicket;
 
delimiter $$

create procedure uspParsingBuyTicket(in buyTicketJson json)
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
        ticket_number					int,
        user_info_full_name				varchar(40),
        user_info_weight_of_luggage		int,
        user_info_weight_of_carry_on	int,
        user_info_num_of_parking_places	int
        
		);

		insert into tempJson(user_login ,
							ticket_number,
							user_info_full_name,
							user_info_weight_of_luggage,
							user_info_weight_of_carry_on,
							user_info_num_of_parking_places
					)
		select 	new_ticket.user_login ,
							new_ticket.ticket_number,
							new_ticket.user_info_full_name,
							new_ticket.user_info_weight_of_luggage,
							new_ticket.user_info_weight_of_carry_on,
							new_ticket.user_info_num_of_parking_places
							 
		from json_table(buyTicketJson, '$' columns (
					user_login 							varchar(20)		path '$.users.login',
					ticket_number						int				path '$.ticket.number',
					user_info_full_name					varchar(40)		path '$.user_info.fullName',
					user_info_weight_of_luggage			int				path '$.user_info.weightOfLuggage',
					user_info_weight_of_carry_on		int				path '$.user_info.weightOfCarryOn',
					user_info_num_of_parking_places		int				path '$.user_info.numOfParkingPlaces'
				)
             ) as new_ticket;
        
        start transaction;
        
       
        -- update ticket
        update ticket
        inner join tempJson on tempJson.ticket_number = ticket.`number`
        inner join ticket_statuses on ticket_statuses.`name` = "booked"
        set full_name = tempJson.user_info_full_name,
			weight_of_luggage = tempJson.user_info_weight_of_luggage,
            weight_of_carry_on = tempJson.user_info_weight_of_carry_on,
            num_of_parking_places = tempJson.user_info_num_of_parking_places,
            ticket.status_id = ticket_statuses.status_id;
	
        commit;
	
end$$

delimiter ;