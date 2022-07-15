<?php

     if ($_SERVER['REQUEST_METHOD'] == "POST"){
         $header = file_get_contents('php://input');
         $header =  json_decode($header);
         $info = parse_ini_file("/var/forgotPassword.ini",false,INI_SCANNER_NORMAL);
         $user = $info['username'];
         $pswd = $info['password'];
         $dbCon = mysqli_connect('localhost',$user,$pswd);
         $response;
         if (!$dbCon){
            $response = array("dbStatus"=>"Failed");
         }else{
            $query = "";
            if ($header->{'method'}=="username"){
                $query = "SELECT User,host from mysql.user WHERE User = '".$header->{'username'}."' LIMIT 1";
            }else if($header->{'method'}=="companyID"){
                $query = "SELECT User,host from mysql.user WHERE User = ANY(SELECT UserName FROM personnel.OnAndHistory WHERE CompanyID = ".$header->{'username'}." LIMIT 1) LIMIT 1";
            }
            $result = mysql_query($dbCon,$query);
            $row = mysqli_fetch_assoc($result);
            if (mysqli_num_rows($result)==0){
             $response = array("dbStatus"=>"success","message"=>"username not found");
            }else{
             $response = array("dbStatus"=>"success"=>"username found","username"=>$row['User']);
            }
         }
         echo json_encode($response);
     }
?>
