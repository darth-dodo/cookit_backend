<?php


$mysqli = new mysqli("localhost", "cookin9o_pvk", "dmceproject2015", "cookin9o_cookit");
$myArray = array();

//database connection

if ($mysqli -> connect_errno){
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}


// input from app
//$input = $_POST['p'];

$input = "egg biryani";

$recipe_name = strtolower($input);

#echo $recipe_name;

if($youtube_link = $mysqli->query("SELECT youtube_link FROM recipe_youtube 
	WHERE recipe_name = '$recipe_name'")
#print $youtube_link;
){
    while($row = mysqli_fetch_array($youtube_link,MYSQLI_ASSOC)) {
            $myArray[] = $row;
    }
echo json_encode($myArray);
}

$mysqli->close();

?>

