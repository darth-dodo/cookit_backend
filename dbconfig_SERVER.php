<?php

function getConnection()
  {

$mysqli = new mysqli("localhost", "cookin9o_pvk", "dmceproject2015", "cookin9o_cookit");
     return $con;
}

echo "cookit db connect successful"
?>