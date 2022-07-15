<?php
    if($_SERVER['REQUEST_METHOD'] == "POST"){
        $header = file_get_contents('php://input');
        $header =  json_decode($header);
        $dbCon = mysqli_connect('localhost','angus','IhgadcM£3');
        if (!$dbCon){
            echo "failed: ".mysqli_connect_error();
        }
        else{
         $query = "CREATE USER '".$header->{'user'}."'@'localhost'  IDENTIFIED BY '".$header->{'user'}."'";
          if (mysqli_query($dbCon,$query)){
            if(mysqli_query($dbCon,"GRANT ALL PRIVILEGES on *.* to '".$header->{'user'}."'@'localhost' WITH GRANT OPTION")){
                if(mysqli_query($dbCon,"FLUSH PRIVILEGES")){
$addquery = "INSERT INTO personnel.OnBoard (CompanyID,RoleID,UserName,FirstName,LastName,EmbarkedDate,DisembarkDate) VALUES (".(int)$header->{'empID'}.",".(int)$header->{'roleID'}.",'".$header->{'user'}."','".$header->{'fName'}."','".$header->{'lName'}."','".$header->{'embDate'}."','".$header->{'disDate'}."')";
$addHisquery = "INSERT INTO personnel.OnAndHistory (CompanyID,UserName,FirstName,LastName) VALUES (".(int)$header->{'empID'}.",'".$header->{'user'}."','".$header->{'fName'}."','".$header->{'lName'}."')";
                                      mysqli_query($dbCon,$addHisquery);
                  if (mysqli_query($dbCon,$addquery)){
                    echo "person added";
                  }else{
		    echo "User not added : ".mysqli_error($dbCon);

		  }
                }else{
                  echo "flush not successful : ".mysqli_error($dbCon);
                }
            }else{
              echo "priveleges not granted : ".mysqli_error($dbCon);
            }
          }else{
            echo "user not added : ".mysqli_error($dbCon);
          }
        }
    }
?>
