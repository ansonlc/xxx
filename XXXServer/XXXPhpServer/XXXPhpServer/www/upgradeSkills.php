<?php

/**
 * upgradeSkill short summary.
 *
 * upgradeSkill description.
 *
 * @version 1.0
 * @author Hang
 */
 
 include 'common.php';
 


     //MAIN ENTRY
     
    $uuid = "";
    $skey = "";
    if(isset($_POST["skey"])==true && isset($_POST["skillID"])==true && isset($_POST["skillExp"])==true){
        $skillIDArray = $_POST["skillID"];
        $skillExpArray = $_POST["skillExp"];
    }else{
        error(1005);
    }

    //Connect
    $mysqli = connectDB();
    
    $uid =  $_SESSION['uid'];
    
    //Update skillExp
    
    //Prepare SQL statement
    $sql_update = "UPDATE SkillInfo SET skillExp = ? WHERE uid = ? AND skillID = ?";
    
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_update)){
        
        $skillExp = 0;
        $skillID = 0;
        
        /* bind parameters for markers */
        $stmt->bind_param('iii',$skillExp,$uid,$skillID);
        
        
        for($i =0; $i < count($skillIDArray);$i++){
            $skillID = $skillIDArray[$i];
            $skillExp = $skillExpArray[$i];
            $stmt->execute();
        } 
        
        $stmt->close();   
        
        //Check Update result
        $sql_get = "SELECT uid FROM SkillInfo WHERE uid = ? AND skillID = ? AND skillExp = ?";
        
        if ($stmt =$mysqli->prepare($sql_get)){
        
            /* bind parameters for markers */
            $stmt->bind_param('iii',$uid,$skillID,$skillExp);
        
            for($i =0; $i < count($skillIDArray);$i++){
                $skillID = $skillIDArray[$i];
                $skillExp = $skillExpArray[$i];
                $stmt->execute();
            } 
            /* fetch value */
            $result = $stmt->get_result();
            $data = $result->fetch_array();
            if($data == null){
                error(1006);
                exit();
            }       
            $stmt->close();   
        }
    }
        
 
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['skillIDs'] = $skillIDArray;
    $res = json_encode($json);
    echo($res);
 
?>