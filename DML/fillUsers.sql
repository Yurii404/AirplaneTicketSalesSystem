use booking_system;

call uspParsingAddUsers('{
  "guest": {
    "ip": "111.111.111.110",
    "dateTimeOfStart": "2021-08-08 11:11:21"
  },
  "users": {
    "fullName": "Admin",
    "login": "Admin",
    "email": "admin@test.ua",
    "phoneNumber": "+380731111111",
    "hashOfPassport": "rjdtkm343",
    "role" : "Administrator",
    "dateTimeRegistration": "2021-08-05 12:15:01",
    "dateTimeLastVisit": "2021-08-08 12:15:01"
  }
}');

call uspParsingAddUsers('{
  "guest": {
    "ip": "111.111.111.113",
    "dateTimeOfStart": "2021-08-08 11:12:21"
  },
  "users": {
    "fullName": "Client",
    "login": "Client",
    "email": "clent@test.ua",
    "phoneNumber": "+380731111111",
    "hashOfPassport": "rjdtkm343",
    "role" : "Client",
    "dateTimeRegistration": "2021-08-05 12:15:01",
    "dateTimeLastVisit": "2021-08-08 12:15:01"
  }
}');

call uspParsingAddUsers('{
  "guest": {
    "ip": "111.111.111.112",
    "dateTimeOfStart": "2021-08-08 11:12:21"
  },
  "users": {
    "fullName": "Oleg",
    "login": "Oleg22",
    "email": "oleg@test.ua",
    "phoneNumber": "+380731211111",
    "hashOfPassport": "rjdtkm343",
    "role" : "Client",
    "dateTimeRegistration": "2021-08-05 12:15:01",
    "dateTimeLastVisit": "2021-08-08 12:15:01"
  }
}');