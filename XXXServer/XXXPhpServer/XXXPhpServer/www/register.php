<?php

/**
 * register short summary.
 *
 * register description.
 *
 * @version 1.0
 * @author Hang
 */
 
 include 'common.php';
 

 
 function getRandomUUID(){
    $param = 40;
    $dict="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $key = "";
    for($i=0;$i<$param;$i++)
     {
         $key .= $dict[rand(0,32)];    //生成php随机数
     }
     return md5((string)getServerTime().$key);
 }
 



     //MAIN ENTRY
    if($_SERVER['REQUEST_METHOD'] != 'POST'){error(1005);}

    $registrationAllowed = true;
    
    if(!$registrationAllowed){error(2001);}
    
    //Connect
    $mysqli = connectDB();

    

// Generate UUID 
    //Prepare SQL statement
    $sql_get = "SELECT uid FROM UserInfo WHERE uuid = ?";
    
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        $count = 0;
        while(true){ 
            $count ++;
            if($count > 100){
                error(2002);
                exit();
            }
            $uuid = getRandomUUID();

                /* bind parameters for markers */
                $stmt->bind_param('s',$uuid);
                $res = ($stmt->execute());
        
                /* fetch value */
                $result = $stmt->get_result();
                $data = $result->fetch_array();
                if($data != null){
                    continue; //re - generate md5
                }else{
                    break;
                }
           }
          $stmt->close();    
    }
    
//Insert UUID into database
    $sql_insert ="INSERT INTO UserInfo(uuid,crystal,money,energy,userHP)VALUES (?,?,?,?,?)";
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_insert)){

        //Initial resource
        $crystal = 0;
        $money = 0;
        $energy = 0;
        $userHP = 300;
        $stmt->bind_param('siiii', $uuid, $crystal,$money,$energy,$userHP);

         // uID is auto-increased, need to check the result
         $stmt->execute();
       
         $stmt->close();   
         $sql_get = "SELECT uid FROM UserInfo WHERE uuid = ?";
        
         if ($stmt =$mysqli->prepare($sql_get)){

             /* bind parameters for markers */
             $stmt->bind_param('s', $uuid);
             $res = ($stmt->execute());
             
             /* fetch value */
             $result = $stmt->get_result();
             $data = $result->fetch_array();


             if($data == null){
                 error(1003);
                 exit();
             }else{
                $uid = $data['uid'];
             }
             $stmt->close();
         }else{
            error(1007);
         }
             
    }else{
        error(1007);
    }
 
     $initialSkills = array(1001,1002,1004,1006,1008);//NEED STANDARIZATION IN THE FUTURE
     
    //Insert Initial Skill into database
    $sql_insert ="INSERT INTO SkillInfo(uid,skillID,skillExp)VALUES (?,?,?)";
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_insert)){

        //Initial resource
        $skillID =0;
        $skillExp =0;
        $stmt->bind_param('iii', $uid, $skillID,$skillExp);

        for($i =0; $i < count($initialSkills);$i++){
            $skillID = $initialSkills[$i];
            $stmt->execute();
        } 
         $stmt->close();   
         $sql_get = "SELECT uid FROM SkillInfo WHERE uid = ?";
        
         if ($stmt =$mysqli->prepare($sql_get)){

             /* bind parameters for markers */
             $stmt->bind_param('s', $uid);
             $res = ($stmt->execute());
             
             /* fetch value */
             $result = $stmt->get_result();
             
             $count = 0;
             while($data = $result->fetch_array()){
                   $count ++;
             }    

             $stmt->close();
             if($count != count($initialSkills)){
                 error(1003);
                 exit();
             }
         }else{
            error(1007);
        }
             
    }else{
        error(1007);
    }
    
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['uuid'] = $uuid;
    $res = json_encode($json);
    echo($res);
 
?>