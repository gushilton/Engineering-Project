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

        $clkInQuery = "INSERT INTO TimeAndAttendance.timesheet (TimeOut,CompanyID,Year,Month,TimeIn) VALUES (null,".$companyID['CompanyID'].",".$header->{'Year'}.",".$header->{'Month'}.",'".$header->{'timeIn'}."')";
        $clkInResult = mysqli_query($dbCon,$clkInQuery);

        $inQ = "SELECT * FROM TimeAndAttendance.timesheet WHERE CompanyID = ANY (SELECT CompanyID FROM personnel.OnBoard WHERE UserName ='".$username."') ORDER BY Year DESC,Month DESC,EntryNumber DESC LIMIT 1";
        $inResult = mysqli_query($dbCon,$inQ);
        $inRow = mysqli_fetch_assoc($inResult);

        $response = array("status"=>"success","ClockedStatus"=>$clkInResult,"timesheet"=>$inRow);
     }
     echo json_encode($response);
  }
?>
