use booking_system;

call uspParsingAnalytic('{
   "cities":["Paris", "Lviv"],
   "airplanes":["Mini", "Test"],
   "periodStartDate":"2020-01-01 00:00:00",
   "periodEndDate":"2022-12-30 00:00:00",
   "showNullRows":true,
   "showNullCols":true
}');