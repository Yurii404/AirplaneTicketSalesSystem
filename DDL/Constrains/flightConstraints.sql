call uspAddAlterKey('flight', 'ak_flight_number', 'number');
call uspAddForeignKey('flight', 'fk_flight_airplane_id', 'airplane_id', 'airplane', 'airplane_id');
call uspAddForeignKey('flight', 'fk_flight_departure_airport_id', 'departure_airport_id', 'airport', 'airport_id');
call uspAddForeignKey('flight', 'fk_flight_arrival_airport_id', 'arrival_airport_id', 'airport', 'airport_id');