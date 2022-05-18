use booking_system;

drop procedure if exists uspAddAlterKey;

delimiter $$

create procedure uspAddAlterKey(in tableName varchar(100),
								in constraintName varchar(100),
								in columnsNames varchar(250))
begin
	if exists(
            select constraint_name
            from   information_schema.table_constraints
            where  constraint_schema = database()		 and
				   table_name = tableName                and
                   constraint_name = constraintName      and
                   constraint_type='UNIQUE')
    then
		set @query = 'alter table `{tableName}`
                            drop index {constraintName};';

        set @query = replace(@query, '{tableName}', tableName);
        set @query = replace(@query, '{constraintName}', constraintName);
        
        prepare stmt from @query;
        execute stmt;
        deallocate prepare stmt;
    end if;

    set @query = 'alter table `{tableName}`
                            add constraint {constraintName} 
                            unique key ({columnsNames});';

        set @query = replace(@query, '{tableName}', tableName);
        set @query = replace(@query, '{constraintName}', constraintName);
        set @query = replace(@query, '{columnsNames}', columnsNames);
        
        prepare stmt from @query;
        execute stmt;
        deallocate prepare stmt;
end$$
delimiter ;