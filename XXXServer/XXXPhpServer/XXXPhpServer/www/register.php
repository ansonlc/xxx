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
    $sql_insert ="INSERT INTO UserInfo(uuid,crystal,money,energy)VALUES (?,?,?,?)";
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_insert)){

        //Initial resource
        $crystal = 0;
        $money = 0;
        $energy = 0;
        $stmt->bind_param('siii', $uuid, $crystal,$money,$energy);

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
             $story = $result->fetch_array();

             $stmt->close();
             if($story == null){
                 error(1003);
                 exit();
             }
         }
             
    }
    
    //Return response
    $json = array();
    $json['serverTime'] = getServerTime();   
    $json['uuid'] = $uuid;
    $res = json_encode($json);
    echo($res);
 
?>