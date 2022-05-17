use booking_system;

drop table if exists seat_classes;

create table seat_classes(
	class_id    int          not null auto_increment,
	`name`      varchar(20)  not null,
   	
    constraint pk_seat_classes_class_id primary key (class_id)
);