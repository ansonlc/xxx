<?php

/**
 * sessionAdd short summary.
 *
 * sessionAdd description.
 *
 * @version 1.0
 * @author Feliciano
 */

include "common.php";

$id = session_id();

$nowLevel;
if (!isset($_SESSION['nowLevel']))
    $nowLevel = 0;
else
    $nowLevel = $_SESSION['nowLevel'] + 1;

$_SESSION['nowLevel'] = $nowLevel;

echo "Now number is " + $nowLevel;

?>