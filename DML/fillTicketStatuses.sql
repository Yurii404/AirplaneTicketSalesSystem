use booking_system;

call uspParsingAddTicketStatuses('{
  "ticketStatuses": {
  	"name": "free"
  }
}');

call uspParsingAddTicketStatuses('{
  "ticketStatuses": {
  	"name": "booked"
  }
}');

call uspParsingAddTicketStatuses('{
  "ticketStatuses": {
  	"name": "paid"
  }
}');