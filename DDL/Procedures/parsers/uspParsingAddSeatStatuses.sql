use booking_system;

drop procedure if exists uspParsingAddSeatStatuses;
 
delimiter $$

create procedure uspParsingAddSeatStatuses(in addSeatStatusesJson json)
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
		select new_seat_statuses.`name`
		from json_table(addSeatStatusesJson, '$."seatStatuses"' columns (
					`name`		varchar(25)		path '$.name'
				)
             ) as new_seat_statuses;
        
        insert into seat_statuses (`name`)
		select tempJson.`name`
		from tempJson;
        
end$$

delimiter ;