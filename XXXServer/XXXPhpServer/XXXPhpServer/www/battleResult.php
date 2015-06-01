<?php

/**
 * battleResult short summary.
 *
 * battleResult description.
 *
 * @version 1.0
 * @author Hang
 */
 
 include 'common.php';
 

     //MAIN ENTRY
     
    $skey = $win = $monsterID = $crystal = "";
    if(isset($_POST["skey"])==true  && isset($_POST["win"])==true && isset($_POST["monsterID"])==true && isset($_POST["crystal"])==true){
        $skey= $_POST["skey"];
        $win = $_POST["win"];
        $monsterID = $_POST["monsterID"];
        $crystal = $_POST["crystal"];
    }else{
        error(1005);
    }
    
    $missionID =0;
    
    //GET MISSION ID
    //TODO check missionID with session info.
    if(isset($_SESSION['missionID']) == true){
        $missionID = $_SESSION['missionID'];
    }else{
        error(3001);
    }
    
    //Connect
    $mysqli = connectDB();
    
    //Filter special characters
    $skey = sqlFilter($mysqli,$skey);
    $monsterID = sqlFilter($mysqli,$monsterID);
    $win = sqlFilter($mysqli,$win);  
    $crystal = sqlFilter($mysqli,$crystal);    
        
    $unlock = false;
	
	//Get UID

    $uid = $_SESSION['uid'];
		 
    if($win === 'true'){
            $unlock = true;
        

  
    
     
         // Insert MissionInfo
        //Prepare SQL statement
        $sql_insert = "INSERT INTO MissionInfo (uid,missionID)VALUES (?,?)";
    
         /* create a prepared statement */
        if ($stmt =$mysqli->prepare($sql_insert)){
        
         
            /* bind parameters for markers */
            $stmt->bind_param('ii',$uid,$missionID);
            $res = ($stmt->execute());

            $stmt->close();   
        
            $sql_get = "SELECT uid FROM MissionInfo WHERE uid = ? AND missionID = ?";
            if ($stmt =$mysqli->prepare($sql_get)){ 
                $stmt->bind_param('ii',$uid,$missionID);
                $res = ($stmt->execute());
        
                /* fetch value */
                $result = $stmt->get_result();
                $data = $result->fetch_array();
                if($data == null){
                    error(1003);
                }       
                $stmt->close();    
            }else{
                error(1007);
            }
        }else{
            error(1007);
        }
        
    }
    //Change crystal
    updateCrystal($mysqli,$uid, $crystal);
    
    unset($_SESSION['missionID']);
    
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['unlock'] = $unlock;
    $res = json_encode($json);
    echo($res);
 
?>