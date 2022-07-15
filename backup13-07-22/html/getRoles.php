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
            $query = "SELECT * FROM personnel.CrewRoles";
            $result = mysqli_query($dbCon,$query);
            $rows = array();
            while($row = mysqli_fetch_assoc($result)){
                array_push($rows,$row);
            }
            $response = array("status"=>"success","crewRoles"=>$rows);
        }
        echo json_encode($response);
 }
?>
