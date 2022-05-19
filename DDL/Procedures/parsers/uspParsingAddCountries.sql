use booking_system;

drop procedure if exists uspParsingAddCountries;
 
delimiter $$

create procedure uspParsingAddCountries(in addCountriesJson json)
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
		select new_countries.`name`
		from json_table(addCountriesJson, '$."countries"' columns (
					`name`		varchar(25)		path '$.name'
				)
             ) as new_countries;
        
        insert into countries (`name`)
		select tempJson.`name`
		from tempJson;
        
end$$

delimiter ;