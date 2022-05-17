use booking_system;

drop table if exists cities;

create table cities(
	city_id     int            not null auto_increment,
	`name`      varchar(20)    not null,
   	
    constraint pk_cities_city_id primary key (city_id)
);