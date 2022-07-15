<?php
  if ($_SERVER['REQUEST_METHOD'] == "POST"){
     $header = file_get_contents('php://input');
     $header =  json_decode($header);
     $username = $header->{'username'};
     $password = $header->{'password'};
     $dbCon = mysqli_connect('localhost',$username,$password);
     $response;
     $clkStatus;

     if(!$dbCon){
        $response = array("status"=>"failed","reason"=>mysqli_connect_error($dbCon));
     }else{
        $queryID = "SELECT CompanyID FROM personnel.OnBoard WHERE UserName ='".$username."'";
        $companyID = mysqli_fetch_assoc(mysqli_query($dbCon,$queryID));

        $clkOutQuery = "UPDATE TimeAndAttendance.timesheet SET TimeOut = '".$header->{'TimeOut'}."' WHERE Year = ".$header->{"timesheet"}->{'Year'}." AND Month = ".$header->{'timesheet'}->{'month'}." AND EntryNumber = ".$header->{'timesheet'}->{'EntryNumber'};

        $clkOutResult = mysqli_query($dbCon,$clkOutQuery);

        $response = array("status"=>"success","ClockedStatus"=>$clkOutResult);
     }
     echo json_encode($response);
  }
?>