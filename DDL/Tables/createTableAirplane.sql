use booking_system;

drop table if exists airplane;

create table airplane(
	airplane_id              int           not null auto_increment,
	`code`                   varchar(10)   not null,
    `name`                   varchar(20)   not null,
    num_of_seats             int           not null,
    max_weight_of_luggage    int,
    max_weight_of_carry_on   int,
    price_of_luggage         int,
   	
    constraint pk_airplane_airplane_id primary key (airplane_id)
);