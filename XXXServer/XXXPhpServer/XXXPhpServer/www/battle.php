<?php

/**
 * battle short summary.
 *
 * battle description.
 *
 * @version 1.0
 * @author Hang
 */
 
 include 'common.php';
 

     //MAIN ENTRY
     
    $skey = $missionID = "";
    if(isset($_POST["skey"])==true  && isset($_POST["missionID"])==true){
        $skey= $_POST["skey"];
        $missionID = $_POST["missionID"];
    }else{
        //error(1005);
        //FOR DEBUG ONLY NEED TO BE DELETED
        $missionID =101101;
        $skey = '64379b83874f3f21f41b72c816388381';
    }

    //Connect
    $mysqli = connectDB();
    
    //Filter special characters
    $uuid = sqlFilter($mysqli,$uuid);
    
//Get UID

    $sql_get = "SELECT uid FROM SessionInfo WHERE skey = ?";
    
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        
        /* bind parameters for markers */
        $stmt->bind_param('s',$skey);
        $res = ($stmt->execute());

        /* fetch value */
        $result = $stmt->get_result();
        $data = $result->fetch_array();
        if($data == null){
            error(2006);
            exit();
        }       
        $stmt->close();    
    }
        
    $uid = $data['uid'];
  
    
$bool_enter = true;
// Check MissionInfo
    //Prepare SQL statement
    $sql_get = "SELECT missionID FROM MissionInfo WHERE (uid = ? AND missionID = ?)";
    
     /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        
        /* bind parameters for markers */
        $stmt->bind_param('ii',$uid,$missionID);
        $res = ($stmt->execute());

        /* fetch value */
        $result = $stmt->get_result();
        $data = $result->fetch_array();
        if($data == null){
            $bool_enter = false;
        }       
        $stmt->close();    
    }
        
    
  
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['enter'] = $bool_enter;
    $res = json_encode($json);
    echo($res);
 
?>