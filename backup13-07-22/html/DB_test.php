<?php
    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
        $dbCon = mysqli_connect('localhost',$username,$password);
        if (!$dbCon){
            echo "{\"status\":\"Username or Password wrong\"}";
        }
        else{
            echo "{\"status\":\"logged in\"}";
        }
    }
?>
