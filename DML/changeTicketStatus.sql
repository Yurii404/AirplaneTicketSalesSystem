use booking_system;

call uspParsingChangeTicketStatus('{
  "users": {
    "login": "Admin"
  },
  "ticket": {
    "number": "4"
  },
  "newData": {
    "newStatus": "paid"
  }
}');

call uspParsingChangeTicketStatus('{
  "users": {
    "login": "Admin"
  },
  "ticket": {
    "number": "3"
  },
  "newData": {
    "newStatus": "paid"
  }
}');


call uspParsingChangeTicketStatus('{
  "users": {
    "login": "Admin"
  },
  "ticket": {
    "number": "1"
  },
  "newData": {
    "newStatus": "paid"
  }
}');


call uspParsingChangeTicketStatus('{
  "users": {
    "login": "Admin"
  },
  "ticket": {
    "number": "2"
  },
  "newData": {
    "newStatus": "paid"
  }
}');


call uspParsingChangeTicketStatus('{
  "users": {
    "login": "Admin"
  },
  "ticket": {
    "number": "6"
  },
  "newData": {
    "newStatus": "paid"
  }
}');

call uspParsingChangeTicketStatus('{
  "users": {
    "login": "Admin"
  },
  "ticket": {
    "number": "12"
  },
  "newData": {
    "newStatus": "paid"
  }
}');