
call uspAddForeignKey('parking', 'fk_parking_airport_id', 'airport_id', 'airport', 'airport_id');
call uspAddCompositeOfTwoAlterKey('parking', 'ak_parking_code_and_airport_id', 'code', 'airport_id');