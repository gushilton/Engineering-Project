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
            $query = "SELECT * FROM Operations.MaintenanceTasks WHERE Complete = 0 ".$header->{'order'};
            $result = mysqli_query($dbCon,$query);
            $rows = array();
            while($row = mysqli_fetch_assoc($result)){
                $query = "SELECT Rank From personnel.CrewRoles WHERE RoleID = ".$row['AssignedTo'];
                $disciplineResult = mysqli_query($dbCon,$query);
                $discipline = mysqli_fetch_assoc($disciplineResult);
                $row = array_merge($row,$discipline);
                array_push($rows,$row);
            }
            $response = array("status"=>"success","workOrders"=>$rows);
        }
        echo json_encode($response);

 }
?>
