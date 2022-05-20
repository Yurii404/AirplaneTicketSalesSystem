use booking_system;

call uspParsingBuyTicket('{
  "users": {
    "login": "Client"
  },
  "ticket": {
    "number": "1"
  },
  "user_info": {
    "fullName": "Test test",
    "weightOfLuggage": "2",
    "weightOfCarryOn": "1",
    "numOfParkingPlaces": "1"
  }
}');

call uspParsingBuyTicket('{
  "users": {
    "login": "Client"
  },
  "ticket": {
    "number": "2"
  },
  "user_info": {
    "fullName": "Test3",
    "weightOfLuggage": "2",
    "weightOfCarryOn": "1",
    "numOfParkingPlaces": "1"
  }
}');

call uspParsingBuyTicket('{
  "users": {
    "login": "Client"
  },
  "ticket": {
    "number": "3"
  },
  "user_info": {
    "fullName": "Test2",
    "weightOfLuggage": "2",
    "weightOfCarryOn": "1",
    "numOfParkingPlaces": "1"
  }
}');

call uspParsingBuyTicket('{
  "users": {
    "login": "Client"
  },
  "ticket": {
    "number": "4"
  },
  "user_info": {
    "fullName": "Test4",
    "weightOfLuggage": "2",
    "weightOfCarryOn": "1",
    "numOfParkingPlaces": "1"
  }
}');


call uspParsingBuyTicket('{
  "users": {
    "login": "Oleg22"
  },
  "ticket": {
    "number": "5"
  },
  "user_info": {
    "fullName": "Test5",
    "weightOfLuggage": "2",
    "weightOfCarryOn": "1",
    "numOfParkingPlaces": "1"
  }
}');

call uspParsingBuyTicket('{
  "users": {
    "login": "Oleg22"
  },
  "ticket": {
    "number": "6"
  },
  "user_info": {
    "fullName": "Test6",
    "weightOfLuggage": "2",
    "weightOfCarryOn": "1",
    "numOfParkingPlaces": "1"
  }
}');

call uspParsingBuyTicket('{
  "users": {
    "login": "Oleg22"
  },
  "ticket": {
    "number": "12"
  },
  "user_info": {
    "fullName": "Test7",
    "weightOfLuggage": "2",
    "weightOfCarryOn": "1",
    "numOfParkingPlaces": "1"
  }
}');