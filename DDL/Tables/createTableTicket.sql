use booking_system;

drop table if exists ticket;

create table ticket(
	ticket_id              int          not null auto_increment,
	`number`               int          not null,
    full_name              varchar(40),
    weight_of_luggage      int,
    weight_of_carry_on     int,
    num_of_parking_places  int,
    seat_id                int          not null,
    flight_id              int          not null,
    price                  int          not null,
    status_id              int          not null,
    datetime_last_edit     datetime     not null,
    creator_id             int          not null,
   	
    constraint pk_ticket_ticket_id primary key (ticket_id)
);