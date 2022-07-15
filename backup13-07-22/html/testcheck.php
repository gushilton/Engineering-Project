<?php
    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
 	echo "{\"status\":\"user: ".$username."\"}";
     }else{
	echo "{\"status\":\"post unsuccess\"}";
}
?>
