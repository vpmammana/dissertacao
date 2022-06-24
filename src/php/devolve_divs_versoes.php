<?php

if(isset($_GET["id_chave_secao"])){
  $param_id_chave_secao= $_GET["id_chave_secao"];
} else $param_id_chave_secao = "topico";

if(isset($_GET["largura"])){
  $param_largura= $_GET["largura"];
} else $param_largura = "2";

if(isset($_GET["unidade"])){
  $param_unidade= $_GET["unidade"];
} else $param_unidade = "rem";

include "identifica.php.cripto";

$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);

$sql = "select id_chave_versao, nome_versao, id_secao, trecho from versoes where id_secao = ".$param_id_chave_secao.";";

$result = $conn->query($sql);

$divs="Versões Disponíveis";
$conta_versoes =0;
if ($result->num_rows > 0){
while ($row=$result->fetch_assoc()){
	$id			 = $row["id_chave_versao"];
	$nome			 = $row["nome_versao"];
	$id_secao		 = $row["id_secao"];
	$trecho			 = $row["trecho"];
	
	$posicao_x = $conta_versoes * ($param_largura) + $param_largura;
	$nome_corrigido = preg_replace("/\.[0-9]*/","",$nome);
	$nome_corrigido = preg_replace("/ /","<br>",$nome_corrigido);

	$divs = $divs."<div id='secao_".$id."_".$conta_versoes."' class='uma_versao' style='top: 2rem; left: ".$posicao_x.$param_unidade."'>".$nome_corrigido."</div>";
	$conta_versoes++;
}
} else {
	echo "Deu problema com o select: ".$sql;
}
echo $divs;

$conn->close();

?>
