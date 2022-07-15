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
            $componentQuery = "SELECT * FROM Operations.Components WHERE heirachy = '".$header->{'heirachy'}."' AND function = ".$header->{'function'};
            $workQuery = "SELECT * FROM Operations.MaintenanceTasks WHERE Complete = 0 AND heirachy = '".$header->{'heirachy'}."' AND function = ".$header->{'function'};
            $historyQuery = "SELECT * FROM Operations.MaintenanceTasks WHERE Complete = 1 AND heirachy = '".$header->{'heirachy'}."' AND function = ".$header->{'function'};
            $componentResult = mysqli_fetch_assoc(mysqli_query($dbCon,$componentQuery));
            $workRows = array();
            $historyRows = array();
            while ($row = mysqli_fetch_assoc(mysqli_query($dbCon,$componentQuery))){
                array_push($workRows,$row);
            }
            while ($row = mysqli_fetch_assoc(mysqli_query($dbCon,$historyQuery))){
                $query = "SELECT Rank From personnel.CrewRoles WHERE RoleID = ".$row['AssignedTo'];
                $disciplineResult = mysqli_query($dbCon,$query);
                $discipline = mysqli_fetch_assoc($disciplineResult);
                $row = array_merge($row,$discipline);
                array_push($historyRows,$row);
            }
            $response = array("status"=>"success","result"=>array("component"=>$componentResult,"workOrders"=>$workRows,"history"=>$historyRows));
         }
         echo json_encode($response);
      }
?>