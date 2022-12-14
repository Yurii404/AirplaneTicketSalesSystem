use booking_system;

drop procedure if exists uspParsingAddSystemRoles;
 
delimiter $$

create procedure uspParsingAddSystemRoles(in addSystemRolesJson json)
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
		select new_system_roles.`name`
		from json_table(addSystemRolesJson, '$."systemRoles"' columns (
					`name`		varchar(25)		path '$.name'
				)
             ) as new_system_roles;
        
        insert into system_roles (`name`)
		select tempJson.`name`
		from tempJson;
        
end$$

delimiter ;