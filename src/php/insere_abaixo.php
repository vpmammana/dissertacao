<?php

if(isset($_GET["nome_secao_pai"])){
  $nome_secao_pai= $_GET["nome_secao_pai"];
} else {$nome_secao_pai = "lixeira";}

if(isset($_GET["nome_tipo_secao"])){
  $nome_tipo_secao= $_GET["nome_tipo_secao"];
} else {$nome_tipo_secao = "18";}

if(isset($_GET["trecho"])){
  $trecho= $_GET["trecho"];
} else {$trecho = "NOVO TRECHO";}


include "identifica.php.cripto";




$database = "dissertacao_sem_eixo2";
 echo "call insere_abaixo_do_atual('".$nome_secao_pai."', '".$nome_tipo_secao."', '".$trecho."')";
$pdo = new PDO('mysql:dbname='.$database.';host=127.0.0.1', $username, $pass);
$data = $pdo->query("call  insere_abaixo_do_atual('".$nome_secao_pai."', '".$nome_tipo_secao."', '".$trecho."');")->fetchAll(PDO::FETCH_ASSOC);
//print_r($data);
//echo '<br />';
//print_r($total_count);
echo "Foi inserido um novo trecho abaixo de ".$nome_secao_pai." com o tipo ".$nome_tipo_secao."!";

?>
