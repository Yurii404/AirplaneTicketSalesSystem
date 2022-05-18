use booking_system;

drop procedure if exists uspParsingAddTicketStatuses;
 
delimiter $$

create procedure uspParsingAddTicketStatuses(in addTicketStatusJson json)
begin

		drop table if exists tempJson;
		create temporary table tempJson
		(
        -- describe table columns
        `name`		varchar(25)
		);

		insert into tempJson(
						`name`
					)
		select new_ticket_statuses.`name`
		from json_table(addTicketStatusJson, '$."ticketStatuses"' columns (
					`name`		varchar(25)		path '$.name'
				)
             ) as new_ticket_statuses;
        
        insert into ticket_statuses (`name`)
		select tempJson.`name`
		from tempJson;
        
end$$

delimiter ;