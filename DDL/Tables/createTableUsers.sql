use booking_system;

drop table if exists users;

create table users(
	user_id 		        int           not null auto_increment,
    full_name               varchar(30)   not null,   
    login                   varchar(20)   not null unique,
    hash_of_password        varchar(16)   not null,
    phone_number            varchar(25),
    email			        varchar(40)   unique,
    role_id			        int			  not null,
    datetime_registration   datetime      not null,
    datetime_last_visit     datetime      not null,
   	
    constraint pk_users_user_id primary key (user_id)
);