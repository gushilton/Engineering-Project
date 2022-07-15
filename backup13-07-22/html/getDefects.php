<?php
  if ($_SERVER['REQUEST_METHOD'] == "POST"){
     $header = file_get_contents('php://input');
     $header =  json_decode($header);
     $username = $header->{'username'};
     $password = $header->{'password'};
     $dbCon = mysqli_connect('localhost',$username,$password);
     $response;
     if (!$dbCon){
        $response = array("status"=>"failed","reason"=>mysqli_connect_error($dbCon));
     }else{
        $query = "SELECT * FROM Defects.Defects WHERE department LIKE '".$header->{'department'}."'";
        $results = mysqli_query($dbCon,$query);
        $defectRows = array();
        while($row = mysqli_fetch_assoc($results)){
            array_push($defectRows,$row);
        }

        $response = array("status"=>"success","defects"=>$defectRows);
     }

     echo json_encode($response);

  }

?>
