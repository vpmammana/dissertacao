<?php

if(isset($_GET["id_chave_secao"])){
  $param_id_chave_secao= $_GET["id_chave_secao"];
} else $param_id_chave_secao = "topico";

if(isset($_GET["trecho"])){
  $param_trecho= $_GET["trecho"];
} else $param_trecho = "topico";

include "identifica.php.cripto";

$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);

$sql = "insert into versoes (id_secao, trecho) values (".$param_id_chave_secao.", '".mysqli_real_escape_string($conn, $param_trecho)."');";

if ($conn->query($sql)===true){ echo "Nova versão gravada escape: ".$param_trecho;} else {echo "<br> Deu problema com o sql: ".$sql."<br> erro:".$conn->error."<br>";}

$conn->close();

?>
