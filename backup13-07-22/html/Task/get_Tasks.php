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
            $first = 0;
            $response = "";
            $query = "";
            if (($header->{'filters'}->{'date'}->{'filter'}=="true") || ($header->{'filters'}->{'complete'}=="true") || ($header->{'filters'}->{'AssignedMe'}=="true")){
                $query = "SELECT * from maintenance.tasks WHERE";
                if (($header->{'filters'}->{'date'}->{'filter'}=="true")){
                    $query = $query." Date_Set BETWEEN '".$header->{'filters'}->{'date'}->{'from'}."' AND '".$header->{'filters'}->{'date'}->{'to'}."'";
                }
                if (($header->{'filters'}->{'complete'}=="true") && ($header->{'filters'}->{'date'}->{'filter'}=="true")){
                    $query = $query." AND Complete=0";
                }else if (($header->{'filters'}->{'complete'}=="true") && !($header->{'filters'}->{'date'}->{'filter'}=="true")){
                    $query = $query." Complete=0";
                }
                if (($header->{'filters'}->{'AssignedMe'}=="true") && (($header->{'filters'}->{'complete'}=="true") || ($header->{'filters'}->{'date'}->{'filter'}=="true"))){
                    $query = $query." AND Assigned_To='".$username."'";
                }
                else if (($header->{'filters'}->{'AssignedMe'}=="true") && !($header->{'filters'}->{'complete'}=="true") && !($header->{'filters'}->{'date'}->{'filter'}=="true")){
                    $query = $query." Assigned_To='".$username."'";
                }
            }else{
                $query = "Select * from maintenance.tasks";
            }
            $query = $query." ORDER BY ".$header->{"sort"}->{"sortby"}." ".$header->{"sort"}->{"orderby"};;

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
            echo "{\"tasks\":[".$response."]}";
        }
    }
?>


