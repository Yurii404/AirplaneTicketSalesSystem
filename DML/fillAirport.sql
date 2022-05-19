use booking_system;

call uspParsingAddAirport('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "KYV",
    "name": "Grand KYV",
    "city": "Kiev",
    "country": "Ukraine",
    "numOfTerminals": "4"
  }
}');

call uspParsingAddAirport('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "LVL",
    "name": "Grand LVIV",
    "city": "Lviv",
    "country": "Ukraine",
    "numOfTerminals": "4"
  }
}');