$info = parse_ini_file("/var/forgotPassword.ini",false,INI_SCANNER_NORMAL);
$user = $info['username'];
$pswd = $info['password'];
echo $user;
echo $pswd;
echo "\n";