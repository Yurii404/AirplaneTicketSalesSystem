use booking_system;

call uspParsingAddSeatStatuses('{
  "seatStatuses": {
  	"name": "free"
  }
}');

call uspParsingAddSeatStatuses('{
  "seatStatuses": {
  	"name": "booked"
  }
}');