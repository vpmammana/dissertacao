<?php

$mysqli = new mysqli("localhost", "victor", "", "dissertacao");
$value = mysqli_real_escape_string($mysqli," ' \" %");
echo $value;

?>
