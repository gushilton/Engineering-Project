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
        $q = "SELECT * FROM TimeAndAttendance.timesheet WHERE CompanyID = ANY (SELECT CompanyID FROM personnel.OnBoard WHERE UserName ='".$username."') AND TimeIn BETWEEN '".$header->{'week'}."' AND '".$header->{'today'}."'";
$rows=array();
$r = mysqli_query($dbCon,$q);
while($timesheet = mysqli_fetch_assoc($r)){
array_push($rows,$timesheet);
}
        $inQ = "SELECT * FROM TimeAndAttendance.timesheet WHERE CompanyID = ANY (SELECT CompanyID FROM personnel.OnBoard WHERE UserName ='".$username."') ORDER BY Year DESC,Month DESC,EntryNumber DESC LIMIT 1";
        $inResult = mysqli_query($dbCon,$inQ);
        $inRow = mysqli_fetch_assoc($inResult);
$t = mysqli_fetch_assoc(mysqli_query($dbCon,$inQ));
        if ($inRow['TimeOut'] == null){
            $q1 = "Clocked In";
        }else{
            $q1 = "Clocked Out";
        }
        $response = array("status"=>"success","ClockedStatus"=>$q1,"currentStatus"=>$t,"timesheet"=>$rows);
     }
     echo json_encode($response);
  }
?>
