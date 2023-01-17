<?php

$mysqli = new mysqli("localhost", "victor", "", "dissertacao_sem_eixo2");
$value = mysqli_real_escape_string($mysqli," ' \" %");
echo $value;

?>
