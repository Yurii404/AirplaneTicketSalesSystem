use booking_system;

drop table if exists countries;

create table countries(
	country_id     int            not null auto_increment,
	`name`         varchar(20)    not null,
   	
    constraint pk_countries_country_id primary key (country_id)
);