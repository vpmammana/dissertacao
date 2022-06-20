<!DOCTYPE html>
<html>
<head>
	<title>
		Dissertação UOXI-WASH
	</title>
<style>
html {
  height: 100%; 
  width: 100%;
}
body {
  height: 100%; /* Se nao definir isso, o offsetHeight nao funciona e dah zero */
  width: 100%;
  overflow: hidden;
background-color: #923cb5;
background-image: linear-gradient(147deg, #923cb5 0%, #000000 74%);
}

.tabela_de_edicao {
	width: 100%;
}

textarea {
 width: 100%;
 box-sizing: border-box;
 font-size: 1rem;
 height: 100%;
}
.edita_secoes {
	background-color: gray;
	color: black;
	position: absolute;
	border: 3px solid lightblue;
	overflow: auto;
}
.hint_trechos{
	visibility: hidden;
	position: absolute;
	overflow: scroll;
	z-index: 2000;
	display: block;
	background-color: white;
	color: black;
	border: 2px solid yellow;
	font-size: 0.7rem;
}

.menu_principal {
	position: absolute;
	background-color: black;
	color: white;
	top: 0px;
	left: 0px;
	height: auto;
	width: 100%;
}

.itens_numerados_ou_nao * {
	vertical-align: top;
}

.check_na_table {
	width: 300px;
}
input[type=radio]
{
  /* Double-sized Checkboxes */
  float: left;
  -ms-transform: scale(1.5); /* IE */
  -moz-transform: scale(1.5); /* FF */
  -webkit-transform: scale(1.5); /* Safari and Chrome */
  -o-transform: scale(1.5); /* Opera */
  transform: scale(1.5);
  padding: 10px;
}
label{
  font-size: 100%;
  display: block;
  margin-left: 30px;
}

.blank {
	box-sizing: border-box;
	color: white;
	float: right;
	display: inline;
	visibility: hidden;
}

.div_para_padding {
	width: 90%;
	border: 1px solid blue;
	border-radius: 10px;
	background-color: #606060;
	color: white;
	padding-left: 10px;
	padding-right: 10px;
	text-align: left;
	border: 1px solid darkgray;

}

.cabecalio_de_nivel {
	border: 1px solid black;
	background-color: white;
	color: black;
	position: absolute;
}
.cabecalio_de_arvore {
	box-sizing: border-box;
	border: 1px solid black;
	background-color: black;
	color: white;
	position: -webkit-sticky; /* Safari & IE */
	position: sticky;
	top: 0;
	z-index: 1000;
}

.moldura {
	box-sizing: border-box;
	position: absolute;
	border: 1px solid black;
	background-color: lightgray;
	overflow: scroll;
	overflow-x: hidden;
}
.moldura_ts {
	box-sizing: border-box;
	position: absolute;
	border: 1px solid black;
	background-color: gray;
	overflow: auto;
	overflow-x: hidden;
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
	box-sizing: border-box;
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
	font-size: 1.4rem;
	font-weight: bold;
}
.secao {
	box-sizing: border-box;
	color: white;
	float: right;
	display: inline;
	padding-left: 10px;
}

.limita {
	width: 100%;
	overflow: scroll;
	height: 100%;
	display: block;
	text-overflow: clip;
	white-space: nowrap;
}

.folha_de_arvore {
	position: absolute;
	background-color: green;
	color: white;
	padding: 3px;
	overflow: auto;
	overflow-y: hidden;
	padding: 2px;
}

.pode_mostrar_trechos {
	display: block;
	text-overflow: clip;
	white-space: nowrap;
	overflow: hidden !important;
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */

}

.pode_mostrar_trechos::-webkit-scrollbar {
  display: none;
}

  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */


</style>
</head>
<body>
<?php

include "../php/identifica.php.cripto";
$database = "dissertacao";
$numero_de_colunas_de_radio_button = 10;

//echo "</table>";

include "../php/carrega_arvore.php";
?>
<script>

var modo_edicao = false;

var conta_tentativas_de_ajuste_de_tela=0;

var minima_largura_percentual_da_edicao = 0.2;

var x = 0; // aumenta com seta para direita e diminui com seta para esquerda
var y = 0; // aumenta com seta para baixo e diminui com seta para cima
var x_arvore=0; // indica posicao do cursor azul presente na arvore de secoes, gerado pelo movimento nos niveis 
var y_arvore=0;
var max_dir = 0;
var min_esq = 1000000000000000000;

var guarda_ultimo_visitado = [];



var borda_focalizada = "3px solid yellow";


var velho_focado; // parametros da ultima borda focalizada
var velha_borda_focalizada;
var velha_borda_de_nivel_focalizada;
var baixa_opacidade = 0.3;
var faixa_que_precisa_de_scroll = 2;
var padding_de_screen = 10; // evita que os elementos flutuantes encostem nas bordas da tela

var id_da_folha_onde_esta_flutuando;

var matriz_ganha_foco=[];

function coloca_setas_no_pai(){
const colecao_de_secoes = document.getElementsByClassName("secao");
for (let i = 0; i < colecao_de_secoes.length; i++) {
	var elemento = colecao_de_secoes[i].getAttribute("data-id-pai");
	//console.log("elemento -> " + elemento);
	if (document.getElementById("label_"+elemento) === null) {} else 
		{
			document.getElementById("label_"+elemento).innerHTML="&#10148;";
		}
}



}


function limpa_array(){
	for (i=0; i<matriz_ganha_foco.length; i++){
			matriz_ganha_foco[i][1].length = 0;
			matriz_ganha_foco[i].length = 0;
	}
	matriz_ganha_foco.length = 0;
}

function recarrega(tipo, radio, ){
var arrStr = encodeURIComponent(JSON.stringify(largura_niveis_array));
var param_filhos = document.getElementById("check_mostra_filhos").checked;

window.location.search = "&tipo_secao="+tipo+"&filhos="+param_filhos+"&json="+arrStr+"&fator_reducao="+fator_de_reducao_da_largura_da_arvore;
//var arrStr = encodeURIComponent(JSON.stringify(myArray));
//var resposta="";
//var param_filhos = document.getElementById("check_mostra_filhos").checked;
//var url='../php/carrega_arvore.php?tipo_secao='+tipo+'&filhos='+param_filhos;
//var oReq=new XMLHttpRequest();
//           oReq.open("GET", url, false);
//           oReq.onload = function (e) {
//		     limpa_array();
//document.removeChild(document.documentElement);	
//		     min_esq = 10000000000000000000000000;
//		     max_dir = 0;
//                     resposta=oReq.responseText;
//		     // let temp_html = document.getElementById("seletor").innerHTML;
//		     document.body.innerHTML=resposta;
////alert(radio);
//		     setTimeout(function () 
//				{
//					document.getElementById(radio).checked = true;
//					document.getElementById("check_mostra_filhos").checked = param_filhos;
//				}, 1000);
//			setTimeout(function () {inicializa();}, 1000);
//
//			//inicializa();
//
//                     }
//           oReq.send();
//
}

function maximiza_altura(classe){

const colecao = document.getElementsByClassName(classe);
for (let i = 0; i < colecao.length; i++) {
	colecao[i].style.height = Math.round(document.body.offsetHeight - colecao[i].getBoundingClientRect().top - 6 * padding_de_screen) + "px";
	//console.log(colecao[i].id);
} // for

} // fim maximiza_altura

function flutua_para_baixo(id_elemento, id_cabecalio) {

const div_para_flutuar = document.getElementById(id_elemento);
	div_para_flutuar.style.height = Math.floor((document.body.offsetHeight - parseInt(document.getElementById("menu_principal").getBoundingClientRect().height) - padding_de_screen) / 2) - document.getElementById(id_cabecalio).style.height.replace("px","") + "px" ;

	let correcao=  document.body.offsetHeight - div_para_flutuar.getBoundingClientRect().bottom ;
	div_para_flutuar.style.top = parseInt(div_para_flutuar.style.top.replace("px","")) + correcao - padding_de_screen +"px";

}

function flutua_para_cima(id_elemento, id_cabecalio) {

const div_para_flutuar = document.getElementById(id_elemento);
	div_para_flutuar.style.height = Math.floor(document.body.offsetHeight / 2) - document.getElementById(id_cabecalio).style.height.replace("px","") + "px";

	let correcao= document.getElementById("menu_principal").getBoundingClientRect().bottom - div_para_flutuar.getBoundingClientRect().top;
	div_para_flutuar.style.top = parseInt(div_para_flutuar.style.top.replace("px","")) + correcao + padding_de_screen +"px";

}

function flutua_para_cima_mantem_altura(id_elemento, id_cabecalio) {
//console.log(id_cabecalio);
const div_para_flutuar = document.getElementById(id_elemento);
let cabecalio_para_flutuar = document.getElementById(id_cabecalio);

//	div_para_flutuar.style.height = Math.floor(document.body.offsetHeight / 2) - document.getElementById(id_cabecalio).style.height.replace("px","") + "px";

	let correcao= document.getElementById("menu_principal").getBoundingClientRect().bottom - div_para_flutuar.getBoundingClientRect().top + parseInt(cabecalio_para_flutuar.style.height.replace("px",""));
	div_para_flutuar.style.top = parseInt(div_para_flutuar.style.top.replace("px","")) + correcao + padding_de_screen +"px";
	cabecalio_para_flutuar.style.top = parseInt(cabecalio_para_flutuar.style.top.replace("px","")) + correcao + padding_de_screen +"px";

}

function flutua_para_direita(id_elemento) {

const div_para_flutuar = document.getElementById(id_elemento);

	let correcao= document.body.offsetWidth - div_para_flutuar.getBoundingClientRect().right;
	//alert(id_elemento+" - screen avail "+screen.availWidth+" - document.offsetwidth"+document.body.offsetWidth + " - div para flutuar "+div_para_flutuar.getBoundingClientRect().right + " - "  +correcao);
	div_para_flutuar.style.left = parseInt(div_para_flutuar.style.left.replace("px","")) + correcao -padding_de_screen +"px";
//const collection4 = document.getElementsByClassName(id_elemento+"_filho");
//
//for (let i = 0; i < collection4.length; i++) {
//	let itz = collection4[i];
//	itz.style.left = parseInt(itz.style.left.replace("px","")) + correcao + "px";
//}

}


function teclado(e) {
let gemeo_atual=null;
	console.log("x: "+x+" y:"+y)
	if (modo_edicao == false ){
		e.preventDefault();
		e.stopPropagation();	
	}
		matriz_ganha_foco[x][1][y].style.border = velha_borda_focalizada;
		document.getElementById(matriz_ganha_foco[x][0]).style.border = velha_borda_de_nivel_focalizada;
		
		if (e.key == "1") {
			modo_edicao = true;
			document.getElementById("textarea_teclado").focus();
			
		;}
		if (e.key == "2") {
			modo_edicao = true;
			document.getElementById("textarea_mouse").focus();
			
		;}

		if (e.key == "Tab" && modo_edicao) {
			modo_edicao = false;
			return;
			
		;}
		
		if (modo_edicao == true) {return;}	
		
		if (e.key == "Home") {y=0;}
		if (e.key == "PageDown") {
			let proximo2 = x + 1;
			if (proximo2 > matriz_ganha_foco.length -1) {proximo2 = 0;}
			if (matriz_ganha_foco[proximo2][0].includes("nivel")){
				let contador2=y;
				let encontrou=0;
				console.log("encontrou: "+encontrou + " contador2: "+contador2);
				while ((encontrou <= y ) && (contador2 < matriz_ganha_foco[x][1].length -1) ) {
				let contador=0;
					while (contador <= matriz_ganha_foco[proximo2][1].length - 1){
					if (matriz_ganha_foco[proximo2][1][contador].getAttribute("data-id-pai") == matriz_ganha_foco[x][1][contador2].getAttribute("data-id-secao")){
						encontrou = contador2;
						console.log(contador +" @ " +matriz_ganha_foco[proximo2][1][contador].getAttribute("data-id-pai")+" _-_ "+contador2 + "&" +matriz_ganha_foco[x][1][contador2].getAttribute("data-id-secao") + " encontrou: "+ encontrou);
					}	
						contador++;
					}
				contador2++;

				}
				if (contador2 <= matriz_ganha_foco[x][1].length - 1) {y=encontrou;}
			}
		;}
		console.log("saiu");	
	
		if (e.key == "ArrowUp"	)  {y--; if (y < 0) {y=matriz_ganha_foco[x][1].length -1;} guarda_ultimo_visitado[x] = y;}
		if (e.key == "ArrowDown")  {y++; if (y > matriz_ganha_foco[x][1].length -1) {y=0;} guarda_ultimo_visitado[x] = y;}
		if (e.key == "ArrowLeft")  
			{
				let vem_antes = x - 1;
				if (vem_antes<0) {vem_antes = matriz_ganha_foco.length -1;}
				if (guarda_ultimo_visitado[vem_antes] == -1 || !matriz_ganha_foco[x][0].includes("nivel") || matriz_ganha_foco[x][0].includes("nivel_1") || e.shiftKey) 
				{
					do {x--;} while (guarda_ultimo_visitado[x] == -1); 
					if (x<0) {x=matriz_ganha_foco.length -1;}  
					y=guarda_ultimo_visitado[x]; 
					if (y == -2) {y=0;}
				}
				else 
				{
					//alert("retorno para o pai, dentro de um nivel");
					let conta_volta=0;
					let max_elementos_volta = matriz_ganha_foco[vem_antes][1].length; // eu acho que esse menos 1 nao deveria estar aqui e deve dar problema na ultima secao
					//console.log("max_elementos_volta: "+max_elementos_volta);
					while (conta_volta < max_elementos_volta && matriz_ganha_foco[x][1][y].getAttribute("data-id-pai") != matriz_ganha_foco[vem_antes][1][conta_volta].getAttribute("data-id-secao"))
						{
							conta_volta++;
							//console.log(conta_volta);
						}
					if (conta_volta < max_elementos_volta ) {x--; y=conta_volta;} else { alert("Nao achou o pai."); y=0;}
					if (x<0) {x=matriz_ganha_foco.length -1;} 					
				}
			} 
// -2 significa "nao foi visitado ainda"
// -1 signfica "nao tem filhos da secao do nivel superior selecionada, que no caso de ir para a esquerda significa subir de nivel ateh o nivel selecionado"
		if (e.key == "ArrowRight") 
			{
				let anterior = matriz_ganha_foco[x][1][y];
				if (matriz_ganha_foco[x][0].includes("nivel")) {
					gemeo_atual = document.getElementById(anterior.getAttribute("data-gemeo"));
				}
				let proximo = x + 1;
				if (proximo > matriz_ganha_foco.length -1) {proximo = 0;}
				if (!matriz_ganha_foco[proximo][0].includes("nivel") || matriz_ganha_foco[proximo][0].includes("nivel_1"))
					{ 
						// este if ocorre quando nao nivel, ou se eh nivel e o pai eh corpo_tese. O resultado eh ir para direita nos blocos de niveis (se for nivel 1) ou nas arvores. se for nivel 2 ou 3 eh outro tratamento
						{x++; if(x > matriz_ganha_foco.length - 1) {x=0;}  y = guarda_ultimo_visitado[x]; if (y == -2) {y=0;}}
					}
				else {

				let conta=0;
				let max_elementos = matriz_ganha_foco[proximo][1].length; // eu acho que esse menos 1 nao deveria estar aqui e deve dar problema na ultima secao
				//console.log("max_elementos: "+max_elementos);
				while (conta < max_elementos && matriz_ganha_foco[proximo][1][conta].getAttribute("data-id-pai") != anterior.getAttribute("data-id-secao"))
					{
						conta++;
						//console.log(conta);
					}
				if (conta < max_elementos ) {x++; y=conta;} 
				else {

					//guarda_ultimo_visitado[x] = y;
					while (matriz_ganha_foco[x][0].includes("nivel")) 
						{
							let proximo3 = x + 1;
							if (proximo3 > matriz_ganha_foco.length -1) {proximo3 = 0;}
							if (matriz_ganha_foco[proximo3][0].includes("nivel")) {guarda_ultimo_visitado[proximo3] = -1;} else {y=guarda_ultimo_visitado[proximo3];if (y == -2) {y=0;} }
							x++;
							if (x > matriz_ganha_foco.length - 1) { x=0;} 
						}
				}
				}	
			 		if (e.shiftKey) {y=guarda_ultimo_visitado[x]; if (y == -2) {y = 0;} } // se estiver apertando shift vai para ultimo visitado ao inves de ir para o primeiro filho do atual.	
					if (matriz_ganha_foco[x][0].includes("flutua_para_direita") && !e.shiftKey) { y=parseInt(gemeo_atual.getAttribute("data-y"));} 
			}
	
 
	
		if (x > matriz_ganha_foco.length - 1) { x=0;}
		if (x < 0) { x=matriz_ganha_foco.length -1;}
				

			
 
//		console.log("antes"  + x + " - " + matriz_ganha_foco[x][0] + " -> "+ matriz_ganha_foco[x][1][y].id + document.getElementById(matriz_ganha_foco[x][1][y].id).innerHTML );
		velha_borda_focalizada = matriz_ganha_foco[x][1][y].style.border;
		velha_borda_de_nivel_focalizada=document.getElementById(matriz_ganha_foco[x][0]).style.border;	
		document.getElementById(matriz_ganha_foco[x][0]).style.border = borda_focalizada;	
		matriz_ganha_foco[x][1][y].style.border = borda_focalizada;
		if (matriz_ganha_foco[x][0].includes("nivel")) { matriz_ganha_foco[x][1][y].click(); scroll_nivel(document.getElementById(matriz_ganha_foco[x][0]), matriz_ganha_foco[x][1][y]);}
		velho_focado = matriz_ganha_foco[x][1][y];
		let paizao = document.getElementById(matriz_ganha_foco[x][0]);

			if (matriz_ganha_foco[x][0].includes("flutua_para_direita")) {scroll_arvore_especial(paizao,matriz_ganha_foco[x][1][y]);}

//		document.getElementById(matriz_ganha_foco[x][0]).focus();

		let textarea_teclado = document.getElementById("textarea_teclado");
		let id_secao_teclado = document.getElementById("edita_secoes_teclado_id_secao");
		let id_pai_teclado = document.getElementById("edita_secoes_teclado_id_pai");

		let textarea_mouse = document.getElementById("textarea_mouse");
		let id_secao_mouse = document.getElementById("edita_secoes_mouse_id_secao");
		let id_pai_mouse = document.getElementById("edita_secoes_mouse_id_pai");

		if (matriz_ganha_foco[x][0].includes("nivel")){
			id_secao_teclado.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-secao");
			id_pai_teclado.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-pai");
			textarea_teclado.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-titulo");
		}
		if (matriz_ganha_foco[x][0].includes("flutua_para_direita")){
			id_secao_mouse.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-secao");
			id_pai_mouse.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-pai");
			textarea_mouse.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-titulo");
		}

} // fim teclado



function inicializa_teclado(){

document.body.addEventListener("keydown", teclado);

}	



function inicializa_folhas_de_trechos(){

const arvore_com_trechos = document.getElementsByClassName("contem_trechos");
for (let i = 0; i < arvore_com_trechos.length; i++) {

arvore_com_trechos[i].addEventListener("mouseout", 
	function ()
	{
		var that = this.id;
		setTimeout(function () {
			if (id_da_folha_onde_esta_flutuando == that){
			var hint = document.getElementById("hint_trechos");
			hint.style.visibility="hidden";}
			},1000);
			
	}
);

arvore_com_trechos[i].addEventListener("mouseover", 
	function ()
	{
		var hint = document.getElementById("hint_trechos");
//		var id_secao_mouse = document.getElementById("edita_secoes_mouse_id_secao");
//		var id_pai_mouse = document.getElementById("edita_secoes_mouse_id_pai");
//		var textarea_mouse = document.getElementById("textarea_mouse");

		id_da_folha_onde_esta_flutuando = this.id;
		
if (arvore_com_trechos[i].classList.contains("pode_mostrar_trechos"))	{hint.innerHTML="<b>"+arvore_com_trechos[i].getAttribute("data-id-chave")+") "+arvore_com_trechos[i].getAttribute("data-version-date")+"</b><br><b>"+arvore_com_trechos[i].getAttribute("data-id-secao")+"</b><br>" + arvore_com_trechos[i].getAttribute("data-titulo");}
else {hint.innerHTML="<b>"+arvore_com_trechos[i].getAttribute("data-id-chave")+") "+arvore_com_trechos[i].getAttribute("data-version-date")+"</b></br><b>"+arvore_com_trechos[i].getAttribute("data-id-secao")+"</b>";}
//		id_secao_mouse.innerHTML="<b>"+arvore_com_trechos[i].getAttribute("data-id-secao")+"</b>";
//		id_pai_mouse.innerHTML=arvore_com_trechos[i].getAttribute("data-id-pai");

//		textarea_mouse.innerHTML = arvore_com_trechos[i].getAttribute("data-titulo");
		hint.style.maxHeight=document.body.offsetHeight * 0.2 + "px"
		hint.style.maxWidth=document.body.offsetWidth * 0.2 + "px"
		hint.style.top=parseInt(this.getBoundingClientRect().top) - parseInt(hint.clientHeight) + "px";
		hint.style.left=parseInt(this.getBoundingClientRect().left) - parseInt(hint.clientWidth) + "px";
	
		hint.style.visibility="visible";
		//console.log(this.getBoundingClientRect().top + ' - ' +hint.clientHeight);
	});

}
} // fim inicializa_folhas_de_trechos


function percorre_arvore_trechos(mostra_trechos){

const arvore_com_trechos = document.getElementsByClassName("pode_mostrar_trechos");
for (let i = 0; i < arvore_com_trechos.length; i++) {
	     if (mostra_trechos) {
		arvore_com_trechos[i].innerHTML=arvore_com_trechos[i].getAttribute("data-titulo");
	     } else
	     {
	arvore_com_trechos[i].innerHTML=arvore_com_trechos[i].getAttribute("data-id-secao");

	     }
	}

} // fim percorre_arvore_trechos

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

function reduz_arvore(id_arvore, fator){
document.getElementById(id_arvore).style.width = document.getElementById(id_arvore).clientWidth * fator +"px" ;
const filhos = document.getElementById(id_arvore).children;

for (let m=0; m < filhos.length ; m++){
	console.log(filhos[m].id);
	
	filhos[m].style.width = filhos[m].clientWidth * fator + "px";
	filhos[m].style.height = filhos[m].clientheight * fator + "px";
	filhos[m].style.left = filhos[m].style.left.replace("px","") * fator + "px";
	if (m==0) {
		filhos[m].style.top = filhos[m].style.top.replace("px","") * fator + "px";
	} else
	{
		filhos[m].style.top = parseInt(filhos[m - 1].style.top.replace("px","")) + filhos[m-1].clientHeight + padding_folha + "px";
	
	}


	if (filhos[m].children.length == 0) {
	filhos[m].style.fontSize = filhos[m].clientHeight *0.8 * fator + "px";

	}
	if (filhos[m].children.length == 1) {
	filhos[m].children[0].style.fontSize = filhos[m].clientHeight *0.8 * fator + "px";
	} 
	if (filhos[m].children.length == 2) {
	filhos[m].children[0].style.transform = "scale(" + fator +  ")";
	filhos[m].children[0].style.padding = 4 * fator +  "px";
	filhos[m].children[1].style.fontSize = filhos[m].clientHeight *0.8 * fator + "px";
	} 


	
}


} // reduz_arvore()

function posiciona_edicao(max_dir, min_esq) {

let menu_princ = document.getElementById("menu_principal").clientHeight;
document.getElementById("edita_secoes_mouse").style.left = max_dir + padding_de_screen + "px";
document.getElementById("edita_secoes_mouse").style.width = (min_esq - max_dir - 2*padding_de_screen) + "px";
document.getElementById("edita_secoes_mouse").style.top = menu_princ +  (document.body.offsetHeight - menu_princ)/2  + padding_de_screen + "px";
document.getElementById("edita_secoes_mouse").style.height = (document.body.offsetHeight - menu_princ)/2 - 2*padding_de_screen + "px";

document.getElementById("edita_secoes_teclado").style.left = max_dir + padding_de_screen + "px";
document.getElementById("edita_secoes_teclado").style.width = (min_esq - max_dir - 2*padding_de_screen) + "px";
document.getElementById("edita_secoes_teclado").style.top = menu_princ + padding_de_screen + "px";
document.getElementById("edita_secoes_teclado").style.height = (document.body.offsetHeight - menu_princ)/2 - 2*padding_de_screen + "px";


}


function calcula_correcao_dos_niveis(max_dir, min_esq, excedente_percentual){
	
	
	let largura_disponivel = Math.floor((min_esq - (minima_largura_percentual_da_edicao+excedente_percentual) * document.body.offsetWidth) / (quantidade_total_de_niveis * 2 -1));

	let r;

 	largura_niveis_array[0] = 0;
	for (r = 0; r < quantidade_total_de_niveis; r++){
		if (r == 0) {largura_niveis_array[r+1] = largura_disponivel;} else {largura_niveis_array[r+1] = largura_disponivel * 2;}

	}

	recarrega(tipo_secao_selecionado_no_check,  radio_selecionado);

	
	
} // fim calcula_correcao_dos_niveis




function acha_dir_max_min_esq_niveis(){


console.log("TENTATIVA "+conta_tentativas_de_ajuste_de_tela);

const colecao_niveis = document.getElementsByClassName("nivel");
	for (let i = 0; i < colecao_niveis.length; i++) {
		if (max_dir < colecao_niveis[i].getBoundingClientRect().right) { max_dir = colecao_niveis[i].getBoundingClientRect().right;} 
	}

min_esq = document.getElementById("seletor").style.left.replace("px","");

if (min_esq > document.getElementById("flutua_para_direita").style.left.replace("px","")) {
	min_esq = document.getElementById("flutua_para_direita").style.left.replace("px",""); 
}


let largura_de_edicao = min_esq - max_dir;

if (largura_de_edicao < minima_largura_percentual_da_edicao * document.body.offsetWidth ) 
	{
		if (conta_tentativas_de_ajuste_de_tela > 1) { // este if nunca eh true porque na segunda tentativa o contador eh zerado porque eh feita uma chamada de location.reload
			alert('A tela é muito pequena para conseguir uma configuração ótima. Teremos que trabalhar desse jeito!');
		}
		if (conta_tentativas_de_ajuste_de_tela == 0 && fator_de_reducao_da_largura_da_arvore == 1)
		{
			fator_de_reducao_da_largura_da_arvore = 0.7;
			reduz_arvore("flutua_para_direita",fator_de_reducao_da_largura_da_arvore);
			reduz_arvore("seletor",fator_de_reducao_da_largura_da_arvore);
			flutua_para_direita("flutua_para_direita");
			flutua_para_direita("seletor");
			conta_tentativas_de_ajuste_de_tela++;	
			acha_dir_max_min_esq_niveis(); // atencao! recursao! eu sou foda
		}
		if (conta_tentativas_de_ajuste_de_tela == 1 || (conta_tentativas_de_ajuste_de_tela ==0 && fator_de_reducao_da_largura_da_arvore != 1))
		{
			conta_tentativas_de_ajuste_de_tela++;	
			calcula_correcao_dos_niveis(max_dir, min_esq, 0.025);			
		}
	}

if (largura_de_edicao > (minima_largura_percentual_da_edicao + 0.05 )* document.body.offsetWidth ) {
	calcula_correcao_dos_niveis(max_dir, min_esq, 0.025);		
}
 
 posiciona_edicao(max_dir, min_esq);


}

function acha_divs_que_ganham_foco(){
guarda_ultimo_visitado.length = 0;
const colecao_ganha_foco = document.getElementsByClassName("ganha_foco");
	for (let i = 0; i < colecao_ganha_foco.length; i++) {
	guarda_ultimo_visitado.push(-2);
// guarda_ultimo_visitado = -2 -> significa que ainda nao foi visitado
// guarda_ultimo_visitado = -1 -> significa que nao tem filhos do nivel pai
// guarda_ultimo_visitado > -1 -> eh o ultimo visitado

	
		var dupla_ganha_foco_e_filhos=[];
		dupla_ganha_foco_e_filhos.push(colecao_ganha_foco[i].id);
			const colecao_sub_ganha_foco = colecao_ganha_foco[i].getElementsByTagName("*");
			var matriz_sub_ganha_foco=[];
			for (let j = 0; j < colecao_sub_ganha_foco.length; j++) {
				if (colecao_sub_ganha_foco[j].classList.contains("sub_ganha_foco")){
					matriz_sub_ganha_foco.push(colecao_sub_ganha_foco[j]);
				}
			}
		dupla_ganha_foco_e_filhos.push(matriz_sub_ganha_foco);
		matriz_ganha_foco.push(dupla_ganha_foco_e_filhos);
	}


}

function scroll_arvore_especial(moldura_da_arvore, folha_da_arvore){
//alert("scroll_arvore_especial"); libere este alert para saber qual DIV do DOM estah chamando este scroll
let cabecalio = document.getElementById("cabecalio_seletor").clientHeight;

var itz = parseInt(folha_da_arvore.style.top.replace("px","")) + folha_da_arvore.clientHeight;

var itz2 =  moldura_da_arvore.clientHeight; 

var itz3 = parseInt(folha_da_arvore.style.top.replace("px",""));


//console.log("especiali itz: "+itz+" - itz2: "+ itz2);

if (itz3 - (moldura_da_arvore.scrollTop + cabecalio) < 0) {
	moldura_da_arvore.scrollTop = moldura_da_arvore.scrollTop + (itz3 - moldura_da_arvore.scrollTop - cabecalio);
	
}

if ( (itz - moldura_da_arvore.scrollTop)> (itz2 - folha_da_arvore.clientHeight)) {
	//console.log("itz2 "+itz2+ "folha_da_arvore: "+folha_da_arvore.clientHeight + " bateu embaixo" + (itz2 - folha_da_arvore.clientHeight));

moldura_da_arvore.scrollTop = itz - (itz2 - folha_da_arvore.clientHeight);

}

	
}

function scroll_nivel(moldura_nivel, secao){
console.log("scroll_nivel "+moldura_nivel.id + " secao:" + secao.id ); //libere este alerta para saber qual nivel estah chamando este scroll

//console.log("scroll_nivel ",secao," moldura: ",moldura_nivel);

//let cabecalio =  secao.getBoundingClientRect().height;  chama cabecalio porque representa um "ajuste" na posicao para tentar nao deixar a secao muito colada no topo da DIV quando scroll para cima, e por acaso height da secao funciona em alguns casos, mas nao quando a secao eh muito comprida
let cabecalio = secao.parentElement.children[0].getBoundingClientRect().height; // esta escolha de cabecalio eh bem melhor, porque escolhe a altura do div class=titulo, que eh bem mais controlada

//console.log(cabecalio + " - "+ secao.getBoundingClientRect().top + "quem eh: "+secao.parentElement.id);
var bottom_da_secao = secao.getBoundingClientRect().bottom;

//var altura_da_moldura =  moldura_nivel.clientHeight; 

var top_da_secao = parseInt(secao.getBoundingClientRect().top);

var top_da_moldura = moldura_nivel.getBoundingClientRect().top;

var bottom_da_moldura = moldura_nivel.getBoundingClientRect().bottom;

//console.log("especiali bottom_da_secao: "+bottom_da_secao+" - altura_da_moldura: "+ altura_da_moldura);

if (top_da_secao - (top_da_moldura) < 0) {
	moldura_nivel.scrollTop = moldura_nivel.scrollTop + (top_da_secao - top_da_moldura - cabecalio);
	
}

if ( (bottom_da_secao)> (bottom_da_moldura)) {

moldura_nivel.scrollTop = moldura_nivel.scrollTop + (bottom_da_secao - bottom_da_moldura + cabecalio);

}

	
} // fim scroll_nivel


function scroll_arvore(moldura_da_arvore, folha_da_arvore){
//	div_moldura_arvore.scrollTop = gemeu.getBoundingClientRect().top + div_moldura_arvore.scrollTop - div_moldura_arvore.getBoundingClientRect().top;
//
//console.log("simples: ",moldura_da_arvore.id, folha_da_arvore.id);
if (folha_da_arvore.getBoundingClientRect().bottom > moldura_da_arvore.getBoundingClientRect().bottom) {
	//console.log("bateu embaixo");
	moldura_da_arvore.scrollTop = moldura_da_arvore.scrollTop + (folha_da_arvore.getBoundingClientRect().bottom - moldura_da_arvore.getBoundingClientRect().bottom + 6 * folha_da_arvore.getBoundingClientRect().height);
}

if (folha_da_arvore.getBoundingClientRect().top < moldura_da_arvore.getBoundingClientRect().top) {
	//console.log("bateu em cima");
	moldura_da_arvore.scrollTop = moldura_da_arvore.scrollTop - (- folha_da_arvore.getBoundingClientRect().top + moldura_da_arvore.getBoundingClientRect().top + 6 * folha_da_arvore.getBoundingClientRect().height);
}
	
}

function inicializa(){

document.getElementById(radio_selecionado).checked=true;
document.getElementById("check_mostra_filhos").checked=mostra_filhos_check;
inicializa_teclado();
acha_divs_que_ganham_foco();
velha_borda_focalizada = matriz_ganha_foco[x][1][y].style.border;
velha_borda_de_nivel_focalizada=document.getElementById(matriz_ganha_foco[x][0]).style.border;

matriz_ganha_foco[x][1][y].style.border=borda_focalizada;

limpa_pais(1);
flutua_para_direita("flutua_para_direita");
flutua_para_baixo("flutua_para_direita", "cabecalio_flutua_para_direita");
flutua_para_direita("seletor");
flutua_para_cima("seletor", "cabecalio_seletor");
maximiza_altura('nivel');

coloca_setas_no_pai();
if (fator_de_reducao_da_largura_da_arvore != 1) {
			reduz_arvore("flutua_para_direita",fator_de_reducao_da_largura_da_arvore);
			reduz_arvore("seletor",fator_de_reducao_da_largura_da_arvore);
			flutua_para_direita("flutua_para_direita");
			flutua_para_direita("seletor");
}

inicializa_folhas_de_trechos();
//ajusta_scroll();
const collection2 = document.getElementsByClassName("secao");
let velho_selecionado = document.getElementById("folha_arvore_corpo_tese");
for (let i = 0; i < collection2.length; i++) {
  let that = collection2[i].getAttribute("data-id-filho"); // se colocar var não funciona
  let that2 = collection2[i];
  collection2[i].addEventListener("click",function ()
		{
			//console.log("crick chamou");
			let arvore = document.getElementById("flutua_para_direita");
			let gemeo = document.getElementById(that2.getAttribute("data-gemeo"));

			velho_selecionado.style.backgroundColor = velho_selecionado.getAttribute("data-cor-nivel"); // volta aa cor original 
			velho_selecionado.style.color = velho_selecionado.getAttribute("data-cor-letra"); // volta aa cor original 
			gemeo.style.backgroundColor="blue";
			gemeo.style.color="white";
			velho_selecionado = gemeo;
			scroll_arvore(arvore,gemeo);

			limpa_pais(that2.getAttribute("data-nivel"));
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

const percorre_niveis = document.getElementsByClassName("nivel");
for (let i = 0; i < percorre_niveis.length; i++) {
	//console.log(percorre_niveis[i]);
	flutua_para_cima_mantem_altura(percorre_niveis[i].id, "cabecalio_de_nivel_"+percorre_niveis[i].getAttribute("data-nivel"));

}

acha_dir_max_min_esq_niveis();
} // fim inicializa()


setTimeout(function () {inicializa();}, 1000);

</script>


</body>

</html>
