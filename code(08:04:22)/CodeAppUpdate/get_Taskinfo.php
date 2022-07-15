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
            $result = mysli_query($dbCon,$query);
            $row = mysqli_fetch_assoc($result);
            $response = "{\"Job_ID\":\"".$row['Job_ID']."\",\"Maintenance_ID\":\"".$row['Maintenance_ID']."\",\"Job_Name\":\"".$row['Job_Task']."\",\"AssignedTo\":\"".$row['Assigned_To']."\",\"Set_Date\":\"".$row['Date_Set']."\", \"Due Date\":\"".$row['Date_Due']."\", \"Complete Date\":\"".$row['Date_Complete']."\"";
            if ($row['Complete'] == 0){
                $response = $response.", \"Complete\":\"false\"}";
            }else{
                $response = $response.", \"Complete\":\"true\"}";
            }
            echo "{\"task\":".$response."}";
        }
    }
?>
