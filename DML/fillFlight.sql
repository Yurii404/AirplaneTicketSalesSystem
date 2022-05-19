use booking_system;

call uspParsingCreateFlight('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD220"
  },
  "arrivalAirport": {
    "code": "KYV"
  },
  "departureAirport": {
    "code": "LVL"
  },
  "flight": {
    "number": "1111",
    "dateTimeArrival": "2021-08-04 12:10:01",
    "dateTimeDeparture": "2021-08-03 12:15:04",
    "flightTime": "180"
  }
}');

call uspParsingCreateFlight('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD111"
  },
  "arrivalAirport": {
    "code": "LVL"
  },
  "departureAirport": {
    "code": "KYV"
  },
  "flight": {
    "number": "2222",
    "dateTimeArrival": "2021-08-04 12:15:01",
    "dateTimeDeparture": "2021-08-03 12:15:04",
    "flightTime": "655"
  }
}');