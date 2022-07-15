<?php
ALTER USER 'user-name'@'localhost' IDENTIFIED BY 'NEW_USER_PASSWORD';
FLUSH PRIVILEGES;
UPDATE mysql.user SET authentication_string = PASSWORD('NEW_USER_PASSWORD')
WHERE User = 'user-name' AND Host = 'localhost';
FLUSH PRIVILEGES;



?>