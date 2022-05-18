use booking_system;

drop table if exists seat;

create table seat(
	seat_id        int   not null auto_increment,
	`number`       int   not null,
    airplane_id    int   not null,
    class_id       tinyint,
    status_id      tinyint   not null,
    price          int,
   	
    constraint pk_seat_seat_id primary key (seat_id)
);