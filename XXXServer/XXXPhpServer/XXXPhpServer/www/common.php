<?php

/**
 * common short summary.
 *
 * common description.
 *
 * @version 1.0
 * @author Hang
 */
 
 $errorMsg = array(
    0 => "General Error",
    1 => "Connection Error",
    2 => "Database Error",
    10 => "You cannot register new accounts now",
    11 => "Error in creating uuid",
    20 => "You need to register first",
    21 => "Error in creating session key",
 );
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