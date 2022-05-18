use booking_system;

call uspAddForeignKey('seat', 'fk_parking_airplane_id', 'airplane_id', 'airplane', 'airplane_id');
call uspAddForeignKey('seat', 'fk_parking_class_id', 'class_id', 'seat_classes', 'class_id');
call uspAddForeignKey('seat', 'fk_parking_status_id', 'status_id', 'seat_statuses', 'status_id');
call uspAddAlterKey('seat', 'ak_seat_number_and_airplane_id', 'number, airplane_id');
call uspAddCheck('seat', 'check_seat_price', 'price > 0');