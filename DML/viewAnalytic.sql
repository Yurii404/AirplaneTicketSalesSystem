use booking_system;

call uspParsingAnalytic('{
   "cities":["Paris", "Lviv"],
   "airplanes":["Mriya", "Star", "Mini"],
   "periodStartDate":"2020-01-01 00:00:00",
   "periodEndDate":"2022-12-30 00:00:00",
   "showNullRows":false,
   "showNullCols":true
}');