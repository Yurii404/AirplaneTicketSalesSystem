call uspAddAlterKey('ticket', 'ak_ticket_number', 'number');
call uspAddForeignKey('ticket', 'fk_ticket_seat_id', 'seat_id', 'seat', 'seat_id');
call uspAddForeignKey('ticket', 'fk_ticket_flight_id', 'flight_id', 'flight', 'flight_id');
call uspAddForeignKey('ticket', 'fk_ticket_status_id', 'status_id', 'ticket_statuses', 'status_id');
call uspAddForeignKey('ticket', 'fk_ticket_creator_id', 'creator_id', 'users', 'user_id');