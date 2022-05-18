use booking_system;

drop procedure if exists uspParsingAddCountries;
 
delimiter $$

create procedure uspParsingAddCountries(in addCountriesJson json)
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