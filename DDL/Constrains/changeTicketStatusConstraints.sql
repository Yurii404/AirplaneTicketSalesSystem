use booking_system;

call uspAddForeignKey('change_ticket_status', 'fk_change_ticket_status_user_id', 'user_id', 'users', 'user_id');
call uspAddForeignKey('change_ticket_status', 'fk_change_ticket_status_ticket_id', 'ticket_id', 'ticket', 'ticket_id');
call uspAddForeignKey('change_ticket_status', 'fk_change_ticket_status_new_status_id', 'new_status_id', 'ticket_statuses', 'status_id');
call uspAddForeignKey('change_ticket_status', 'fk_change_ticket_status_old_status_id', 'old_status_id', 'ticket_statuses', 'status_id');