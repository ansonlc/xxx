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
    if(isset($_POST["skey"])==true && isset($_POST["skillID"])==true && isset($_POST["skillExp"])==true && isset($_POST["crystal"])==true){
        $skillIDArray = $_POST["skillID"];
        $skillExpArray = $_POST["skillExp"];
        $crystal = $_POST["crystal"];
    }else{
        error(1005);
       // $skillIDArray =array(1008);
       // $skillExpArray = array(2222);
       // $crystal = 3333;
    }

    //Connect
    $mysqli = connectDB();
    
    $uid =  $_SESSION['uid'];
    

    //Update skillExp
    
    //Prepare SQL statement
    $sql_update = "UPDATE SkillInfo SET skillExp = ? WHERE uid = ? AND skillID = ?";
    $sql_insert = "INSERT INTO SkillInfo(skillExp,uid,skillID)VALUES (?,?,?)";
    
    /* create a prepared statement */
    if (($stmt =$mysqli->prepare($sql_update)) && ($stmtInsert =$mysqli->prepare($sql_insert))){
        
        $skillExp = 0;
        $skillID = 0;
        
        /* bind parameters for markers */
        $stmt->bind_param('iii',$skillExp,$uid,$skillID);
        $stmtInsert->bind_param('iii',$skillExp,$uid,$skillID);
        
        for($i =0; $i < count($skillIDArray);$i++){
            $skillID = $skillIDArray[$i];
            $skillExp = $skillExpArray[$i];
            if($skillExp ==0){
                $stmtInsert->execute();
            }
            else{
                $stmt->execute();
            }
        } 
        
        $stmt->close();   
        $stmtInsert->close();   
        
        //Check Update result
        $sql_get = "SELECT skillExp FROM SkillInfo WHERE uid = ? AND skillID = ?";
        
        if ($stmt =$mysqli->prepare($sql_get)){
        
            /* bind parameters for markers */
            $stmt->bind_param('ii',$uid,$skillID);
        
            for($i =0; $i < count($skillIDArray);$i++){
                $skillID = $skillIDArray[$i];
                $skillExp = $skillExpArray[$i];
                $stmt->execute();
            
                /* fetch value */
                $result = $stmt->get_result();
                $data = $result->fetch_array();
                if($data['skillExp'] != $skillExp){
                    error(1006);
                  
                }      
            } 
            $stmt->close();   
        }else{
            error(1007);
        }
        
        //Change crystal
        updateCrystal($mysqli,$uid, 0 - $crystal);
        
    }else{
        error(1007);
    }
        
 
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['skillIDs'] = $skillIDArray;
    $res = json_encode($json);
    echo($res);
 
?>