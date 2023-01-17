<!DOCTYPE html>
<html>
<head>
	<title>
		Dissertação UOXI
	</title>
<style>
.nivel {
	border: 1px solid black;
	background-color: gray;
	position: absolute;
	overflow: scroll;
	transition: all 1s ease-in-out;
 	-webkit-transition: all 1s ease-in-out;
	scroll-behavior: smooth;
}
.pai {
	border: 1px solid black;
	background-color: yellow;
	display: block;
	overflow: auto;
	transition: all .6s ease-in-out;
 	-webkit-transition: all .6s ease-in-out;
}

.titulo {
	float: left;
	font-size: 1.2rem;
	width: 100%;
	padding: 10px;
}
.secao {
	border: 1px solid red;
	background-color: blue;
	color: white;
	float: right;
	text-align: right;
	display: block;
	padding: 10px;
}
</style>
</head>

<body>
<h1>Dissertação de UOXI</h1>

<?php


include "identifica.php.cripto";

$max_niveis=5;
$padding_niveis = 100;
$top_niveis = 500;
$height_niveis= 300;
$height_pais = 100;
$largura_nivel= 300;
$largura_pai= 250;
$padding_nivel= 50;
$padding_pai = 10;
$altura_blank = 500;

function retorna_blank($key){
global $altura_blank;
return "<div id='blank_".$key."' style='height: ".$altura_blank."px'></div>";

 //return "<div id='blank_".$key."' style='height: 500px'>".$key."</div>";
}


$database = "dissertacao_sem_eixo2";

$conn= new mysqli("localhost", $username, $pass, $database);

$sql="call mostra_arvore_niveis_pais();";
$result=$conn->query("$sql");
$numero_registrados = $result->num_rows;
$niveis = [];
$pais = [];
echo "<table>";
$velho_titulo = "Dissertacao sem Eixo2";
if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
	$nivel             = $row["nivel"]; 
	$id_secao             = $row["id_filho"]; 
	$id_pai             = $row["id_pai"]; 
	$titulo             = $row["titulo"]; 
	if ($nivel > $max_niveis) {echo "Excedeu número máximo de níveis (".$max_niveis.")!"; exit();}
	$left = ($largura_nivel + $padding_nivel)*($nivel - 1);
	$indice_pai = $nivel."-".$id_pai;
	
	if ($nivel==0) {continue;}
	$itz = "<div id='secao_".$id_secao."' data-id-filho='".$id_secao."' data-nivel='".$nivel."' class='secao' style='width: ".$largura_pai*0.9."px'>".$titulo."</div>";
	if (array_key_exists($indice_pai, $pais)){$pais[$indice_pai]=$pais[$indice_pai].$itz;} else 
		{
	$pais[$indice_pai]="<div id='pai_".$id_pai."' class='pai' data-id-pai='".$id_pai."' data-nivel='".$nivel."' style='left: ".$left + $padding_pai."px; width: ".$largura_pai."px; top: ".$top_niveis."px;'><div class='titulo'>".$velho_titulo."</div>".$itz;
		}
$velho_titulo = $titulo;
	if ( array_key_exists($nivel, $niveis)) {} else 
		{$niveis[$nivel]="<div id='nivel_".$nivel."' data-nivel='".$nivel."' class='nivel' style='left: ".$left."px; width: ".$largura_nivel."px; top: ".$top_niveis."px; height: ".$height_niveis."px'>Este é o nível ".$nivel;}
	echo "<tr><td>".$nivel."</td><td>".$id_secao."</td><td>".$id_pai."</td><td>".$titulo."</td></tr>"; 
    }
}
else { echo "<tr><td>Não tem nomes duplicados</td></tr>";}

foreach($niveis as $key => $level) {
	foreach($pais as $chave => $valor) {
		$indices = explode("-",$chave);
		//echo $indices[0]."-".$key."  ".$valor." + ";
		if ($key == $indices[0]){
			$niveis[$key]=$niveis[$key].$valor."</div>";
		}		
	}
	$niveis[$key] = $niveis[$key] . retorna_blank($key."_bottom");
}


foreach($niveis as $level){
	echo $level."</div>";
}

echo "</table>";

?>

<script>

function ajusta_scroll(){
const collection3 = document.getElementsByClassName("nivel");
for (let i = 0; i < collection3.length; i++) {
	collection3[i].scrollTop=document.getElementById("blank_"+collection3[i].getAttribute("data-nivel")+"_top").style.height.replace('px','');
}

}

function limpa_pais (nivel) {
const collection = document.getElementsByClassName("pai");
for (let i = 0; i < collection.length; i++) {
  if (collection[i].getAttribute("data-nivel") > nivel) { collection[i].style.opacity = "0.5";} else { collection[i].style.opacity = "1.0";};
}

}

setTimeout(function () {
limpa_pais(1);
//ajusta_scroll();
const collection2 = document.getElementsByClassName("secao");
for (let i = 0; i < collection2.length; i++) {
  let that = collection2[i].getAttribute("data-id-filho"); // se colocar var não funciona
  collection2[i].addEventListener("mousedown",function ()
		{
			limpa_pais(this.getAttribute("data-nivel"));
			// alert(this.getAttribute("data-id-filho")+" - "+that + " + " + this.id);
			const pais = document.getElementsByClassName("pai");
			for (let j = 0; j < pais.length; j++){
				
				if (pais[j].getAttribute("data-id-pai") == that){
//alert(document.getElementById("blank_"+pais[j].getAttribute("data-nivel")+"_top").style.height.replace('px',''));					
					//alert(pais[j].id);
					pais[j].style.opacity = "1.0";
					div_nivel = document.getElementById("nivel_"+pais[j].getAttribute("data-nivel"));
					div_nivel.scrollTop=(pais[j].getBoundingClientRect().top ) - div_nivel.getBoundingClientRect().top;
				}
			}
	
		}
);
}

}, 1000);

</script>

</body>
</html>
