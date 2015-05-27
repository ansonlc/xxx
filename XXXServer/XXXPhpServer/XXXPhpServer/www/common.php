<?php

/**
 * common short summary.
 *
 * common description.
 *
 * @version 2.0
 * @author Hang & Fangzhou
 */

 //Loading Session with skey
if (isset($_POST['skey'])) {
    session_id($_POST['skey']);
}
session_start();

 //1 - General  2 - about User info
 $errorMsg = array(
    1001 => "General Error",
    1002 => "Connection Error",
    1003 => "Database Insert Error",
    1004 => "Database Connect Error",
    1005 => "Request Format Error",
    2001 => "You cannot register new accounts now",   
    2002 => "Error in creating uuid",
    2003 => "You need to register first",
    2004 => "Error in creating session key",
    2005 => "No record for this UUID",
    2006 => "SKEY doesn't match with UUID",
 );
 function connectDB(){
    $mysqli = new mysqli("162.243.157.235", "mobile", "mobilegame2015", "MobileGame");
    if ($mysqli->connect_errno) {
        echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
        error(1004);
    }
    return $mysqli;
 }
 function getServerTime(){
   return $_SERVER['REQUEST_TIME'];//time(
 }
 
 function sqlFilter($mysqli,$str)
 {
     // INT
     if (is_int($str)){
             return $str;//do nothing
     }
     // String
     $str = str_replace("&", "&amp;",$str);
     $str = str_replace("<", "&lt;", $str);
     $str = str_replace(">", "&gt;", $str);
     if ( get_magic_quotes_gpc() )
     {
         $str = str_replace("\\\"", "&quot;",$str);
         $str = str_replace("\\''", "&#039;",$str);
     }
     else
     {
         $str = str_replace("\"", "&quot;",$str);
         $str = str_replace("'", "&#039;",$str);
         
     }
     
     //Customized
     
     $str = $mysqli->real_escape_string($str);
     
    
     return $str;
 }
 
  //Send response of error
 function error($retcode, $str = ""){
    global $errorMsg;
    $json = array();

    $json['serverTime'] = getServerTime();
    
    $json['retcode'] = $retcode;
    $json['errmsg'] = $errorMsg[$retcode]." ".$str." ".$_SERVER['PHP_SELF'];
    $res = json_encode($json);
    echo($res);
    exit();
}
 ?>