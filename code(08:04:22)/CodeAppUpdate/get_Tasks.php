<?php
    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $username = $header->{'username'};
        $password = $header->{'password'};
        $sqlServerCon = mysqli_connect('localhost',$username,$password);
        
        if (!$sqlServerCon){
            $response = array("status"=>"failed","reason"=>mysqli_connect_error());
            
        }
        else{
            $queryTasks = "SELECT * from maintenance.tasks WHERE Date_Due BETWEEN ".$header->{'filters'}->{'Date'}->{'dateDue'}->{'from'}." AND ".$header->{'filters'}->{'Date'}->{'dateDue'}->{'to'};
            if($header->{'filters'}->{'Date'}->{'dateSet'}->{'filter'} == "true"){
                 $queryTasks = $queryTasks." AND Date_Set BETWEEN ".$header->{'filters'}->{'Date'}->{'dateSet'}->{'from'}." AND ".$header->{'filters'}->{'Date'}->{'dateSet'}->{'to'};
            }
            if($header->{'filters'}->{'Date'}->{'dateComplete'}->{'filter'} == "true"){
                $queryTasks = $queryTasks." AND Date_Complete BETWEEN ".$header->{'filters'}->{'Date'}->{'dateComplete'}->{'from'}." AND ".$header->{'filters'}->{'Date'}->{'dateComplete'}->{'to'};
            }
            if ($header->{'filters'}->{'complete'}=="true"){
                $queryTasks = $queryTasks." AND Complete=0";
            }
            if ($header->{'filters'}->{'AssignedMe'}=="true"){
                $queryRole = "SELECT RoleID FROM personnel.OnBoard WHERE UserName = '".$username."'";
                $resultRole = mysqli_query($sqlServerCon,$queryRole);
                $rowRole;
                if (mysqli_num_rows($resultRole)){
                    $rowRole = mysqli_fetch_assoc($resultRole);
                }
                $queryTasks = $queryTasks." AND AssignedTo='".$rowRole['RoleID']."'";
            }
            
            $queryTasks = $queryTasks." ORDER BY ".$header->{"sort"}->{"sortby"}." ".$header->{"sort"}->{"orderby"};
            
            $result = mysqli_query($sqlServerCon,$queryTasks);
            if (mysqli_num_rows($result)){
                $tasks = array()
                while (($rowResult = mysqli_fetch_assoc($result))){
                    $row = array("jobID"=>rowResult['Job_ID'],"maintenanceID"=>rowResult['Maintenance_ID'],"setDate"=>rowResult['Date_Set'],"dueDate"=>rowResult['Date_Due'],"completeDate"=>rowResult['Date_Complete'],"complete"=>boolReturn(rowResult['Job_ID']));  // create an associate array for the row
                    array_push($tasks,$row);// add row array to the resp
                       //"Job_Name\":\"".$row['Job_Task']
                }
                $response = array("status"=>"success","tasks"=>$tasks);
            }
        }
        echo json_encode($response);
    }

function roleQuery(){
    $queryRoleInfo = "SELECT DEPARTMENT,RANK FROM personnel.CrewRoles WHERE RoleID=".$rowRole['RoleID'];
    $resultRoleInfo = mysqli_query($sqlServerCon,$queryRoleInfo);
    $rowRoleInfo;
    if (mysqli_num_rows($resultRoleInfo)){
        $rowRoleInfo = mysqli_fetch_assoc($resultRoleInfo);
    }
    return $rowRoleInfo['Department']." ".$rowRoleInfo['Rank'];
}

function boolReturn($result){
    if ($result == 1){
        return "true";
    }else{
        return "false";
    }
}
?>
