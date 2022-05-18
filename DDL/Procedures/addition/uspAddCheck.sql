use booking_system;

drop procedure if exists uspAddCheck;

delimiter $$

create procedure uspAddCheck(in tableName 		varchar(50),
							 in constraintName  varchar(80),
							 in expression		varchar(100))
begin
	if exists(
				select constraint_name
				from   information_schema.table_constraints
				where  constraint_schema = database()		 and
				       table_name 		 = tableName         and
                       constraint_name   = constraintName    and
                       constraint_type   = 'CHECK'
			 )
    then
		set @query = 'alter table `{tableName}`
                      drop check {constraintName};';

        set @query = replace(@query, '{tableName}', tableName);
        set @query = replace(@query, '{constraintName}', constraintName);
        
        prepare stmt from @query;
        execute stmt;
        deallocate prepare stmt;
    end if;

    set @query = 'alter table `{tableName}`
				  add constraint {constraintName} 
                  check ({expression});';

	set @query = replace(@query, '{tableName}',      tableName);
	set @query = replace(@query, '{constraintName}', constraintName);
	set @query = replace(@query, '{expression}',     expression);
        
	prepare stmt from @query;
	execute stmt;
	deallocate prepare stmt;
end$$

delimiter ;