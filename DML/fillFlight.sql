use booking_system;

call uspParsingCreateFlight('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD222"
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
    "flightTime": "24:00:55"
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
    "flightTime": "24:00:55"
  }
}');

call uspParsingCreateFlight('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD000"
  },
  "arrivalAirport": {
    "code": "LVL"
  },
  "departureAirport": {
    "code": "PRS"
  },
  "flight": {
    "number": "3333",
    "dateTimeArrival": "2021-10-04 12:15:01",
    "dateTimeDeparture": "2021-10-03 12:15:04",
    "flightTime": "24:00:55"
  }
}');

call uspParsingCreateFlight('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD444"
  },
  "arrivalAirport": {
    "code": "PRS"
  },
  "departureAirport": {
    "code": "LVL"
  },
  "flight": {
    "number": "4444",
    "dateTimeArrival": "2021-10-05 12:15:01",
    "dateTimeDeparture": "2021-10-02 12:15:04",
    "flightTime": "24:00:55"
  }
}');

call uspParsingCreateFlight('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD222"
  },
  "arrivalAirport": {
    "code": "KYV"
  },
  "departureAirport": {
    "code": "PRS"
  },
  "flight": {
    "number": "5555",
    "dateTimeArrival": "2022-12-09 12:10:01",
    "dateTimeDeparture": "2022-08-09 12:15:04",
    "flightTime": "24:00:55"
  }
}');

call uspParsingCreateFlight('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD000"
  },
  "arrivalAirport": {
    "code": "PRS"
  },
  "departureAirport": {
    "code": "KYV"
  },
  "flight": {
    "number": "7777",
    "dateTimeArrival": "2022-12-16 12:11:01",
    "dateTimeDeparture": "2022-12-15 03:10:04",
    "flightTime": "01:12:55"
  }
}');