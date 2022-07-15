 <?php
     if ($_SERVER['REQUEST_METHOD'] == "POST"){
         $header = file_get_contents('php://input');
         $header =  json_decode($header);
         $username = $header->{'username'};
         $password = $header->{'password'};
         $dbCon = mysqli_connect('localhost',$username,$password);
         $response="";
         if (!$dbCon){
             $response = array("status"=>"failed","reason"=>mysqli_connect_error());
         }
         else{
            $roleQuery = "SELECT RoleID FROM personnel.OnBoard WHERE UserName = '".$username."'";
            $rank = mysqli_query($dbCon,$roleQuery);
            $rank = mysqli_fetch_assoc($rank);
            $workStatus;
            $workOrder = "INSERT INTO Operations.MaintenanceTasks
            (Job_Name,AssignedTo,routineDuty,descriptionProblem,descriptionAction,hierachy,functionID,ComponentShort,ComponentNumber,Date_Created,Date_Due)
            VALUES
            ('".$header->{'jobName'}."',".$rank['RoleID'].",0,'".$header->{'problem'}."','".$header->{'action'}."','".$header->{'heirachy'}."','".$header->{'function'}."','".$header->{'componentShort'}."','".$header->{'componentNumber'}."','".$header->{'dateCreated'}."','".$header->{'dateDue'}."')";
            $result = mysqli_query($dbCon,$workOrder);
            if($result){
                $workStatus = "success";
            }else{
                $workStatus = "failed";
            }

            $response = array("status"=>"success","reason"=>$workStatus);

         }
         echo json_encode($response);
     }
 ?>