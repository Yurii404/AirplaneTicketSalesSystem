use booking_system;

drop table if exists ticket_statuses;

create table ticket_statuses(
	status_id   int            not null auto_increment,
	`name`      varchar(20)    not null,
   	
    constraint pk_ticket_statuses_status_id primary key (status_id)
);