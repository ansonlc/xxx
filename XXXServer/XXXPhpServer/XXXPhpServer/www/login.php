<?php

/**
 * login short summary.
 *
 * login description.
 *
 * @version 1.0
 * @author Hang
 */
 
 include 'common.php';
 


    

     //MAIN ENTRY
    $uuid = "";
    if(isset($_POST["uuid"])==true){
        $uuid = $_POST["uuid"];
    }else{
        error(1005);
    }

    //Connect
    $mysqli = connectDB();
   
    //Filter special characters
    $uuid = sqlFilter($mysqli,$uuid);

//Check UUID
    //Prepare SQL statement
    $sql_get = "SELECT uid FROM UserInfo WHERE uuid = ?";
    
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        
        /* bind parameters for markers */
        $stmt->bind_param('s',$uuid);
        $res = ($stmt->execute());

        /* fetch value */
        $result = $stmt->get_result();
        $data = $result->fetch_array();
        if($data == null){
            error(2003);
            exit();
        }       
        $stmt->close();    
    }else{
        error(1007);
    }
        
    $uid = $data['uid'];
    
    $_SESSION['uid'] = $uid; 
    
    $skey = session_id();
    
    
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['skey'] = $skey;
    $res = json_encode($json);
    echo($res);
 
?>