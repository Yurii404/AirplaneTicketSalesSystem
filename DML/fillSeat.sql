use booking_system;

call uspParsingAddSeat('{
  "users": {
    "login": "Admin"
  },
  "seat": {
    "number": "2",
    "status": "free",
    "price": "20",
    "class": "low"
  },
  "airplane": {
    "code": "BD220"
  }
}');

call uspParsingAddSeat('{
  "users": {
    "login": "Admin"
  },
  "seat": {
    "number": "1",
    "status": "free",
    "price": "20",
    "class": "low"
  },
  "airplane": {
    "code": "BD111"
  }
}');