<?php
    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
        $dbCon = mysqli_connect('localhost',$username,$password);
        if (!$dbCon){
            echo "{\"status\":\"db con failed\"}";
        }
        else{
            $first = 0;
            $response = "";
                $query = "Select * from maintenance.tasks";
            $result = mysqli_query($dbCon,$query);
            if (mysqli_num_rows($result)){
                while (($row = mysqli_fetch_assoc($result))){
                    if ($first == 0){
                        $first = 1;

                        $response = "{\"Job_ID\":\"".$row['Job_ID']."\",\"Maintenance_ID\":\"".$row['Maintenance_ID']."\",\"Job_Name\":\"".$row['Job_Task']."\",\"AssignedTo\":\"".$row['Assigned_To']."\",\"Set_Date\":\"".$row['Date_Set']."\", \"Due_Date\":\"".$row['Date_Due']."\", \"Complete_Date\":\"".$row['Date_Complete']."\"";
                        if ($row['Complete'] == 0){
                            $response = $response.", \"Complete\":\"false\"}";
                        }else{
                            $response = $response.", \"Complete\":\"true\"}";
                        }

                    }else{
                       $response = $response.",{\"Job_ID\":\"".$row['Job_ID']."\",\"Maintenance_ID\":\"".$row['Maintenance_ID']."\",\"Job_Name\":\"".$row['Job_Task']."\",\"AssignedTo\":\"".$row['Assigned_To']."\",\"Set_Date\":\"".$row['Date_Set']."\", \"Due_Date\":\"".$row['Date_Due']."\", \"Complete_Date\":\"".$row['Date_Complete']."\"";
                           if ($row['Complete'] == 0){
                               $response = $response.", \"Complete\":\"false\"}";
                           }else{
                               $response = $response.", \"Complete\":\"true\"}";
                           }
                    }
                }
            }

//echo "{\"status\":\"".$response."\"}";
            echo "{\"tasks\":[".$response."]}";
        }
    }
?>


