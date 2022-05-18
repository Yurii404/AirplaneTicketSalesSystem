use booking_system;

call uspAddForeignKey('parking', 'fk_parking_airport_id', 'airport_id', 'airport', 'airport_id');
call uspAddAlterKey('parking', 'ak_parking_code_and_airport_id', 'code, airport_id');
call uspAddCheck('parking', 'check_parking_price', 'price > 0');