use booking_system;

drop table if exists system_roles;

create table system_roles(
	role_id     int            not null auto_increment,
	`name`      varchar(20)    not null,
   	
    constraint pk_system_roles_role_id primary key (role_id)
);