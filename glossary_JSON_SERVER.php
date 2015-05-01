<?php

$mysqli = new mysqli("localhost", "cookin9o_pvk", "dmceproject2015", "cookin9o_cookit");
$myArray = array();


//database connection

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}


//JSON of Ingredients

if ($result = $mysqli->query("SELECT * FROM glossary")) {

    while($row = mysqli_fetch_array($result,MYSQLI_ASSOC)) {
            $myArray[] = $row;
    }
    echo json_encode($myArray);
}
#$result->close();



//HTML tbl for cooking_methods
/*
if (!($result = $mysqli->query("SELECT * FROM glossary order by 1"))) {
    echo "SELECT failed: (" . $mysqli->errno . ") " . $mysqli->error;
}


echo "<table border='1'>
<tr>
<th>Ingredient</th>
<th>Meaning</th>
</tr>";

while($row = mysqli_fetch_array($result))
  {
  echo "<tr>";
  echo "<td>" . $row['Ingredient'] . "</td>";
  echo "<td>" . $row['Meaning'] . "</td>";
  echo "</tr>";
  }
echo "</table>";
*/

// Closing DB connection
$mysqli->close();

?>