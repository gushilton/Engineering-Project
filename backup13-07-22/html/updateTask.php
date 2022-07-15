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
             $rInsert = "";
             $rUpdate = "";
$insertQuery="";

	     if($header->{"update"}->{"addNote"}==true){
	     	$insertTaskNote="INSERT INTO Operations.TaskNotes (YearID,JobID,DateTime,Note) VALUES (".$header->{'workOrder'}->{'yearID'}.",".$header->{'workOrder'}->{'JobID'}.",'".$header->{'datetime'}."','".$header->{'note'}."')";
	     	$r = mysqli_query($dbCon,$insertTaskNote);
	     }
	     if($header->{"update"}->{"complete"}==true){
             $updateQuery = "UPDATE Operations.MaintenanceTasks SET Date_Complete = '".$header->{'Date'}."',Complete = 1,completeBy = (SELECT CompanyID FROM personnel.OnBoard WHERE UserName = '".$username."' )  WHERE yearID = ".$header->{'workOrder'}->{'yearID'}." AND JobID = ".$header->{'workOrder'}->{'JobID'};
	     $rUpdate = mysqli_query($dbCon,$updateQuery);
	      
             if($header->{'workOrder'}->{'routineDuty'}=="1"){
                $routineQuery = "SELECT frequency FROM Operations.routineJobs WHERE Department_Short = '".$header->{'workOrder'}->{'Department_short'}."' AND number =".$header->{'workOrder'}->{'Routine_number'}."  AND heirachy ='".$header->{'workOrder'}->{'hierachy'}."' AND functionID = ".$header->{'workOrder'}->{'functionID'}." Limit 1";
                $freq = mysqli_query($dbCon,$routineQuery);
 		        $frequency = mysqli_fetch_assoc($freq);
                $createdDate = strtotime($header->{'Date'});
                $dueDate = date('Y-m-d',mktime(0,0,0,date('m',$createdDate),date('d',$createdDate)+$frequency['frequency'],date('Y',$createdDate)));
                $insertQuery = "INSERT INTO Operations.MaintenanceTasks (Job_Name,AssignedTo,routineDuty,Department_short,Routine_number,hierachy,functionID,ComponentShort,ComponentNumber,yearID,Date_Created,Date_Due) SELECT Job_Name,AssignedTo,routineDuty,Department_short,Routine_number,hierachy,functionID,ComponentShort,ComponentNumber, ".date('y',$createdDate)." AS yearID,'".$header->{'Date'}."' AS Date_Created, '".$dueDate."' AS Date_Due FROM  Operations.MaintenanceTasks WHERE yearID = ".$header->{'workOrder'}->{'yearID'}." AND JobID = ".$header->{'workOrder'}->{'JobID'};
                $rInsert = mysqli_query($dbCon,$insertQuery);
             }
}

             $response = array("status"=>"success","update"=>$rUpdate,"INSERT"=>$rInsert,"ta"=>$r);

         }
         echo json_encode($response);
     }

 ?>
