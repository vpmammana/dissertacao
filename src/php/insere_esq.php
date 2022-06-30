<?php

if(isset($_GET["nome_secao"])){
  $nome_secao= $_GET["nome_secao"];
} else {$nome_secao = "lixeira";}

if(isset($_GET["id_tipo_secao"])){
  $id_tipo_secao= $_GET["id_tipo_secao"];
} else {$id_tipo_secao = "18";}

if(isset($_GET["trecho"])){
  $trecho= $_GET["trecho"];
} else {$trecho = "NOVO TRECHO";}


include "identifica.php.cripto";




$database = "dissertacao";


$pdo = new PDO('mysql:dbname='.$database.';host=127.0.0.1', $username, $pass);
$data = $pdo->query("call insere_a_esquerda_do_atual('".$nome_secao."', '".$id_tipo_secao."', '".$trecho."');")->fetchAll(PDO::FETCH_ASSOC);
//print_r($data);
//echo '<br />';
//print_r($total_count);
echo "Foi inserido um novo trecho à esquerda de ".$nome_secao." com o tipo ".$id_tipo_secao."!";

?>
