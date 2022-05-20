use booking_system;

call uspParsingAddAirplane('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD222",
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

call uspParsingAddAirplane('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD000",
    "name": "Block",
    "numOfSeats": "100",
    "maxWeightOfLuggage": "110",
    "maxWeightOfCarryOn": "110",
    "priceOfLuggage": "35"
  }
}');

call uspParsingAddAirplane('{
  "users": {
    "login": "Admin"
  },
  "airplane": {
    "code": "BD444",
    "name": "Mini",
    "numOfSeats": "5",
    "maxWeightOfLuggage": "0",
    "maxWeightOfCarryOn": "0",
    "priceOfLuggage": "0"
  }
}');