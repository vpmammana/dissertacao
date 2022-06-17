<!DOCTYPE html>
<html>
<head>
	<title>
		Dissertação UOXI
	</title>
<style>
.cabecalio_de_nivel {
	border: 1px solid black;
	background-color: white;
	color: black;
	position: absolute;
}

.moldura {
	position: relative;
	border: 1px solid black;
	background-color: lightgray;
	overflow: auto;
}

.nivel {
	border: 1px solid black;
	background-color: gray;
	position: absolute;
	overflow: scroll;
	overflow-x: hidden;
	transition: all 1s ease-in-out;
 	-webkit-transition: all 1s ease-in-out;
	scroll-behavior: smooth;
}
.pai {
	border: 1px solid black;
	background-color: yellow;
	display: block;
	overflow: hidden;
	transition: all .6s ease-in-out;
 	-webkit-transition: all .6s ease-in-out;
	margin-left: auto;
	margin-right: auto;
}

.titulo {
	float: left;
	font-size: 1.2rem;
	width: 100%;
	padding: 10px;
}
.secao {
	background-color: blue;
	color: white;
	float: right;
	text-align: right;
	display: block;
	padding: 10px;
}
.folha_de_arvore {
	position: absolute;
	background-color: green;
	color: white;
	padding: 3px;
	overflow: auto;
	overflow-y: hidden;
}

</style>
</head>

<body>
<h1>Dissertação de UOXI</h1>

<?php


include "identifica.php.cripto";

$max_niveis=5;
$padding_niveis = 100;
$top_niveis = 100; // posicao da extremidade superior dos niveis
$altura_cabecalio = 20;
$top_cabecalio = $top_niveis - $altura_cabecalio;
$height_niveis= 500;
$height_pais = 100;
$largura_nivel= 300;
$largura_pai= $largura_nivel * 0.9;
$padding_nivel= 10;
$padding_pai = 10;
$altura_blank = 500;
$largura_folha = 200;
$altura_folha = 20;
$padding_folha = 10;
$padding_arvore = 20;
$left_arvore = 1500;
$top_arvore = 100;
$divisao =  3;  // em que parte da largura da folha o nivel inferior comeca
$separador_de_pais = 15; // espaco de separacao entre pais
$max_tamanho_arvore = 300;

$cor_nivel = array("#006633", "#008040", "#00994d", "#00b359", "#00cc66", "#00e673");
$cor_letra_nivel = array ("white","white","white","black","black","black");
//$cor_nivel = array("#000066", "#000080", "#000099", "#0000b3", "#0000cc", "#0000e6");
//$cor_letra_nivel = array ("white","white","white","white","white","white");

function retorna_blank($key, $altura_blank){
return "<div id='blank_".$key."' style='height: ".$altura_blank."px'></div>";

 //return "<div id='blank_".$key."' style='height: 500px'>".$key."</div>";
}

$arvore = "";
$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);



$sql="call mostra_arvore_niveis_pais_seleciona_tipo('paragrafo');";
$result=$conn->query("$sql");
$numero_registrados = $result->num_rows;
$niveis = [];
$pais = [];
// echo "<table>";
$velho_titulo = "Dissertacao";
$top_folha = $top_arvore;

$min_folha = 100000000; // o menor left de todas as folhas
$max_folha = 0;  // o maior right de todas as folhas (considerando right = left + largura)
$min_top_folha = 10000000; 
$max_top_folha = 0;

if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
	$nivel             = $row["nivel"]; 
	$id_secao             = $row["id_filho"]; 
	$id_pai             = $row["id_pai"]; 
	$titulo             = $row["titulo"]; 
	if ($nivel > $max_niveis) {echo "Excedeu número máximo de níveis (".$max_niveis.")!"; exit();}
	$left = ($largura_nivel + $padding_nivel)*($nivel - 1);
	$indice_pai = $nivel."-".$id_pai;
	
        if ($top_folha < $min_top_folha) {$min_top_folha = $top_folha;}
        if (($top_folha + $altura_folha + $padding_folha) > $max_top_folha) {$max_top_folha = $top_folha + $altura_folha + $padding_folha;}	
	$left_folha = $left_arvore +  $nivel * $largura_folha/$divisao;

        if ($left_folha < $min_folha) {$min_folha = $left_folha;};	
        if (($left_folha + $largura_folha) > $max_folha) {$max_folha = $left_folha + $largura_folha;}	

	$arvore = $arvore."<div id='folha_arvore_".$id_secao."' class='folha_de_arvore flutua_para_direita_filho' data-cor-nivel='".$cor_nivel[$nivel]."' data-cor-letra='".$cor_letra_nivel[$nivel]."' style=' background-color: ".$cor_nivel[$nivel]."; color: ".$cor_letra_nivel[$nivel]."; width: ".$largura_folha."px; left: ".$left_folha-$left_arvore+$padding_folha."px; top: ".$top_folha-$top_arvore+$padding_folha."px;'>".$id_secao."</div>"; 	
	$top_folha = $top_folha + ($altura_folha + $padding_folha);
	
	if ($nivel==0) {continue;}
	$itz = "<div id='secao_".$id_secao."' data-id-filho='".$id_secao."' data-nivel='".$nivel."' data-gemeo='folha_arvore_".$id_secao."' data-cor-nivel='".$cor_nivel[$nivel+1]."' data-cor-letra='".$cor_letra_nivel[$nivel+1]."' class='secao' style='background-color: ".$cor_nivel[$nivel+1]."; color: ".$cor_letra_nivel[$nivel+1]."; width: ".$largura_pai."px'>".$titulo."</div>";
	if (array_key_exists($indice_pai, $pais)){$pais[$indice_pai]=$pais[$indice_pai].$itz;} else 
		{
	$pais[$indice_pai]="<div id='pai_".$id_pai."' class='pai' data-id-pai='".$id_pai."' data-nivel='".$nivel."' style='background-color: ".$cor_nivel[$nivel]."; color: ".$cor_letra_nivel[$nivel]."; left: ".$left + $padding_pai."px; width: ".$largura_pai."px; top: ".$top_niveis."px;'><div class='titulo'>".$velho_titulo."</div>".$itz;
		}
$velho_titulo = $titulo;
	if ( array_key_exists($nivel, $niveis)) {} else 
		{
			$niveis[$nivel]="<div id='cabecalio_de_nivel_".$nivel."' class='cabecalio_de_nivel' style='background-color: ".$cor_nivel[$nivel+1]."; color: ".$cor_letra_nivel[$nivel+1]."; left: ".$left."px; width: ".$largura_nivel."px; height: ".$altura_cabecalio."px; top: ".$top_cabecalio."px'>Nível: ".$nivel."</div>"."<div id='nivel_".$nivel."' data-nivel='".$nivel."' class='nivel' style='background-color: ".$cor_nivel[$nivel+1]."; color: ".$cor_letra_nivel[$nivel+1].";  left: ".$left."px; width: ".$largura_nivel."px; top: ".$top_niveis."px; height: ".$height_niveis."px'>";
		}
//	echo "<tr><td>".$nivel."</td><td>".$id_secao."</td><td>".$id_pai."</td><td>".$titulo."</td></tr>"; 
    }
}
else { echo "<tr><td>Não tem nomes duplicados</td></tr>";}

foreach($niveis as $key => $level) {
	foreach($pais as $chave => $valor) {
		$indices = explode("-",$chave);
		//echo $indices[0]."-".$key."  ".$valor." + ";
		if ($key == $indices[0]){
			$niveis[$key]=$niveis[$key].$valor."</div>".retorna_blank($chave."_separador",$separador_de_pais);
		}		
	}
	$niveis[$key] = $niveis[$key] . retorna_blank($key."_bottom", $altura_blank);
}


foreach($niveis as $level){
	echo $level."</div>";
}

$largura_moldura = $max_folha-$min_folha+2*$padding_arvore;
$altura_moldura = $max_top_folha-$min_top_folha + 2*$padding_arvore;
if ($altura_moldura > $max_tamanho_arvore) {$altura_moldura = $max_tamanho_arvore;}
echo "<div id='flutua_para_direita' class='moldura' style=' width: ".$largura_moldura."px; height: ".$altura_moldura."px; left: ".$min_folha-$padding_arvore."px; top: ".$min_top_folha - $padding_arvore."px'>".$arvore."</div>";
//echo "</table>";

?>

<script>

var baixa_opacidade = 0.2;
var faixa_que_precisa_de_scroll = 2;

function flutua_para_direita(classe) {

const div_para_flutuar = document.getElementById(classe);

	let correcao= document.body.offsetWidth - div_para_flutuar.getBoundingClientRect().right;
	//alert(classe+" - screen avail "+screen.availWidth+" - document.offsetwidth"+document.body.offsetWidth + " - div para flutuar "+div_para_flutuar.getBoundingClientRect().right + " - "  +correcao);
	div_para_flutuar.style.left = parseInt(div_para_flutuar.style.left.replace("px","")) + correcao +"px";
//const collection4 = document.getElementsByClassName(classe+"_filho");
//
//for (let i = 0; i < collection4.length; i++) {
//	let itz = collection4[i];
//	itz.style.left = parseInt(itz.style.left.replace("px","")) + correcao + "px";
//}

}


function ajusta_scroll(){
const collection3 = document.getElementsByClassName("nivel");
for (let i = 0; i < collection3.length; i++) {
	collection3[i].scrollTop=document.getElementById("blank_"+collection3[i].getAttribute("data-nivel")+"_top").style.height.replace('px','');
}

}

function limpa_pais (nivel) {
const collection = document.getElementsByClassName("pai");
for (let i = 0; i < collection.length; i++) {
  if (collection[i].getAttribute("data-nivel") > nivel) { collection[i].style.opacity = baixa_opacidade;} else { collection[i].style.opacity = "1.0";};
}

}

setTimeout(function () {
limpa_pais(1);
flutua_para_direita("flutua_para_direita");
//ajusta_scroll();
const collection2 = document.getElementsByClassName("secao");
let velho_selecionado = document.getElementById("folha_arvore_corpo_tese");
for (let i = 0; i < collection2.length; i++) {
  let that = collection2[i].getAttribute("data-id-filho"); // se colocar var não funciona
  collection2[i].addEventListener("mousedown",function ()
		{
			let gemeo = document.getElementById(this.getAttribute("data-gemeo"));
			velho_selecionado.style.backgroundColor = velho_selecionado.getAttribute("data-cor-nivel"); // volta aa cor original 
			velho_selecionado.style.color = velho_selecionado.getAttribute("data-cor-letra"); // volta aa cor original 
			gemeo.style.backgroundColor="blue";
			gemeo.style.color="white";
			velho_selecionado = gemeo;

			div_moldura_arvore = document.getElementById("flutua_para_direita");
			div_moldura_arvore.scrollTop = gemeo.getBoundingClientRect().top + div_moldura_arvore.scrollTop - div_moldura_arvore.getBoundingClientRect().top;

			limpa_pais(this.getAttribute("data-nivel"));
			// alert(this.getAttribute("data-id-filho")+" - "+that + " + " + this.id);
			const pais = document.getElementsByClassName("pai");
			for (let j = 0; j < pais.length; j++){
				
				if (pais[j].getAttribute("data-id-pai") == that){
//alert(document.getElementById("blank_"+pais[j].getAttribute("data-nivel")+"_top").style.height.replace('px',''));					
					//alert(pais[j].id);
					pais[j].style.opacity = "1.0";
					div_nivel = document.getElementById("nivel_"+pais[j].getAttribute("data-nivel"));
					//alert((pais[j].getBoundingClientRect().top ) - div_nivel.getBoundingClientRect().top);
					div_nivel.scrollTop=(pais[j].getBoundingClientRect().top ) + div_nivel.scrollTop - div_nivel.getBoundingClientRect().top;
					
										
				}
			}
	
		}
);
}

}, 1000);

</script>

</body>
</html>
