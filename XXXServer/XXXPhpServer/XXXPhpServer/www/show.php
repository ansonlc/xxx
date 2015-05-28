<?php

/**
 * show short summary.
 *
 * show description.
 *
 * @version 1.0
 * @author Hang
 */
 
 include 'common.php';
 


     //MAIN ENTRY
     
    $uuid = "";
    $skey = "";
    if(isset($_POST["skey"])==true){
        $uuid = $_POST["uuid"];
        $skey = $_POST["skey"];
    }else{
        error(1005);
    }
    echo($_SESSION['uid']);
?>