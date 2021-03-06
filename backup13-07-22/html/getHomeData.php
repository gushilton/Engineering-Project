<?php
  if ($_SERVER['REQUEST_METHOD'] == "POST"){
     $header = file_get_contents('php://input');
     $header =  json_decode($header);
     $username = $header->{'username'};
     $password = $header->{'password'};
     $dbCon = mysqli_connect('localhost',$username,$password);
     $response;
     if (!$dbCon){
        $response = array("status"=>"failed","reason"=>mysqli_connect_error($dbCon));
     }else{
	$clockedStatus;
        $todayQuery = "SELECT * FROM Operations.MaintenanceTasks WHERE Date_Due <= '".$header->{'todayDate'}."' AND Complete = 0 AND AssignedTo = ANY(SELECT RoleID FROM personnel.OnBoard WHERE UserName = '".$username."' ) ORDER BY Date_Due ASC";
        $todayResult = mysqli_query($dbCon,$todayQuery);
        $todayRows = array();
        while($row = mysqli_fetch_assoc($todayResult)){
            $q = "SELECT Rank FROM personnel.CrewRoles WHERE RoleID = ".$row['AssignedTo'];
            $disciplineResult = mysqli_query($dbCon,$q);
            $discipline = mysqli_fetch_assoc($disciplineResult);
            $row = array_merge($row,$discipline);
            array_push($todayRows,$row);
        }
        $weekQuery = "SELECT * FROM Operations.MaintenanceTasks WHERE Date_Due <= '".$header->{'weekDate'}."' AND Date_Due > '".$header->{'todayDate'}."' AND Complete = 0 AND AssignedTo = ANY(SELECT RoleID FROM personnel.OnBoard WHERE UserName = '".$username."' ) ORDER BY Date_Due ASC";
        $weekResult = mysqli_query($dbCon,$weekQuery);
        $weekRows = array();
        while($rowWeek = mysqli_fetch_assoc($weekResult)){
            $qry = "SELECT Rank FROM personnel.CrewRoles WHERE RoleID = ".$rowWeek['AssignedTo'];
            $disciplineResult = mysqli_query($dbCon,$qry);
            $discipline = mysqli_fetch_assoc($disciplineResult);
            $rowWeek = array_merge($rowWeek,$discipline);
            array_push($weekRows,$rowWeek);
        }
	$inQ = "SELECT * FROM TimeAndAttendance.timesheet WHERE CompanyID = ANY (SELECT CompanyID FROM personnel.OnBoard WHERE UserName ='".$username."') ORDER BY Year DESC,Month DESC,EntryNumber DESC LIMIT 1";
        $inResult = mysqli_query($dbCon,$inQ);
        $inRow = mysqli_fetch_assoc($inResult);
        if ($inRow['TimeOut'] == null){
           $clockedStatus = "Clocked In";
        }else{
           $clockedStatus = "Clocked Out";
        }

        $response = array("status"=>"success","result"=>array("todayJobInfo"=>$todayRows,"weekJobInfo"=>$weekRows,"ckStatus"=>$clockedStatus,"timesheetInfo"=>$inRow));
     }
 
     echo json_encode($response);

  }
?>
