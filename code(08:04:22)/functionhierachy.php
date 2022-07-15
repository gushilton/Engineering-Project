<?php
  if ($_SERVER['REQUEST_METHOD'] == "POST"){
     $header = file_get_contents('php://input');
     $header =  json_decode($header);
     $username = $header->{'username'};
     $password = $header->{'password'};
     $dbCon = mysqli_connect('localhost',$username,$password);
     $response;
     $div1 = array();
     $div2 = array();
     $div3 = array();

     if(!$dbCon){
        $response = array("status"=>"failed","reason"=>mysqli_connect_error($dbCon));
     }else{
        $query = "SELECT * FROM Operations.Function_Hierachy WHERE Division2=''";
        $result = mysqli_query($dbCon,$query);
        $query = array();
        while($row = mysqli_fetch_assoc($result)){
          $r = array("Name"=>$row['Divinsion_Name'],"Division"=>$row['Division1']);
          array_push($div1,$r);
          $q = "SELECT * FROM Operations.Function_Hierachy WHERE Division2 !='' AND Division3='' AND Division1='".$row['Division1']."'";
          array_push($query,$q);
        }

        for ($i =0; $i<count($query);$i++){
            $queryj = array();
            $result = mysqli_query($dbCon,$query[$i]);
            $qRow = array();
            while($row = mysqli_fetch_assoc($result)){
                $r = array("Name"=>$row['Divinsion_Name'],"Division"=>$row['Division2']);
                array_push($qRow,$r);
                $q = "SELECT * FROM Operations.Function_Hierachy WHERE Division3 != '' AND Division2 = '".$row['Division2']."' AND Division1 = '".$row['Division1']."'";
                array_push($queryj,$q);
            }
            array_push($div2,$qRow);
            $div3S = array();

            for ($j =0; $j<count($queryj);$j++){
               $resultj = mysqli_query($dbCon,$queryj[$j]);
               $qRowj = array();
                  while(]$rowj = mysqli_fetch_assoc($resultj);){
                    $rj = array("Name"=>$rowj['Divinsion_Name'],"Division"=>$rowj['Division3']);
                    array_push($qRowj,$rj);

                  }


               array_push($div3S,$qRowj);
            }
            array_push($div3,$div3S);
        }
        $response = array("status"=>"success","results"=>array("Division1"=>$div1,"Division2"=>$div2,"Division3"=>$div3));
     }
     echo json_encode($response);
  }
?>