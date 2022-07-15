<?php
  if ($_SERVER['REQUEST_METHOD'] == "POST"){
     $header = file_get_contents('php://input');
     $header =  json_decode($header);
     $username = $header->{'username'};
     $password = $header->{'password'};
     $dbCon = mysqli_connect('localhost',$username,$password);
     $response;

     if(!$dbCon){
        $response = array("status"=>"failed","reason"=>mysqli_connect_error($dbCon));
     }else{
         $query = "SELECT * FROM CrewBar.orderHistory WHERE companyID = ANY(SELECT CompanyID FROM personnel.OnBoard WHERE UserName = '".$username."' )";

     }
  }
?>