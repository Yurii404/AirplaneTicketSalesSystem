use booking_system;

call uspAddAlterKey('users', 'ak_user_login', 'login');
call uspAddAlterKey('users', 'ak_user_email', 'email');
call uspAddForeignKey('users', 'fk_user_role_id', 'role_id', 'system_roles', 'role_id');
