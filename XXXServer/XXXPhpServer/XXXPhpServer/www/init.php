<?php

/**
 * init short summary.
 *
 * init description.
 *
 * @version 1.0
 * @author Hang
 */
 
 include 'common.php';
 


     //MAIN ENTRY
     
    $uuid = "";
    $skey = "";
    if(isset($_POST["uuid"])==true && isset($_POST["skey"])==true){
        $uuid = $_POST["uuid"];
        $skey = $_POST["skey"];
    }else{
        //error(1005);
        //FOR DEBUG ONLY NEED TO BE DELETED
        $uuid ='justfortest';
        $session = '64379b83874f3f21f41b72c816388381';
    }

    //Connect
    $mysqli = connectDB();
    
    //Filter special characters
    $uuid = sqlFilter($mysqli,$uuid);
   
    //Check UUID & Session
    //Prepare SQL statement
    $sql_get = "SELECT * FROM UserInfo WHERE uuid = ?";
    
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        
        /* bind parameters for markers */
        $stmt->bind_param('s',$uuid);
        $res = ($stmt->execute());

        /* fetch value */
        $result = $stmt->get_result();
        $data = $result->fetch_array();
        if($data == null){
            error(2005);
            exit();
        }       
        $stmt->close();    
    }
        
    $uid = $data['uid'];
    $jsonUser = array();
    $jsonUser['crystal'] = $data['crystal'];
    $jsonUser['money'] = $data['money'];
    $jsonUser['energy'] = $data['energy'];
    
    $sql_get = "SELECT uid FROM SessionInfo WHERE uid = ? & skey = ?";
    
      /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        
        /* bind parameters for markers */
        $stmt->bind_param('is',$uid, $skey);
        $res = ($stmt->execute());

        /* fetch value */
        $result = $stmt->get_result();
        $data = $result->fetch_array();
        if($data == null){
            error(2005);
            exit();
        }       
        $stmt->close();    
    }
    

//Get skill info & mission info

    $jsonSkill = array();
    $sql_get = "SELECT * FROM SkillInfo WHERE uid = ?";
    
      /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        
        /* bind parameters for markers */
        $stmt->bind_param('i',$uid);
        $res = ($stmt->execute());

        /* fetch value */
        $result = $stmt->get_result();
        while($data = $result->fetch_array()){
            $skillID = $data['skillID'];
            $skillExp = $data['skillExp']; 
            $jsonSkill[$skillID] = array("skillID" =>$skillID,"exp" => $skillExp );
        }    
        $stmt->close();    
    }
    

    $jsonMission = array();
    $sql_get = "SELECT * FROM MissionInfo WHERE uid = ?";
    
    
    if ($stmt =$mysqli->prepare($sql_get)){
        
        /* bind parameters for markers */
        $stmt->bind_param('i',$uid);
        $res = ($stmt->execute());

        /* fetch value */
        $result = $stmt->get_result();
        while($data = $result->fetch_array()){
            $missionID = $data['missionID'];
            $missionScore = $data['missionScore']; 
            $jsonMission[$skillID] = array("missionID" => $missionID, "score" => $missionScore );
        }    
        $stmt->close();    
    }

    
    
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['userInfo'] = $jsonUser;
    $json['skillInfo'] = $jsonSkill;
    $json['missionInfo'] = $jsonMission;
    $res = json_encode($json);
    echo($res);
 
?>