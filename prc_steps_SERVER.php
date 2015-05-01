<?php

$mysqli = new mysqli("localhost", "cookin9o_pvk", "dmceproject2015", "cookin9o_cookit");

$myArrayIng = array();
$myArraySteps = array();


//database connection

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}



//truncating table

if (!$mysqli->query("truncate TABLE temp_ig")) {
    echo "truncate table failed: (" . $mysqli->errno . ") " . $mysqli->error;
}


if (!$mysqli->query("truncate TABLE temp_steps")) {
    echo "truncate table failed: (" . $mysqli->errno . ") " . $mysqli->error;
}


#calling procedure prc_recipe_details for given recipe_name 


// HARD CODED FOR TESTING


$recipe_name = $_POST['p'];

//$recipe_name = "channa masala";

//echo $recipe_name."\r\n";


if (!$mysqli->query("CALL prc_recipe_details('$recipe_name')")) {
    echo "CALL failed: (" . $mysqli->errno . ") " . $mysqli->error;
    }



// JSON for temp_steps

if ($result_st = $mysqli->query("SELECT * FROM temp_steps")) {

    while($row = mysqli_fetch_array($result_st,MYSQLI_ASSOC)) {
            $myArraySteps[] = $row;
    }
    echo json_encode($myArraySteps);
}
$result_st->close();


// HTML table for steps
/*
if (!($result = $mysqli->query("SELECT steps FROM temp_steps"))) {
    echo "SELECT failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

echo "<table border='1'>
<tr>
<th>Steps</th>
</tr>";

while($row = mysqli_fetch_array($result))
  {
  echo "<tr>";
  echo "<td>" . $row['steps'] . "</td>";
  echo "</tr>";
  }
echo "</table>";
*/


// Closing DB connection
$mysqli->close();

?>