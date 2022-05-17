use booking_system;

drop table if exists parking;

create table parking(
	parking_id     int            not null auto_increment,
	`code`         int            not null,
	`name`         varchar(20)    not null,
    airport_id     int            not null,
    price          int            not null,
    num_of_places  int            not null,
   	
    constraint pk_parking_parking_id primary key (parking_id)
);