use booking_system;

call uspParsingAddSeatClasses('{
  "seatClasses":
    {
      "name" : "low"
    }
}');

call uspParsingAddSeatClasses('{
  "seatClasses":
    {
      "name" : "high"
    }
}');

