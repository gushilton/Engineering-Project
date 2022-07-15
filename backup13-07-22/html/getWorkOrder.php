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
            $wquery = "SELECT * FROM Operations.MaintenanceTasks WHERE yearID = ".$header->{'yearID'}." AND JobID = ".$header->{'JobID'};
            $result = mysqli_query($dbCon,$wquery);
            $row = mysqli_fetch_assoc($result);
            $query = "SELECT Rank From personnel.CrewRoles WHERE RoleID = ".$row['AssignedTo'];
            $disciplineResult = mysqli_query($dbCon,$query);
            $discipline = mysqli_fetch_assoc($disciplineResult);
            $row = array_merge($row,$discipline);
            if ($row["Complete"] == 1){
                $byQuery = "SELECT FirstName,LastName FROM personnel.OnAndHistory WHERE CompanyID = ".$row['completeBy'];
                $byResult = mysqli_query($dbCon,$byQuery);
                $by = mysqli_fetch_assoc($byResult);
                $row = array_merge($row,$by);
            }

         if ($row['routineDuty'] == 1){
            $fquery = "SELECT frequency,details FROM Operations.routineJobs WHERE Department_Short = '".$row['Department_short']."' AND number = ".$row['Routine_number']." AND heirachy = '".$row['hierachy']."' AND functionID = ".$row['functionID'];
            $routine = mysqli_query($dbCon,$fquery);
       	    $routineResult = mysqli_fetch_assoc($routine);
            $row = array_merge($row,$routineResult);
	}else{
	   $row['frequency'] = "NA";
	   $row['details'] = "Problem: ".$row['descriptionProblem']."\nAction:".$row['descriptionAction'];
	}

	    $query = "SELECT * FROM Operations.TaskNotes WHERE YearID = ".$header->{'yearID'}." AND JobID = ".$header->{'JobID'};
	    $result = mysqli_query($dbCon,$query);
            $noteRows = array();
            while($rows = mysqli_fetch_assoc($result)){
                array_push($noteRows,$rows);
            }
           $response = array("status"=>"success","workOrders"=>$row,"taskNotes"=>$noteRows);
	}
        echo json_encode($response);
 }
?>
