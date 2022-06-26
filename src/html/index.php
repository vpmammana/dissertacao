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

.tabela_de_edicao{
	width: 100%;
	text-align: left;
}

.tabela_de_edicao *{
	border: 1px solid black;
	border-spacing: 0;
	border-collapse: collapse;
	padding-left: 5px;
	padding-right: 5px;
	font-size: 1rem;
}

.tabela_de_edicao_sem_borda{
	width: 100%;
	text-align: left;
}

.tabela_de_edicao_sem_borda *{
	border: none;
	padding-left: 5px;
	padding-right: 5px;
	font-size: 1rem;
}

.retira_borda {
	border: none !important;
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
	font-size: 0.8rem;
	height: 100%;
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

.cursor_box {
	position: absolute;
	opacity: 0.4;
	background-color: gray;
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

.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    -webkit-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    visibility: hidden;
    border-radius: 25px;
    background-color: yellow;
    border: 1px solid black;
    height: 10%;
    width: 30%;
    font-size: 3vw;
    z-index: 10000;
    justify-content: center;
    display: flex;
    align-items: center;
}

.uma_versao {
	padding: 1px;
	position: absolute;
	background-color: yellow;
	color: black;
	border-radius: 0.4rem;
	text-align: center;
	display: block;	
}

.div_versoes {
	padding: 1px;
	font-size: 1rem;
	width: inherit;
	max-width: 100%;
	height: 100%;
	background-color: blue;
	color: white;
	overflow-y: hidden;
	overflow-x: scroll;
	border: 1px solid black;
	box-sizing: border-box;
	position: relative;
}

</style>
</head>
<body>
<div id="popup_gravando" class="popup">gravando...</div>

<?php

include "../php/identifica.php.cripto";
$database = "dissertacao";
$numero_de_colunas_de_radio_button = 10;

//echo "</table>";

include "../php/carrega_arvore.php";
?>
<script>

var debug = document.getElementById("edita_secoes_teclado");

var largura_do_botao_de_versao = '8';
var altura_do_botao_de_versao = '2';
var fonte_do_botao_de_versao = '1';
var separacao_do_botao_de_versao = '8';

var fator_fonte_versao = 1.3;
var unidade = 'rem';

var gemeo_atual_na_arvore=null;
var gemeo_atual_no_nivel=null;
var velho_gemeo_no_nivel = null;
var modo_edicao = false;
var textarea_em_edicao = null;
var versoes_em_edicao = null;
var conta_tentativas_de_ajuste_de_tela=0;

var popup_gravando = document.getElementById("popup_gravando");

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

function grava_trecho(id_chave_secao, id_secao, trecho, div_versoes, textarea){ // grava uma nova versao de secao
if (id_chave_secao <0) {alert("Você ainda não selecionou uma seção. Nada será feito."); return;}
popup_gravando.style.visibility = "visible";
setTimeout(function(){popup_gravando.style.visibility = "hidden";}, 2000);
var resposta="";
var url='../php/insere_novo_trecho.php?id_chave_secao='+id_chave_secao+'&trecho='+trecho;
var oReq=new XMLHttpRequest();
           oReq.open("GET", url, false);
           oReq.onload = function (e) {
                     resposta=oReq.responseText;
		     //alert(resposta);


			if (resposta.includes("Deu problema")){ alert(resposta);} else {

			carrega_versoes_scroll(div_versoes.id,  id_chave_secao, textarea);
			document.getElementById("secao_"+id_secao).setAttribute("data-titulo", trecho);
			document.getElementById("folha_arvore_"+id_secao).setAttribute("data-titulo", trecho);
			
			if (document.getElementById("check_mostra_trechos").checked) {
				document.getElementById("folha_arvore_"+id_secao).innerHTML = trecho;
			};

		 	     if (document.getElementById(radical_de_nucleo+id_secao) == null) // acha o ponto certo para inserir o novo trecho, sem ter que ficar buscando children  
				{
					document.getElementById("secao_"+id_secao).innerHTML = trecho;
					
				}
				else
				{
					document.getElementById(radical_de_nucleo+id_secao).innerHTML = trecho;
				}
			}
                     }
           oReq.send();


} // fim grava_trecho

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

function ajusta_bordas_do_selecionado(){
	
		velha_borda_focalizada = matriz_ganha_foco[x][1][y].style.border;
		velha_borda_de_nivel_focalizada=document.getElementById(matriz_ganha_foco[x][0]).style.border;	
		document.getElementById(matriz_ganha_foco[x][0]).style.border = borda_focalizada;	
		matriz_ganha_foco[x][1][y].style.border = borda_focalizada;
		if (matriz_ganha_foco[x][0].includes("nivel")) { matriz_ganha_foco[x][1][y].click(); scroll_nivel(document.getElementById(matriz_ganha_foco[x][0]), matriz_ganha_foco[x][1][y]);}

} // ajusta_bordas_do_selecionado

function carrega_versoes_scroll(div_versoes, id_chave_secao, textarea){
elemento = document.getElementById(div_versoes);


var resposta="";
var url='../php/devolve_divs_versoes.php?id_chave_secao='+id_chave_secao+'&largura='+largura_do_botao_de_versao+'&altura='+altura_do_botao_de_versao+'&fonte='+fonte_do_botao_de_versao+'&unidade='+unidade+'&fator_fonte='+fator_fonte_versao+'&separacao='+separacao_do_botao_de_versao+'&textarea='+textarea;
var oReq=new XMLHttpRequest();
           oReq.open("GET", url, false);
           oReq.onload = function (e) {
                     resposta=oReq.responseText;
		
		     elemento.innerHTML = resposta; 
	   }
           oReq.send();
}

function teclado(e) {
	console.log("x: "+x+" y:"+y)
	let edita_secoes_mouse_id_secao = document.getElementById("edita_secoes_mouse_id_secao").innerText;
	if (matriz_ganha_foco[x][0].includes("nivel")) {
		gemeo_atual_na_arvore = document.getElementById(matriz_ganha_foco[x][1][y].getAttribute("data-gemeo"));
	}
	if (matriz_ganha_foco[x][0].includes("flutua_para_direita")) {
		gemeo_atual_no_nivel = document.getElementById(matriz_ganha_foco[x][1][y].getAttribute("data-gemeo"));
	}

	if (modo_edicao == false ){
		e.preventDefault();
		e.stopPropagation();	
	}
		matriz_ganha_foco[x][1][y].style.border = velha_borda_focalizada;
		document.getElementById(matriz_ganha_foco[x][0]).style.border = velha_borda_de_nivel_focalizada;
		

		if (e.key == "Tab" && modo_edicao) {
			modo_edicao = false;
			ajusta_bordas_do_selecionado();
			if (textarea_em_edicao != null && versoes_em_edicao != null) {
				grava_trecho(textarea_em_edicao.getAttribute(`data-id-chave-secao`),  textarea_em_edicao.getAttribute(`data-id-secao`), textarea_em_edicao.value, versoes_em_edicao, textarea_em_edicao);
	
			} else {alert("Ocorreu erro XPTO.");}
			return;
			
		;}
		
		if (modo_edicao == true) {return;}	

		if (e.key == "1") {
			modo_edicao = true;
			textarea_em_edicao = document.getElementById("textarea_teclado");
			versoes_em_edicao = document.getElementById("versoes_teclado");
			textarea_em_edicao.focus();
			
		;}
		if (e.key == "2") {
			modo_edicao = true;
			textarea_em_edicao = document.getElementById("textarea_mouse");
			versoes_em_edicao = document.getElementById("versoes_mouse");
			textarea_em_edicao.focus();
			
		;}
		
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
	
		if (e.key == "ArrowUp"	)  
			{
				y--; 
				if (y < 0) {y=matriz_ganha_foco[x][1].length -1;} 
				guarda_ultimo_visitado[x] = y;
         			if (matriz_ganha_foco[x][0].includes("flutua_para_direita") && y==parseInt(gemeo_atual_na_arvore.getAttribute("data-y"))) {y--; if (y < 0) {y=matriz_ganha_foco[x][1].length -1;}}
         			if (matriz_ganha_foco[x][0].includes("nivel") && matriz_ganha_foco[x][1][y].getAttribute("data-id-secao") == edita_secoes_mouse_id_secao ) {y--; if (y < 0) {y=matriz_ganha_foco[x][1].length -1;}}


			}
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
					if (matriz_ganha_foco[x][0].includes("flutua_para_direita") && !e.shiftKey) { y=parseInt(gemeo_atual_na_arvore.getAttribute("data-y")); } 
			}
	
       		if (x > matriz_ganha_foco.length - 1) { x=0;} // estes ifs estavam depois dos 4 abaixo, mas parece mais lógico que fiquem aqui 
		if (x < 0) { x=matriz_ganha_foco.length -1;}

	        if (matriz_ganha_foco[x][0].includes("flutua_para_direita") && y==parseInt(gemeo_atual_na_arvore.getAttribute("data-y"))) {y++; if (y > matriz_ganha_foco[x][1].length -1) {y=0;}} // evita colocar no Box 2 algo que jah esta no BOX 1
         	if (matriz_ganha_foco[x][0].includes("nivel") && matriz_ganha_foco[x][1][y].getAttribute("data-id-secao") == edita_secoes_mouse_id_secao ) {y++; if (y > matriz_ganha_foco[x][1].length -1) {y=0;}} // evita o contrario

		if (matriz_ganha_foco[x][0].includes("nivel")) {
			gemeo_atual_na_arvore = document.getElementById(matriz_ganha_foco[x][1][y].getAttribute("data-gemeo"));
		}
		if (matriz_ganha_foco[x][0].includes("flutua_para_direita")) {
			gemeo_atual_no_nivel = document.getElementById(matriz_ganha_foco[x][1][y].getAttribute("data-gemeo"));
			velho_gemeo_no_nivel.style.opacity = "1.0";
			gemeo_atual_no_nivel.style.opacity = "0.3";
			velho_gemeo_no_nivel = gemeo_atual_no_nivel;
		}
	
		// ifs estavam aqui

			
 
//		console.log("antes"  + x + " - " + matriz_ganha_foco[x][0] + " -> "+ matriz_ganha_foco[x][1][y].id + document.getElementById(matriz_ganha_foco[x][1][y].id).innerHTML );

		ajusta_bordas_do_selecionado();
	
		


		velho_focado = matriz_ganha_foco[x][1][y];
		let paizao = document.getElementById(matriz_ganha_foco[x][0]);

			if (matriz_ganha_foco[x][0].includes("flutua_para_direita")) {scroll_arvore_especial(paizao,matriz_ganha_foco[x][1][y]);}

		//		document.getElementById(matriz_ganha_foco[x][0]).focus();

		let textarea_teclado = document.getElementById("textarea_teclado");
		let id_secao_teclado = document.getElementById("edita_secoes_teclado_id_secao");
		let id_pai_teclado = document.getElementById("edita_secoes_teclado_id_pai");
		//		let data_teclado = document.getElementById("edita_secoes_teclado_data");

		let textarea_mouse = document.getElementById("textarea_mouse");
		let id_secao_mouse = document.getElementById("edita_secoes_mouse_id_secao");
		let id_pai_mouse = document.getElementById("edita_secoes_mouse_id_pai");
		//		let data_mouse = document.getElementById("edita_secoes_mouse_data");

		if (matriz_ganha_foco[x][0].includes("nivel")){
			id_secao_teclado.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-secao");
			id_pai_teclado.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-pai");
			//			data_teclado.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-version-date").split(".")[0];
			textarea_teclado.value = matriz_ganha_foco[x][1][y].getAttribute("data-titulo");
			console.log("estou passando por aqui -> "+ textarea_teclado.id + " data-titulo -> " +  matriz_ganha_foco[x][1][y].getAttribute("data-titulo"));
			textarea_teclado.setAttribute("data-id-chave-secao", matriz_ganha_foco[x][1][y].getAttribute("data-id-chave"));
			textarea_teclado.setAttribute("data-id-secao", matriz_ganha_foco[x][1][y].getAttribute("data-id-secao"));
			carrega_versoes_scroll("versoes_teclado",  matriz_ganha_foco[x][1][y].getAttribute("data-id-chave"), "textarea_teclado");
		}
		if (matriz_ganha_foco[x][0].includes("flutua_para_direita")){
			id_secao_mouse.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-secao");
			id_pai_mouse.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-id-pai");
			//			data_mouse.innerHTML = matriz_ganha_foco[x][1][y].getAttribute("data-version-date").split(".")[0];
			textarea_mouse.value = matriz_ganha_foco[x][1][y].getAttribute("data-titulo");
			textarea_mouse.setAttribute("data-id-chave-secao", matriz_ganha_foco[x][1][y].getAttribute("data-id-chave"));
			textarea_mouse.setAttribute("data-id-secao", matriz_ganha_foco[x][1][y].getAttribute("data-id-secao"));
			carrega_versoes_scroll("versoes_mouse",  matriz_ganha_foco[x][1][y].getAttribute("data-id-chave"), "textarea_mouse");
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
		
if (arvore_com_trechos[i].classList.contains("pode_mostrar_trechos"))	{hint.innerHTML="<b>id("+arvore_com_trechos[i].getAttribute("data-id-chave")+") "+arvore_com_trechos[i].getAttribute("data-version-date")+"</b><br>versoes:"+arvore_com_trechos[i].getAttribute("data-conta-versoes")+"<br><b>"+arvore_com_trechos[i].getAttribute("data-id-secao")+"</b><br>" + arvore_com_trechos[i].getAttribute("data-titulo");}
else {hint.innerHTML="<b>("+arvore_com_trechos[i].getAttribute("data-id-chave")+") "+arvore_com_trechos[i].getAttribute("data-version-date")+"</b><br>versoes:"+arvore_com_trechos[i].getAttribute("data-conta-versoes")+"<br><b>"+arvore_com_trechos[i].getAttribute("data-id-secao")+"</b>";}
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

function simula_key_down(){
document.body.dispatchEvent(
  new KeyboardEvent("keydown", {
    key: "e",
    keyCode: 69, // example values.
    code: "KeyE", // put everything you need in this object.
    which: 69,
    shiftKey: false, // you don't need to include values
    ctrlKey: false,  // if you aren't going to use them.
    metaKey: false   // these are here for example's sake.
  })
);

}

function altura_scroll(){
// Creating invisible container
  const outer = document.createElement('div');
  outer.style.visibility = 'hidden';
  outer.style.overflow = 'scroll'; // forcing scrollbar to appear
  outer.style.msOverflowStyle = 'scrollbar'; // needed for WinJS apps
  document.body.appendChild(outer);

  // Creating inner element and placing it in the container
  const inner = document.createElement('div');
  outer.appendChild(inner);

  // Calculating difference between container's full width and the child width
  const scrollbarWidth = (outer.offsetWidth - inner.offsetWidth);

  // Removing temporary elements from the DOM
  outer.parentNode.removeChild(outer);

  return scrollbarWidth;
}

function refaz_tamanho_edita_secoes(div_edita_secoes, div_edita_secoes_2){
	let div = document.getElementById(div_edita_secoes);   // box1
	let div2 = document.getElementById(div_edita_secoes_2);// box2
//console.log(div);
//console.log(div2);
//console.log(div.children[0]);
//console.log(div2.children[0]);



cabecalio = div.children[0];   // cabecalio do box1
cabecalio2 = div2.children[0];  // cabecalio do box2 que pode nao existir na primeira rodada, porque o box2 soh tera versao depois que o cursor for no flutua_para_direita

	 cabecalio.style.fontSize = Math.round(div.clientHeight * 0.05) + "px"; // muda tamanho da fonte de Box 1
	cabecalio2.style.fontSize = Math.round(div.clientHeight * 0.05) + "px"; // muda o tamanho da fonte de Box2

//console.log(div.children[0].children[1]);  // tecle 1
//console.log(div2.children[0].children[0]); // tecle 2

      div.children[0].children[1].style.fontSize = Math.round(div.clientHeight * 0.05/2) + "px";// muda o tamanho da fonte de tecle 1  
      div2.children[0].children[0].style.fontSize = Math.round(div2.clientHeight * 0.05/2) + "px";// muda o tamanho da fonte de tecle 2  


const inputs = div.children[2].getElementsByTagName("input"); // prove um array com todos os botoes de box 1
// console.log(inputs);

let font_type_button = 0.03;
let font_dos_tds = 0.025;

let fonte_do_botao_grava_etc = Math.round(div.clientHeight * font_type_button);


let i;
let altura_div = div.children[2].children[0].children[0].children[1].children[0].children[0].children[0].offsetHeight; // esse aqui eh o cabecalio que nao existe para Box2 na primeira rodada
for (i = 0; i < inputs.length; i++){
	inputs[i].style.fontSize = Math.round(div.clientHeight * font_type_button) + "px"; // muda tamanho dos botoes de box 1
}
 // basta pegar o ultimo do loop


const inputs2 = div2.children[2].getElementsByTagName("input"); // prove um array com todos os botoes de box 2
console.log(inputs2);
for (i = 0; i < inputs2.length; i++){
	inputs2[i].style.fontSize = Math.round(div.clientHeight * font_type_button) + "px";
 
}

let tds_primeira_1 = div.children[1].children[0].children[0].getElementsByTagName("td"); // tds da primeira tabela, box 1
for (i = 0; i < tds_primeira_1.length; i++){
	tds_primeira_1[i].style.fontSize = Math.round(div.clientHeight * font_dos_tds) + "px"; // muda a fonte de todos os tds da primeira table do box 1
}

let tds_primeira_2 = div2.children[1].children[0].children[0].getElementsByTagName("td"); // tds da primeira tabela, box 2
for (i = 0; i < tds_primeira_2.length; i++){
	tds_primeira_2[i].style.fontSize = Math.round(div2.clientHeight * font_dos_tds) + "px"; // muda a fonte de todos os tds da primeira table do box 2
}
let altura_div_versoes = 0;
let font_percent = 0.03;
let altura_percent = 0.03;
	let cabecalio_div_versao =document.getElementsByClassName("cabecalio_versoes")[0];
	let cabecalio_div_versao2 =document.getElementsByClassName("cabecalio_versoes")[1];

let conta_divs_versao = 0;

const divs_que_mostram_versoes = div.children[2].children[0].children[0].children[1].children[0].children[0].children;
for (i = 1; i < divs_que_mostram_versoes.length; i++){ // tem que comecar no i=1 para nao pegar o cabecalio
	fonte_do_botao_de_versao = Math.round(div.clientHeight * font_percent);
	largura_do_botao_de_versao = 15 *Math.round(div.clientHeight * font_percent * 0.5); // ja corrige para as proximas cargas, porque esta funcao so ajusta o tamanho dos divs de data de versao presentes no box 1
	separacao_do_botao_de_versao = fonte_do_botao_de_versao;
	altura_do_botao_de_versao = Math.round(div.clientHeight * altura_percent * 2 * 1.2);
	unidade = "px";

	cabecalio_div_versao.style.height =  Math.round(div.clientHeight * altura_percent) + "px";
	cabecalio_div_versao.style.fontSize = fonte_do_botao_de_versao + "px";
	cabecalio_div_versao.style.top =  "0px";
	cabecalio_div_versao.style.left = "1px";
// os itens abaixo não funcionam na primeira vez... acaba que a utilidade de rodar isso aqui eh so estabelecer o parametros que vao ser usados por devolve_divs_versoes.php porque as linhas abaixo vao dar crash de qualquer jeito

	if (cabecalio_div_versao2 != null) {
		console.log(cabecalio_div_versao2);
		cabecalio_div_versao2.style.height =  Math.round(div.clientHeight * altura_percent) + "px";
		cabecalio_div_versao2.style.fontSize = fonte_do_botao_de_versao + "px";
		cabecalio_div_versao2.style.top =  "0px";
		cabecalio_div_versao2.style.left = "1px";
	}


	divs_que_mostram_versoes[i].style.fontSize = fonte_do_botao_de_versao + "px"; // divs amarelos que mostram as datas das versoes
	divs_que_mostram_versoes[i].style.width = largura_do_botao_de_versao + "px"; // divs amarelos que mostram as datas das versoes
	divs_que_mostram_versoes[i].style.height = altura_do_botao_de_versao * 1.2 + "px"; // divs amarelos que mostram as datas das versoes
	divs_que_mostram_versoes[i].style.top = document.getElementsByClassName("cabecalio_versoes")[0].style.fontSize.replace("px","") * fator_fonte_versao + "px"; ;
	divs_que_mostram_versoes[i].style.left = Math.round((i-1) * (largura_do_botao_de_versao + separacao_do_botao_de_versao ) + largura_do_botao_de_versao) + "px"; 
	altura_div_versoes = 	divs_que_mostram_versoes[i].offsetHeight;
	conta_divs_versao++;
}



//const divs_que_mostram_versoes2 = div2.children[2].children[0].children[0].children[1].children[0].children[0].children;
//for (i = 0; i < divs_que_mostram_versoes2.length; i++){
//	divs_que_mostram_versoes2[i].style.fontSize = Math.round(div.clientHeight * 0.01) + "px";
// 
//}

let linha_de_versoes = div.children[2].children[0].children[0].children[1]; 
let linha_de_versoes2 = div2.children[2].children[0].children[0].children[1];
//let alt_scroll = 0;
//let alt_scroll2 = 0;
let alt_scroll = altura_scroll();
let alt_scroll2 = altura_scroll();
linha_de_versoes.style.height =  Math.round(1.2 * altura_div_versoes + altura_div + alt_scroll) + "px"; 
linha_de_versoes2.style.height = Math.round(1.2 * altura_div_versoes + altura_div + alt_scroll2) + "px"; 
let ultima_table = div.children[2];
let ultima_table2 = div2.children[2];
let linha_1_box_1 = div.children[1].children[0].children[0].children[0];
let linha_2_box_1 = div.children[1].children[0].children[0].children[1];
let linha_1_box_2 = div2.children[1].children[0].children[0].children[0];
let linha_2_box_2 = div2.children[1].children[0].children[0].children[1];
let rebarba = div.getBoundingClientRect().bottom - ultima_table.getBoundingClientRect().bottom;
let rebarba2 = div2.getBoundingClientRect().bottom - ultima_table2.getBoundingClientRect().bottom;



let ajuste_padding = 35;
console.log(linha_1_box_1.clientHeight);

	let sobra = -ajuste_padding -rebarba + div.getBoundingClientRect().height - cabecalio.getBoundingClientRect().height - linha_1_box_1.getBoundingClientRect().height - linha_2_box_1.getBoundingClientRect().height - (ultima_table.getBoundingClientRect().height + alt_scroll); // menos cabecalio,  altura da primeira tabela e altura da ultima linha de versoes
	let sobra2 =-ajuste_padding -rebarba2 + div2.getBoundingClientRect().height - cabecalio2.getBoundingClientRect().height - linha_1_box_2.getBoundingClientRect().height - linha_2_box_2.getBoundingClientRect().height - (ultima_table2.getBoundingClientRect().height - alt_scroll2); // menos cabecalio,  altura da primeira tabela e altura da ultima linha de versoes


	document.getElementById("textarea_teclado").style.height= sobra + "px";
	document.getElementById("textarea_mouse").style.height= sobra2 + "px";
	document.getElementById("linha_chave_teclado").style.height= sobra + "px";
	document.getElementById("linha_chave_mouse").style.height= sobra2 + "px";
	document.getElementById("linha_chave_teclado").children[0].style.height= sobra + "px";
	document.getElementById("linha_chave_mouse").style.height= sobra2 + "px";
console.log(sobra);
//	div.children[1].style.height = sobra * 0.7 + "px";
//	div.children[2].style.height = sobra * 0.3 + "px";

// rebarba_chave busca dar conta de uma rebarba que surge entre o textarea e o td da table. Eu tentei mudar cellspacing e border-spacing para dar conta disso mas parece que os browsers reagem de forma diferente. Entao eh melhor medir essa rebarba e descontar da linha de versoes.

let rebarba_chave  = 	document.getElementById("linha_chave_teclado").getBoundingClientRect().height - document.getElementById("textarea_teclado").getBoundingClientRect().height;
let rebarba_chave2 = 	document.getElementById("linha_chave_mouse").getBoundingClientRect().height - document.getElementById("textarea_mouse").getBoundingClientRect().height;
// alert(rebarba_chave2);
linha_de_versoes.style.height =  linha_de_versoes.clientHeight - rebarba_chave  + "px"; 
linha_de_versoes2.style.height = linha_de_versoes2.clientHeight- rebarba_chave2 + "px";

	
}


function inicializa(){


document.getElementById(radio_selecionado).checked=true;
document.getElementById("check_mostra_filhos").checked=mostra_filhos_check;
inicializa_teclado();
acha_divs_que_ganham_foco();
velha_borda_focalizada = matriz_ganha_foco[x][1][y].style.border;
velha_borda_de_nivel_focalizada=document.getElementById(matriz_ganha_foco[x][0]).style.border;
velho_gemeo_no_nivel = matriz_ganha_foco[x][1][y];


matriz_ganha_foco[x][1][y].style.border=borda_focalizada;
if (matriz_ganha_foco[x][0].includes("nivel")) {
		gemeo_atual_na_arvore = document.getElementById(matriz_ganha_foco[x][1][y].getAttribute("data-gemeo"));
}
if (matriz_ganha_foco[x][0].includes("flutua_para_direita")) {
		gemeo_atual_no_nivel = document.getElementById(matriz_ganha_foco[x][1][y].getAttribute("data-gemeo"));
}
simula_key_down();

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
percorre_arvore_trechos(true)
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

			velho_selecionado.style.opacity = "1.0"; // volta aa cor original 
			gemeo.style.opacity             = "0.4";
			

//			velho_selecionado.style.backgroundColor = velho_selecionado.getAttribute("data-cor-nivel"); // volta aa cor original 
//			velho_selecionado.style.color = velho_selecionado.getAttribute("data-cor-letra"); // volta aa cor original 
//			gemeo.style.backgroundColor="blue";
//			gemeo.style.color="white";
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

setTimeout( function () {refaz_tamanho_edita_secoes("edita_secoes_teclado", "edita_secoes_mouse");}, 1000);
} // fim inicializa()


setTimeout(function () {inicializa();}, 1000);

</script>


</body>

</html>
