use booking_system;

call uspParsingAddParking('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "LVL"
  },
  "parking": {
    "code": "1",
    "name": "Public",
    "price": "20",
    "numOfPlaces": "150"
  }
}');

call uspParsingAddParking('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "LVL"
  },
  "parking": {
    "code": "2",
    "name": "Private",
    "price": "40",
    "numOfPlaces": "10"
  }
}');

call uspParsingAddParking('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "KYV"
  },
  "parking": {
    "code": "3",
    "name": "Private",
    "price": "40",
    "numOfPlaces": "10"
  }
}');

call uspParsingAddParking('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "PRS"
  },
  "parking": {
    "code": "4",
    "name": "Private",
    "price": "40",
    "numOfPlaces": "10"
  }
}');

call uspParsingAddParking('{
  "users": {
    "login": "Admin"
  },
  "airport": {
    "code": "LND"
  },
  "parking": {
    "code": "4",
    "name": "Private",
    "price": "40",
    "numOfPlaces": "10"
  }
}');