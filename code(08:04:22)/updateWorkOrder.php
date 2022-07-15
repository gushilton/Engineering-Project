<?php
    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
        $dbCon = mysqli_connect('localhost',$username,$password);
        $response="";
        if (!$dbCon){
            $response = array("status"=>"failed","reason"=>mysqli_connect_error());
        }
        else{
            $query = "UPDATE Operations.MaintenanceTasks SET Date_Complete = '".$header->{'Date'}."',Complete = 1, completeBy = ANY(SELECT CompanyID FROM personnel.OnAndHistory WHERE UserName = '".$username."' )  WHERE yearID = ".$header->{'workOrder'}->{'yearID'}." AND JobID = ".$header->{'workOrder'}->{'JobID'};
                if($header->{'workOrder'}->{'routine'}){
                    $routineQuery = "SELECT frequency FROM Operations.routineJobs WHERE Department_Short = '".$header->{'workOrder'}->{'Department_short'}."' AND number =".$header->{'workOrder'}->{'Routine_number'}." AND heirachy ='".$header->{'workOrder'}->{'hierachy'}."' AND functionID = ".$header->{'workOrder'}->{'functionID'}."  Limit 1";
                    $frequency = mysqli_fetch_assoc(mysqli_query($dbCon,$routineQuery));
                    $createdDate = $header->{'Date'};
                    $dueDate = date_add($createdDate,date_interval_create_from_date_string($frequency." days"));
                    $insertQuery = "INSERT INTO Operations.MaintenanceTasks
                    (yearID,   Job_Name,                AssignedTo,   routineDuty,Department_short,Routine_number,hierachy,  functionID,  ComponentShort  ,ComponentNumber,   Date_Created,  Date_Due,    Date_Complete )
                    VALUES
                    (22, '".$header->{'workOrder'}->{'Job_Name'}."',".$header->{'workOrder'}->{'AssignedTo'}.",1,'".$header->{'workOrder'}->{'Department_short'}."' ,".$header->{'workOrder'}->{'Routine_number'}.",'".$header->{'workOrder'}->{'hierachy'}."',".$header->{'workOrder'}->{'functionID'}.",'".$header->{'workOrder'}->{'ComponentShort'}."', ".$header->{'workOrder'}->{'ComponentNumber'}.", '".$header->{'Date'}."', '".$dueDate."'  , null          )";
                }
            $response = array("status"=>"success","reason"=>$insertQuery);

        }
        echo json_encode($response);
    }

?>