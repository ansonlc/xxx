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
 

 function getRandomKey(){
    $param = 32;
    $dict="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $key = "";
    for($i=0;$i<$param;$i++)
     {
         $key .= $dict[rand(0,32)];    //生成php随机数
     }
     return md5((string)getServerTime().$key);
 }
 
    

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
    }
        
    $uid = $data['uid'];
  
    

// Generate SKEY 
    //Prepare SQL statement
    $sql_get = "SELECT sid FROM SessionInfo WHERE skey = ?";
    
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_get)){
        $count = 0;
        while(true){ 
            $count ++;
            if($count > 100){
                error(2004);
                exit();
            }
            $skey = getRandomKey();
    
            //echo($skey);
            
                /* bind parameters for markers */
                $stmt->bind_param('s',$skey);
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
    
//Insert SKEY into database
    $sql_insert ="INSERT INTO SessionInfo(uid, skey)VALUES (?,?)";
    /* create a prepared statement */
    if ($stmt =$mysqli->prepare($sql_insert)){

         $stmt->bind_param('is', $uid, $skey);

         // sID is auto-increased, need to check the result
         $stmt->execute();
       
         $stmt->close();   
         $sql_get = "SELECT sid FROM SessionInfo WHERE skey = ?";
        
         if ($stmt =$mysqli->prepare($sql_get)){

             /* bind parameters for markers */
             $stmt->bind_param('s', $skey);
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
    $json['skey'] = $skey;
    $res = json_encode($json);
    echo($res);
 
?>