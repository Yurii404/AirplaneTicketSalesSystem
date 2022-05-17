use booking_system;

drop table if exists change_ticket_status;

create table change_ticket_status(
	ticket_id        int            not null,
	user_id          int            not null,
	datetime_change  datetime       not null,
	old_status_id    int            not null,
	new_status_id    int            not null,
   	
    constraint pk_change_ticket_status primary key (ticket_id, user_id, datetime_change)
);