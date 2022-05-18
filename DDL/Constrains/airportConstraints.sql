use booking_system;

call uspAddAlterKey('airport', 'ak_airport_code', 'code');
call uspAddForeignKey('airport', 'fk_airport_city_id', 'city_id', 'cities', 'city_id');
call uspAddForeignKey('airport', 'fk_airport_country_id', 'country_id', 'countries', 'country_id');