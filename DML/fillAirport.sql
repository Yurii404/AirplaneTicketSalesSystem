use booking_system;

call uspParsingAddAirport('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "KYV",
    "name": "Grand Kiev",
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
    "numOfTerminals": "7"
  }
}');

call uspParsingAddAirport('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "PRS",
    "name": "Grand Paris",
    "city": "Paris",
    "country": "France",
    "numOfTerminals": "2"
  }
}');

call uspParsingAddAirport('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "LND",
    "name": "Grand Kingdom",
    "city": "London",
    "country": "United Kingdom",
    "numOfTerminals": "3"
  }
}');