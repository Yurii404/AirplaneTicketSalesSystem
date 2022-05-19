use booking_system;

call uspParsingAddAirplane('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD220",
    "name": "Mriya",
    "numOfSeats": "50",
    "maxWeightOfLuggage": "15",
    "maxWeightOfCarryOn": "5",
    "priceOfLuggage": "150"
  }
}');

call uspParsingAddAirplane('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD111",
    "name": "Star",
    "numOfSeats": "20",
    "maxWeightOfLuggage": "0",
    "maxWeightOfCarryOn": "0",
    "priceOfLuggage": "0"
  }
}');