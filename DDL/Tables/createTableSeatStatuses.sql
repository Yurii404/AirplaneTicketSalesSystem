use booking_system;

drop table if exists seat_statuses;

create table seat_statuses(
	status_id   tinyint      not null auto_increment,
	`name`      varchar(20)  not null,
   	
    constraint pk_seat_statuses_status_id primary key (status_id)
);