use booking_system;

drop table if exists airport;

create table airport(
	airport_id     int            not null auto_increment,
	`code`         varchar(3)   not null,
	`name`         varchar(20)    not null,
    city_id        int            not null,
    country_id     int            not null,
    num_of_terminals     int,
   	
    constraint pk_airport_airport_id primary key (airport_id)
);