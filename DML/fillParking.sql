use booking_system;

call uspParsingAddParking('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "LVL"
  },
  "parking": {
    "code": "2",
    "name": "Cummon",
    "price": "25",
    "numOfPlaces": "150"
  }
}');

call uspParsingAddParking('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "LVL"
  },
  "parking": {
    "code": "1",
    "name": "Cummon",
    "price": "40",
    "numOfPlaces": "10"
  }
}');