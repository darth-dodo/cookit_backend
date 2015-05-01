<?php


$mysqli = new mysqli("localhost", "cookin9o_pvk", "dmceproject2015", "cookin9o_cookit");
$myArray = array();


//database connection

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}


//JSON of Ingredients

if ($result_ig = $mysqli->query("SELECT Ing_name FROM ingredients order by 1")) {

    while($row = mysqli_fetch_array($result_ig,MYSQLI_ASSOC)) {
            $myArray[] = $row;
            //echo 'myArray'.$myArray;
    }
    echo json_encode($myArray);
}
$result_ig->close();


//HTML tbl for Ingredients
/*
if (!($result = $mysqli->query("SELECT Ing_name FROM ingredients order by 1"))) {
    echo "SELECT failed: (" . $mysqli->errno . ") " . $mysqli->error;
}


echo "<table border='1'>
<tr>
<th>Ingredients</th>
</tr>";

while($row = mysqli_fetch_array($result))
  {
  echo "<tr>";
  echo "<td>" . $row['Ing_name'] . "</td>";
  echo "</tr>";
  }
echo "</table>";
*/

// Closing DB connection
$mysqli->close();

?>