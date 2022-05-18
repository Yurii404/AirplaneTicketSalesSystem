use booking_system;

drop procedure if exists uspAddForeignKey;

delimiter $$

create procedure uspAddForeignKey(in tableName varchar(100),
								  in constraintName varchar(100),
								  in columnName varchar(250),
                                  in refTableName varchar(100),
                                  in refColumnName varchar(250))
begin
	if exists(
            select * from information_schema.table_constraints
            where
                    constraint_schema = database()      and
                    table_name        = tableName       and
                    constraint_name   = constraintName	and
                    constraint_type   = 'FOREIGN KEY')
    then
		set @query = 'alter table `{tableName}`
                            drop foreign key {constraintName};';

        set @query = replace(@query, '{tableName}', tableName);
        set @query = replace(@query, '{constraintName}', constraintName);


        prepare stmt from @query;
        execute stmt;
        deallocate prepare stmt;
    end if;

    set @query = 'alter table `{tableName}`
                            add constraint {constraintName} 
                            foreign key ({columnName}) references `{refTableName}` ({refColumnName});';

        set @query = replace(@query, '{tableName}', tableName);
        set @query = replace(@query, '{constraintName}', constraintName);
        set @query = replace(@query, '{columnName}', columnName);
        set @query = replace(@query, '{refTableName}', refTableName);
        set @query = replace(@query, '{refColumnName}', refColumnName);
        
        prepare stmt from @query;
        execute stmt;
        deallocate prepare stmt;
end$$
delimiter ;