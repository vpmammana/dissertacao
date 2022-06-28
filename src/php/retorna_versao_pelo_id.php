<?php


if(isset($_GET["id_chave_secao"])){
  $param_id_chave_secao= $_GET["id_chave_secao"];
} else $param_id_chave_secao = "2";


include "identifica.php.cripto";

$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);

$sql = "select id_chave_versao, nome_versao, id_secao, trecho from versoes where id_chave_versao = ".$param_id_chave_secao.";";

$result = $conn->query($sql);



if ($result->num_rows != 1) {echo "Deu problema: deveria ter apenas um resultado, mas teve ".$result->num_rows." com a query: ".$sql;} else
{
while ($row=$result->fetch_assoc()){
	$trecho			 = $row["trecho"];
	

}

echo $trecho;

}

$conn->close();
?>
