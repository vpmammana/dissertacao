<?php

if(isset($_GET["secao_movel"])){
  $secao_movel= $_GET["secao_movel"];
} else {$secao_movel = "__________";}

if(isset($_GET["secao_alvo"])){
  $secao_alvo= $_GET["secao_alvo"];
} else {$secao_alvo = "lixeira";}

include "identifica.php.cripto";




$database = "dissertacao";


$pdo = new PDO('mysql:dbname='.$database.';host=127.0.0.1', $username, $pass);
$data = $pdo->query("call transpoe_subarvore('".$secao_movel."', '".$secao_alvo."');")->fetchAll(PDO::FETCH_ASSOC);
print_r($data);
echo '<br />';
print_r($total_count);


?>
