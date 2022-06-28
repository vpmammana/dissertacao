<?php

if(isset($_GET["id_chave_secao"])){
  $param_id_chave_secao= $_GET["id_chave_secao"];
} else $param_id_chave_secao = "topico";

if(isset($_GET["largura"])){
  $param_largura= $_GET["largura"];
} else $param_largura = "2";

if(isset($_GET["altura"])){
  $param_altura= $_GET["altura"];
} else $param_altura = "2";

if(isset($_GET["separacao"])){
  $param_separacao= $_GET["separacao"];
} else $param_separacao = "2";

if(isset($_GET["fonte"])){
  $param_fonte= $_GET["fonte"];
} else $param_fonte = "2";

if(isset($_GET["fator_fonte"])){
  $param_fator_fonte= $_GET["fator_fonte"];
} else $param_fator_fonte = "2";


if(isset($_GET["unidade"])){
  $param_unidade= $_GET["unidade"];
} else $param_unidade = "rem";

if(isset($_GET["textarea"])){
  $param_textarea= $_GET["textarea"];
} else $param_textarea = "putz";


include "identifica.php.cripto";

$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);

$sql = "select id_chave_versao, nome_versao, id_secao, trecho from versoes where id_secao = ".$param_id_chave_secao.";";
	
$altura_cabecalio = $param_fonte * $param_fator_fonte;
$result = $conn->query($sql);
$divs="<div id='cabecalio_versoes_".$param_id_chave_secao."' class='cabecalio_versoes' style='top: 1px; left:1px; width: auto; height: ".$altura_cabecalio.$param_unidade."; font-size: ".$param_fonte.$param_unidade."; position:absolute; display: block; text-overflow: clip; white-space: nowrap; '>Versões Disponíveis</div>";
$conta_versoes =0;
if ($result->num_rows > 0){
while ($row=$result->fetch_assoc()){
	$id			 = $row["id_chave_versao"];
	$nome			 = $row["nome_versao"];
	$id_secao		 = $row["id_secao"];
	$trecho			 = $row["trecho"];
	
	$posicao_x = $conta_versoes * ($param_largura + $param_separacao) + $param_largura;
	$nome_corrigido = preg_replace("/\.[0-9]*/","",$nome);
//	$nome_corrigido = preg_replace("/ /","<br>",$nome_corrigido);

	$divs = $divs."<div id='secao_".$id."_".$conta_versoes."' class='uma_versao' data-trecho='".$trecho."' style='top: ".$altura_cabecalio.$param_unidade."; left: ".$posicao_x.$param_unidade."; width: ".$param_largura.$param_unidade."; height: ".$param_altura.$param_unidade."; display: table-cell; vertical-align: middle; font-size: ".$param_fonte.$param_unidade.";' data-id-chave='".$id."' onclick='document.getElementById(`".$param_textarea."`).value=this.getAttribute(`data-trecho`)'>".$nome_corrigido."</div>";
	$conta_versoes++;
}
} else {
	echo "Deu problema com o select: ".$sql;
}
	$posicao_x = $conta_versoes * ($param_largura + $param_separacao) + $param_largura;
$largura_blank = 20*$param_largura;
$divs = $divs."<div id='blank_".$param_textarea."' class='uma_versao' data-trecho='blank' style='top: ".$altura_cabecalio.$param_unidade."; left: ".$posicao_x.$param_unidade."; width: ".$largura_blank.$param_unidade."; height: ".$param_altura.$param_unidade."; display: table-cell; vertical-align: middle; font-size: ".$param_fonte.$param_unidade."; visibility: hidden' >blank</div>";


echo $divs;

$conn->close();

?>
