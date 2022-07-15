<?php
 if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
        $dbCon = mysqli_connect('localhost',$username,$password);
        $response;
        if (!$dbCon){
            $response = array("status"=>"failed","reason"=>mysqli_connect_error());
        }
        else{
            $query = "SELECT * FROM Operations.MaintenanceTasks WHERE yearID=".$header->['yearID']." AND JobID = ".$header->['JobID'];
            $result = mysqli_query($dbCon,$query);
            $row = mysqli_fetch_assoc($result);-
            $q = "SELECT Rank From personnel.CrewRoles WHERE RoleID = ".$row['AssignedTo'];
            $disciplineResult = mysqli_query($dbCon,$q);
            $discipline = mysqli_fetch_assoc($disciplineResult);
            $row = array_merge($row,$discipline);
            if ($row["Complete"] == 1){
                $byQuery = "SELECT FirstName,LastName FROM personnel.OnAndHistory WHERE CompanyID = ".$row['completeBy'];
                $byResult = mysqli_query($dbCon,$byQuery);
                $by = mysqli_fetch_assoc($byResult);
                $row = array_merge($row,$by);
            }
            if($row['routineDuty'] == 1){
                $query = "SELECT frequency,details FROM Opertaions.routineJobs WHERE Department_Short = '".$row['Department_Short']."' AND number = ".$row['number']." AND heirachy = '".$row['hierachy']."' AND functionID = ".$row['functionID'];
                $routine = mysqli_fetch_assoc(mysqli_query($dbCon,$query));
                $row = array_merge($row,$routine);
            }
            $response = array("status"=>"success","workOrders"=>$row);
        }
        echo json_encode($response);
 }
?>