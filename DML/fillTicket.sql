use booking_system;

call uspParsingCreateTicket('{
  "users": {
    "login": "Admin"
  },
  "flight": {
    "number": "2222"
  },
  "seat": {
    "number": "2"
  },
  "ticket": {
    "number": "1",
    "price": "1000",
    "status" : "free",
    "dateTimeLastEdit": "2021-08-04 12:10:10"
  }
}');

call uspParsingCreateTicket('{
  "users": {
    "login": "Admin"
  },
  "flight": {
    "number": "1111"
  },
  "seat": {
    "number": "1"
  },
  "ticket": {
    "number": "2",
    "price": "1000",
    "status" : "free",
    "dateTimeLastEdit": "2021-08-04 12:15:10"
  }
}');
