<?php

$mysqli = new mysqli("localhost", "cookin9o_pvk", "dmceproject2015", "cookin9o_cookit");
$myArray = array();


//database connection

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}


// Truncating temp_recipe_ig 

if (!$mysqli->query("TRUNCATE TABLE temp_recipe_ig")) {
    echo "truncate table failed: (" . $mysqli->errno . ") " . $mysqli->error;
}
// echo 'table truncated';

#################################### ARRAY AND VEG RADIO BUTTON HARD CODED FOR TESTING
//$vegstring = //$_POST['veg'];//
//$veg=(int)$vegstring;  
$veg=0;
//$ingredientsArray = $_POST['p'];//
//$a= $_POST['p'];//
//$b= $_POST['q'];
//$c= $_POST['r'];

//$veg = 0; // session variable IF RADIO BUTTON IS VEG THEN PARAMETER IS 1. IF RADIO BUTTON IS nv THEN PARAMETER PASSED IS 0
$ingredientsArray = array();//
$ingredientsArray = array('tomato','butter','paneer');
//array_push($ingredientsArray,$a);
//array_push($ingredientsArray,$b);
//array_push($ingredientsArray,$c);



// exe foreach ingredient in input array


foreach($ingredientsArray as $prc_in)
 { 
    //echo $prc_in;

    //calling procedure prc_find_recipes for $prc_in

    if (!$mysqli->query("CALL prc_find_recipes('$prc_in',$veg)")) {
        echo "CALL failed: (" . $mysqli->errno . ") " . $mysqli->error;
        }
  }


// fetching JSON

if ($result_json = $mysqli->query("SELECT recipe_name from 
									                 (select recipe_id,recipe_name,count(recipe_name) 
                                     from temp_recipe_ig 
                                     group by recipe_id,recipe_name
                                     order by 3 desc) axe"
                                 )
    ) {

    while($row = mysqli_fetch_array($result_json,MYSQLI_ASSOC)) {
            $myArray[] = $row;
    }
    echo json_encode($myArray);
}
$result_json->close();



// HTML
/*
if (!($result = $mysqli->query("SELECT recipe_name from 
									(select recipe_id,recipe_name,count(recipe_name) 
                                     from temp_recipe_ig 
                                     group by recipe_id,recipe_name
                                     order by 3 desc) axe")

	)) {
    echo "SELECT failed: (" . $mysqli->errno . ") " . $mysqli->error;
}



echo "<table border='1'>
<tr>
<th>NAME</th>
</tr>";

while($row = mysqli_fetch_array($result))
  {
  echo "<tr>";
  echo "<td>" . $row['recipe_name'] . "</td>";
  echo "</tr>";
  }
echo "</table>";
*/

// Closing DB connection
$mysqli->close();

?>