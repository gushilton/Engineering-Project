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
        $query = "SELECT Rank FROM personnel.CrewRoles WHERE RoleID = ANY(SELECT RoleID FROM personnel.OnBoard WHERE UserName = '".$username."' )";
        $rank = mysqli_query($dbCon,$query);


        $todayQuery = "SELECT * FROM Operations.MaintenanceTasks WHERE Date_Due <= '".$header->{'todayDate'}."' AND Complete = 0 AND AssignedTo = ANY(SELECT RoleID FROM personnel.OnBoard WHERE UserName = '".$username."' )";
        $todayResult = mysqli_query($dbCon,$todayQuery);
        $todayRows = array();
        while($row = mysqli_fetch_assoc($todayResult)){
            $q = "SELECT Rank From personnel.CrewRoles WHERE RoleID = ".$row['AssignedTo'];
            $disciplineResult = mysqli_query($dbCon,$q);
            $discipline = mysqli_fetch_assoc($disciplineResult);
            $row = array_merge($row,$discipline);
            array_push($todayRows,$row);
        }

        $weekQuery = "SELECT * FROM Operations.MaintenanceTasks WHERE Date_Due <= '".$header->{'weekDate'}."' AND Date_Due > '".$header->{'todayDate'}."' AND Complete = 0";
        $weekResult = mysqli_query($dbCon,$weekQuery);
        $weekRows = array();
        while($row = mysqli_fetch_assoc($weekResult)){
            $q = "SELECT Rank From personnel.CrewRoles WHERE RoleID = ".$row['AssignedTo'];
            $disciplineResult = mysqli_query($dbCon,$q);
            $discipline = mysqli_fetch_assoc($disciplineResult);
            $row = array_merge($row,$discipline);
            array_push($weekRows,$row);
        }

        $response = array("status"=>"success","result"=>array("todayJobInfo"=>$todayRows,"weekJobInfo"=>$weekRows));
     }

     echo json_encode($response);

  }

?>