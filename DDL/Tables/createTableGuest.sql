use booking_system;

drop table if exists guest;

create table guest(
	guest_id 		  int               not null auto_increment,
    ip                varchar(20)   	not null,   
    datetime_of_start datetime          not null,
   	
    constraint pk_guest_guest_id primary key (guest_id)
);