<?php
$info = parse_ini_file("/var/forgotPassword.ini",false,INI_SCANNER_NORMAL);
$user = $info['username'];
$pswd = $info['password'];
echo $user;
echo "\n";
echo $pswd;
echo "\n";


?>
