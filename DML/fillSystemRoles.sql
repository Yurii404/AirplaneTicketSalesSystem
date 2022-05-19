use booking_system;

call uspParsingAddSystemRoles('{
  "systemRoles":
    {
      "name" : "Administrator"
    }
}');
call uspParsingAddSystemRoles('{
  "systemRoles":
    {
      "name" : "Client"
    }
}');