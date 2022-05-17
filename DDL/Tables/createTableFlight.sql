use booking_system;

drop table if exists flight;

create table flight(
	flight_id              int      not null auto_increment,
	`number`               int      not null,
    airplane_id            int      not null,
    datetime_departure     datetime not null,
    departure_airport_id   int      not null,
    datetime_arrival       datetime not null,
    arrival_airport_id     int      not null,
    flight_time            time     not null,
   	
    constraint pk_flight_flight_id primary key (flight_id)
);