use booking_system;

call uspParsingViewFlight('{
  "users": {
    "login": "Admin"
  },
  "filter": {
    "fromDateTimeDeparture": "2020-12-10 00:00:00",
    "departureCities": ["Kiev", "Lviv"],
    "arrivalCity": "Paris"
  }
}');