<?php

    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
        $dbCon = mysqli_connect('localhost',$username,$password);
        $response;
        if (!$dbCon){
            $response = array("dbStatus"=>"failed","reason"=>mysqli_connect_error());
        }
        else{
            $uQuery = "SELECT * FROM personnel.OnBoard WHERE UserName = '".$header->{'username'} ."'";
            $uResult = mysqli_query($dbCon,$uQuery);
            while ($uRow = mysqli_fetch_assoc($uResult)){
              $rQuery = "SELECT * FROM personnel.CrewRoles WHERE RoleID =".$uRow['RoleID'];
              $rResult = mysqli_query($dbCon,$rQuery);
              while ($rRow = mysqli_fetch_assoc($rResult)){
                $userInfo = array("empID"=>$uRow['CompanyID'],"fName"=>$uRow['FirstName'],"lName"=>$uRow['LastName'],"department"=>$rRow['Department'],"rank"=>$rRow['Rank']);
              }
            }
            $response = array("dbStatus"=>"success","userInfo"=>$userInfo);
         }
        echo json_encode($response);
    }
?>
