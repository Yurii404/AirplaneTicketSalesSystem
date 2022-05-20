use booking_system;

call uspParsingDeleteAirport('{
  "users": {
    "login": "Admin"
  },
  "airport":{
    "code" : "SSS"
  }
}');