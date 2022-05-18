call uspParsingAddSystemRoles('{
  "ticketStatuses": {
  	"name": "free"
  }
}');

call uspParsingAddTicketStatuses('{
  "ticketStatuses": {
  	"name": "free"
  }
}');

call uspParsingAddSeatStatuses('{
  "seatStatuses": {
  	"name": "booked"
  }
}');

call uspParsingAddCities('{
  "cities": {
  	"name": "Novovolunsk"
  }
}');

call uspParsingAddCountries('{
  "countries": {
  	"name": "Ukraine"
  }
}');

call uspParsingAddUsers('{
 "users": {
    "fullName": "Test1",
    "login": "Test1",
    "email": "test1@test.ua",
    "phoneNumber": "+380731111111",
    "hashOfPassport": "rjdtkm343"
  }
}');

call uspParsingAddAirport('{
 "airport": {
    "code": "LVS",
    "name": "Grand Lviv",
    "city": "Novovolunsk",
    "country": "Ukraine",
    "numOfTerminals": "4"
  }
}');