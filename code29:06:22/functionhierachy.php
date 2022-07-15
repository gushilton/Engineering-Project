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
          $div2Rows = array();
          $div3Rows = array();
          $queryDiv2 = "SELECT * FROM Operations.Function_Hierachy WHERE Division2 !='' AND Division3='' AND Division1='".$row['Division1']."'";
          $resDiv2 = mysqli_query($dbCon,$queryDiv2);
          while($rowDiv2 = mysqli_fetch_assoc($resDiv2)){
            $queryDiv3 = "SELECT * FROM Operations.Function_Hierachy WHERE Division3 != '' AND Division2 = '".$row['Division2']."' AND Division1 = '".$row['Division1']."'";
            $resDiv3 = mysqli_query($dbCon,$queryDiv3);
            $division3 = array();
            while($rowDiv3 = mysqli_fetch_assoc($resDiv3)){
                array_push($division3,$resDiv3);
            }
            array_push($div2Rows,$rowDiv2);
            array_push($div3Rows,$division3);
          }
          array_push($div1,$row);
          array_push($div2,$div2Rows);
          array_push($div3,$div3Rows);
        }
        $response = array("status"=>"success","results"=>array("Division1"=>$div1,"Division2"=>$div2,"Division3"=>$div3));
     }
     echo json_encode($response);
  }
?>