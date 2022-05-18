use booking_system;

drop procedure if exists uspParsingAddAirport;
 
delimiter $$

create procedure uspParsingAddAirport(in addAirportJson json)
begin

		drop table if exists tempJson;
		create temporary table tempJson
		(
        -- describe table columns
	
        `code` varchar(3) ,
		`name` varchar(20) ,
		city varchar(20) ,
		country varchar(20) ,
		num_of_terminals tinyint
        
		);

		insert into tempJson(
						`code`,`name`, city, country ,num_of_terminals
					)
		select new_airport.`code`, new_airport.`name`, new_airport.city,
				new_airport.country, new_airport.num_of_terminals
		from json_table(addAirportJson, '$."airport"' columns (
                    `code` varchar(3)        path '$.code',
					`name` varchar(20)       path '$.name',
					num_of_terminals tinyint path '$.numOfTerminals',
                    city varchar(20)		 path '$.city',
					country varchar(20)	 	 path '$.country'
				)
             ) as new_airport;
        
        insert into airport (`code`,`name`, city_id, country_id ,num_of_terminals )
		select tempJson.`code`, tempJson.`name`, cities.city_id, countries.country_id , tempJson.num_of_terminals
		from tempJson
        inner join cities ON cities.`name` = tempJson.city
        inner join countries ON countries.`name` = tempJson.country;
        
end$$

delimiter ;