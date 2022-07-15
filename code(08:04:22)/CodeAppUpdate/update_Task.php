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
            $Job_ID = $header->{'Job_ID'};
            $todayDate = date("Y-m-d");
            $query = "UPDATE maintenance.tasks SET COMPLETE = 1, Date_Complete = '".$todayDate."' WHERE Job_ID = '".$Job_ID."'";
            $status = mysqli_query($dbCon, $query);
            if ($status){
                echo "record updated";
            }else{
                echo "update failed".mysqli_error($dbCon);
            }
        }
    }
?>

