use booking_system;

drop procedure if exists uspParsingAddSeatClasses;
 
delimiter $$

create procedure uspParsingAddSeatClasses(in addSeatClassesJson json)
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
		select new_seat_classes.`name`
		from json_table(addSeatClassesJson, '$."seatClasses"' columns (
					`name`		varchar(25)		path '$.name'
				)
             ) as new_seat_classes;
        
        insert into seat_classes (`name`)
		select tempJson.`name`
		from tempJson;
        
end$$

delimiter ;