call uspAddForeignKey('seat', 'fk_parking_airplane_id', 'airplane_id', 'airplane', 'airplane_id');
call uspAddForeignKey('seat', 'fk_parking_class_id', 'class_id', 'seat_classes', 'class_id');
call uspAddForeignKey('seat', 'fk_parking_status_id', 'status_id', 'seat_statuses', 'status_id');
call uspAddCompositeOfTwoAlterKey('seat', 'ak_seat_number_and_airplane_id', 'number', 'airplane_id');