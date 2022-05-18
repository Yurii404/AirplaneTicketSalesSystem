use booking_system;

drop procedure if exists uspAddDefault;

delimiter $$

create procedure uspAddDefault(in tableName 		varchar(50),
                               in columnName        varchar(80),
							   in `value`	     	varchar(100))
begin
	if exists(
				select constraint_name
				from   information_schema.table_constraints
				where  constraint_schema = database()		 and
				       table_name 		 = tableName         and
                       constraint_type   = 'DEFAULT'
			 )
    then
		set @query = 'alter table `{tableName}`
                      alter {columnName} drop default;';

        set @query = replace(@query, '{tableName}', tableName);
        set @query = replace(@query, '{columnName}', constraintName);
        
        prepare stmt from @query;
        execute stmt;
        deallocate prepare stmt;
    end if;

    set @query = 'ALTER TABLE {tableName}
					ALTER {columnName} SET DEFAULT {value};';

	set @query = replace(@query, '{tableName}',      tableName);
	set @query = replace(@query, '{value}',     `value`);
	set @query = replace(@query, '{columnName}',     columnName);
        
	prepare stmt from @query;
	execute stmt;
	deallocate prepare stmt;
end$$

delimiter ;