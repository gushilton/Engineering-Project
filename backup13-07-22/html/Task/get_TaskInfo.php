<?php
    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
        $dbCon = mysqli_connect('localhost',$username,$password);
        if (!$dbCon){
            echo "failed: ".mysqli_connect_error();
        }
        else{
            $jobID = $header->{"Job_ID"};
            $query = "SELECT * FROM maintenance.tasks WHERE Job_ID = '".$jobID."'";
            $result = mysqli_query($dbCon,$query);
            $row = mysqli_fetch_assoc($result);
            $response = "{\"Job_ID\":\"".$row['Job_ID']."\",\"Maintenance_ID\":\"".$row['Maintenance_ID']."\",\"Job_Name\":\"".$row['Job_Task']."\",\"AssignedTo\":\"".$row['Assigned_To']."\",\"Date_Set\":\"".$row['Date_Set']."\", \"Date_Due\":\"".$row['Date_Due']."\", \"Date_Complete\":\"".$row['Date_Complete']."\"";
            if ($row['Complete'] == 0){
                $response = $response.", \"Complete\":\"false\"}";
            }else{
                $response = $response.", \"Complete\":\"true\"}";
            }
            echo "{\"task\":".$response."}";
        }
    }
?>

