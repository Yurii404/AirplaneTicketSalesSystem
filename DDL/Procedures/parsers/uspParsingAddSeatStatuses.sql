use booking_system;

drop procedure if exists uspParsingAddSeatStatuses;
 
delimiter $$

create procedure uspParsingAddSeatStatuses(in addSeatStatusesJson json)
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