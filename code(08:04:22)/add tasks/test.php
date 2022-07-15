<?php
function boolReturn($result){
    if ($result == 1){
        return "true";
    }else{
        return "false";
    }
}
echo boolReturn(0);
?>
