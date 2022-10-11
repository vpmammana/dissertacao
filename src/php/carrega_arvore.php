<?php

if(isset($_GET["tipo_secao"])){
  $param_tipo_secao= $_GET["tipo_secao"];
} else $param_tipo_secao = "topico";

if(isset($_GET["filhos"])){
  $param_filhos= $_GET["filhos"];
} else $param_filhos = "false";

if(isset($_GET["n_niveis"])){
  $param_n_niveis= $_GET["n_niveis"];
} else $param_n_niveis = "3";

if(isset($_GET["json"])){
  $param_json= $_GET["json"];
} else $param_json = "[0, 300, 650, 650, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500]";

if(isset($_GET["fator_reducao"])){
  $param_fator_reducao= $_GET["fator_reducao"];
} else $param_fator_reducao = "1";

if(isset($_GET["palavra_de_busca"])){
  $param_palavra_de_busca= $_GET["palavra_de_busca"];
} else $param_palavra_de_busca = "";


if(isset($_GET["x_cursor"])){
  $param_x_cursor= $_GET["x_cursor"];
} else $param_x_cursor = 0;

if(isset($_GET["y_cursor"])){
  $param_y_cursor= $_GET["y_cursor"];
} else $param_y_cursor = 0;

ini_set('max_execution_time', 300);


function tira_acento($estringue){

$nova_string = preg_replace(array("/(á|à|ã|â|ä)/","/(Á|À|Ã|Â|Ä)/","/(é|è|ê|ë)/","/(É|È|Ê|Ë)/","/(í|ì|î|ï)/","/(Í|Ì|Î|Ï)/","/(ó|ò|õ|ô|ö)/","/(Ó|Ò|Õ|Ô|Ö)/","/(ú|ù|û|ü)/","/(Ú|Ù|Û|Ü)/","/(ñ)/","/(Ñ)/"),explode(" ","a A e E i I o O u U n N"),$estringue);
return $nova_string;
}

$_GET["palavra_de_busca"]=""; // tem que limpar essa variavel para que nao carregue de novo com a mesma busca

$largura_niveis_array = json_decode($param_json);
$radical_de_nucleo ="nucleo_nivel_secao_"; // radicao do identificar de um nucleo de nivel. O nucleo de nivel eh onde estah o trecho trazido do banco de dados, sem as formatacoes

echo "
<script>


var str_palavra_de_busca = '';
var quantos_niveis_mostra = ".$param_n_niveis.";
var radical_de_nucleo = '".$radical_de_nucleo."';
var mostra_filhos_check = ".$param_filhos.";
var fator_de_reducao_da_largura_da_arvore = ".$param_fator_reducao.";
var tipo_secao_selecionado_no_check = '".$param_tipo_secao."';
var radio_selecionado='check_".$param_tipo_secao."';
var largura_niveis_array=[];
var x_sessao_anterior = ".$param_x_cursor."; // recupera a posicao do cursor da ultima sessao
var y_sessao_anterior = ".$param_y_cursor.";


//setTimeout(function () {inicializa();}, 1000);

";

for ($p=0; $p < sizeof($largura_niveis_array); $p++){
	echo "largura_niveis_array.push(".$largura_niveis_array[$p].");";
}


echo "</script>";
echo "
<input style='display: none' id='id_sobe_imagem' type='file' onchange=' var resposta=``;var nome_arquivo=this.value.replace(/^.*[\\\/]/, resposta); document.getElementById(`textarea_mouse`).value=nome_arquivo;if (this.files && this.files[0]){var fd= new FormData();var faili=`fileToUpload`;fd.append(faili,this.files[0],nome_arquivo);var xhr = new XMLHttpRequest();var pousti=`POST`;var nome_faili=`../php/grava_imagem.php`;xhr.open(pousti, nome_faili);xhr.onloadend= function(e) { resposta=xhr.responseText;  };xhr.send(fd);}'>

<div class='menu_principal' id='menu_principal'>
<table width = '100%'>
<tr>
<td>
<div>
<table>
<tr>
<td>
<input type='radio' id='radio_niveis_1' name='numero_de_niveis' value='1' 		onclick='quantos_niveis_mostra = this.value;recarrega(document.getElementById(radio_selecionado).value, radio_selecionado)'>1 nível</input> 
</td>
<td>
<input type='radio' id='radio_niveis_2' name='numero_de_niveis' value='2' 		onclick='quantos_niveis_mostra = this.value; recarrega(document.getElementById(radio_selecionado).value, radio_selecionado)'>2 níveis</input>
</td>
<td>
<input type='radio' id='radio_niveis_3' name='numero_de_niveis' value='3' 	checked onclick='quantos_niveis_mostra = this.value; recarrega(document.getElementById(radio_selecionado).value, radio_selecionado)'>3 níveis</input>
</td>
</tr>
<tr>
<td>
<input type='radio' id='radio_niveis_4' name='numero_de_niveis' value='4' 		onclick='quantos_niveis_mostra = this.value; recarrega(document.getElementById(radio_selecionado).value, radio_selecionado)'>4 níveis</input>
</td>
<td>
<input type='radio' id='radio_niveis_5' name='numero_de_niveis' value='5' 		onclick='quantos_niveis_mostra = this.value; recarrega(document.getElementById(radio_selecionado).value, radio_selecionado)'>5 níveis</input>
</td>
<td>
<input type='radio' id='radio_niveis_6' name='numero_de_niveis' value='6' 		onclick='quantos_niveis_mostra = this.value; recarrega(document.getElementById(radio_selecionado).value, radio_selecionado)'>6 níveis</input>
</td>
</tr>
</table>
</div>
</td>
<td>
<a href='manual.html' style='color: yellow; font-size: 2rem'>Tutorial</a>
</td>
<td>
<table id='table_de_busca' style='visibility: hidden'>
<tr style='height: 50%'>
<td>
<input id='palavra_de_busca' type='text' placeholder='palavra para buscar' value='".$param_palavra_de_busca."' onfocus='simula_key_down(`B`)' ><input id='botao_de_busca_palavra' type='button' value='busca' onclick='modo_busca=false; str_palavra_de_busca=document.getElementById(`palavra_de_busca`).value; document.getElementById(`check_raiz`).click()' />
</td>
</tr>
<tr style='height: 50%'>
<td id='conta_matches' style='color: white; height: 100%; visibility: hidden'>
teste
</td>
</tr>
</table>
</td>
<td>
<input id='selecionar_secoes' type='button' value='selecionar seções' onclick='toggle_mostra_marcadores();'>
</td>
<td>
<input id='apagar_mult_secoes' type='button' value='apagar seções selecionadas' style='visibility: hidden' onclick='transpoe_subarvore_recursivo(`lixeira`);'>
</td>
<td>
<table>
<tr>
<td>
<input id='grava_SQL' type='button' value='grava_backup_sql' onclick='grava_backup_sql();'>
</td>
</tr>
<tr>
<td>
<input id='Salva WORD' type='button' value='grava WORD DOCX' onclick='grava_word();'>
</td>
</tr>
</table>
</td>
<td>
<div style='float: right; display: table-row; padding-left: 10px'>
<table>
<tr>
<td><input type='button' value='Cria PDF Dissertacao/Tese' onclick='gera_mostra_pdf_tese()'></td>
</tr>
<tr>
<td><input type='button' value='Cria PDF Relatório'></td>
</tr>
</table>
</div>
</td>
</tr>
</table>
</div>

<div id='janela_referencias' class='janela_de_referencias'>

<table width='90%'>
<tr>
<td>Selecione a referência:</td>
</tr>
<tr>
<td>
						<div class='dropdown'>
                                                  <input type='text' 
                                                        id='drop_1_2' 
                                                        class='dropbtn' 
                                                        onfocusout='document.getElementById(`lista_1_2`).setAttribute(`data-keyup`,`inativo`);document.getElementById(`drop_1_2`).setAttribute(`data-selecionado`,`-1`); document.getElementById(`drop_1_2`).setAttribute(`data-n-itens`,`0`);' 
                                                        data-drop='lista_1_2'
                                                        data-momento='insercao'
														data-nome-secao='';
														data-nome-id-referencia='';
                                                        data-id='1'
                                                        data-max-itens='100'
                                                        data-banco='dissertacao' 
                                                        data-tabela='secoes'
                                                        data-campo='vamos_ver_se_eh_irrelevante' 
                                                        data-fkid='' 
                                                        data-default=''
                                                        data-fk-banco='dissertacao' 
                                                        data-fk-tabela='versoes' 
                                                        data-fk-id='vamos_ver_se_eh_irrelevante'
														data-fk-campo-mostrado='trecho'
                                                        data-selecionado='-1'
                                                        data-event-blur='NAO'
                                                        data-event-focus='NAO'
                                                        data-event-keyup='NAO'
                                                        data-n-itens='0'
							data-pai-de-todos-para-saber-scroll=''	
                                                        autocomplete='off'
                                                        data-nivel='0'
                                                  />
                                                
                                                 </div>
</td>
</tr>
</table>
		<div id='lista_1_2' class='dropdown-content'  data-keyup='inativo'></div>


<input type='button' style='position: absolute; left: 0px; bottom: 0px; margin: 20px' value='insere citação direta' onclick='document.getElementById(`janela_referencias`).style.visibility=`hidden`;insertAtCaret(textarea_em_edicao.id,` ([[`+document.getElementById(`drop_1_2`).getAttribute(`data-nome-id-referencia`).replace(/ /g,` `)+`]]) `); textarea_em_edicao.focus();'>
<input type='button' style='position: absolute; left: 0; right: 0; width: 10rem; margin-left: auto; margin-right: auto; margin-bottom: 20px; bottom: 0px; ' value='insere citação indireta' onclick='document.getElementById(`janela_referencias`).style.visibility=`hidden`;insertAtCaret(textarea_em_edicao.id,` [[`+document.getElementById(`drop_1_2`).getAttribute(`data-nome-id-referencia`).replace(/ [0-9]/,function(m){m=m.replace(/ /,` (`); return m;}).replace(/[0-9][0-9][a-z]*$/,function(m){m=m.replace(/$/,`)`); return m;}).replace(/,/g,``)+`]] `); textarea_em_edicao.focus();'>
<input type='button' style='position: absolute; right: 0px; bottom: 0px; margin: 20px' value='cancela' onclick='document.getElementById(`janela_referencias`).style.visibility=`hidden`;textarea_em_edicao.focus();'>
</div>


<div class='hint_trechos' id='hint_trechos'></div>
<div class='edita_secoes' id='edita_secoes_mouse'>
	<div class='cabecalio_de_arvore' style='font-size: 3rem; text-align: right; text-overflow: clip; display: block'><label style='color: red; display: run-in; margin-left: 30px; float: left; font-size: 1.5rem'>(tecle 2)</label>Box 2 <label style='color: yellow; display: run-in; margin-left: 0px; float: right'>&#8594;</label></div>
		<div id='externo_mouse' style='height: 70%'>
		<table class='tabela_de_edicao' style='height: 100%; max-width: 100%; width: 100%; border-collapse: collapse; padding: 0px; border-spacing: 0' cellspacing='0'>
			<tr style='height: 5%'>
				<td style='width: 50%'  >Seção:	</td>
				<td style='width: 50%'  >Pai:	</td>
			</tr>
			<tr style='height: 5%'>
				<td  id='edita_secoes_mouse_id_secao' style='font-weight: bold'>sem_selecao</td>
				<td  id='edita_secoes_mouse_id_pai'	></td>
			</tr>
			<tr id='linha_chave_mouse' style='height: 90%; border-spacing: 0px; line-height: 0px'>
				<td colspan='2' style=' padding: 0px; line-height: 0px; width'>
					<textarea data-id-chave-secao='-1' data-alterado='vazio' id='textarea_mouse' class='edicao_versao' style='background-color: lightgray'>
					</textarea>
				</td>
			</tr>
		</table>
		</div>
		<div style='height: 20%'>
		<table class='tabela_de_edicao_sem_borda' cellspacing='0' style='height: 100%; border: 1px solid black; width: 100%; border-collapse: collapse; border-spacing: 0'>
			<tr style='height: 20%; border: 1px solid black; line-height: 0px'>
				<td><input id='grava_textarea_mouse' type='button' value='grava' onclick='let temp_textarea=document.getElementById(`textarea_mouse`); grava_trecho(temp_textarea.getAttribute(`data-id-chave-secao`), document.getElementById(`versoes_mouse`), `textarea_mouse`),  temp_textarea.getAttribute(`data-id-secao`), temp_textarea.value); this.disabled=true'></td>
				<td><input id='botao_lixeira_mouse' type='button' value='lixeira' onclick='if (document.getElementById(`edita_secoes_mouse_id_secao`).innerText==`sem_selecao`){alert(`Você não selecionou uma seção na janela de Escolha do Box 2.`); return;}if (!confirm(`Tem certeza que você quer transferir esta seção para a lixeira?`)) {return;} transpoe_subarvore(document.getElementById(`edita_secoes_mouse_id_secao`).innerText,`lixeira`)'></td>
				<td><input id='botao_nova_secao_acima' type='button' value='antes' disabled onclick='if (document.getElementById(`edita_secoes_mouse_id_secao`).innerText==`sem_selecao`){alert(`Você não selecionou uma seção na janela de Escolha do Box 2.`); return;} if (!matriz_ganha_foco[x][0].includes(`seletor`)) {alert(`Você não está com o tipo de seção selecionada!`); return;} insere_nova_secao_a_esq(document.getElementById(`edita_secoes_mouse_id_secao`).innerText,matriz_ganha_foco[x][1][y].getAttribute(`data-id-tipo-secao`), document.getElementById(`textarea_mouse`).value)'></td>
				<td><input id='botao_nova_secao_abaixo' disabled type='button' value='depois' onclick='if (document.getElementById(`edita_secoes_mouse_id_secao`).innerText==`sem_selecao`){alert(`Você não selecionou uma seção na janela de Escolha do Box 2.`); return;} if (!matriz_ganha_foco[x][0].includes(`seletor`)) {alert(`Você não está com o tipo de seção selecionada!`); return;} insere_nova_secao_a_dir(document.getElementById(`edita_secoes_mouse_id_secao`).innerText, matriz_ganha_foco[x][1][y].getAttribute(`data-id-tipo-secao`), document.getElementById(`textarea_mouse`).value, matriz_ganha_foco[x][1][y].getAttribute(`data-nome-tipo-secao`))'></td>
				<td><input id='botao_nova_secao_dentro' type='button' value='dentro'  onclick='if (document.getElementById(`edita_secoes_mouse_id_secao`).innerText==`sem_selecao`){alert(`Você não selecionou uma seção na janela de Escolha do Box 2.`); return;} if (!matriz_ganha_foco[x][0].includes(`seletor`)) {alert(`Você não está com o tipo de seção selecionada!`); return;} insere_nova_secao_abaixo(document.getElementById(`edita_secoes_mouse_id_secao`).innerText,matriz_ganha_foco[x][1][y].getAttribute(`data-primeiro-filho`), document.getElementById(`textarea_mouse`).value);'></td>
				<td><input type='button' id='botao_sobe_imagem' value='arquivo' onclick='document.getElementById(`id_sobe_imagem`).click();' /></td>
			</tr>
			<tr style='height: 80%; border: 1px solid black'>
				<td style='height: 40%; width: 100%' colspan='6' ><div id='versoes_mouse' class='div_versoes' ></div></td>
			</tr>
		</table>	
		</div>
</div>
<div class='edita_secoes' id='edita_secoes_teclado'>
	<div class='cabecalio_de_arvore'   style='font-size: 3rem; ' ><label style='color: yellow; display: run-in; margin-left: 0px; float: left'>&#8592;</label> Box 1 <label style='color: red; display: run-in; margin-left: 30px; float: right; font-size: 1.5rem'>(tecle 1)</label></div>
	<div id='externo_teclado' style='height: 70%; padding: 0px'>
	<table class='tabela_de_edicao' cellspacing='0' style='height: 100%; border-collapse: collapse; padding: 0px; border-spacing: 0'>
			<tr style='height: 5%'>
				<td style='width: 50%'  >Seção:	</td>
				<td style='width: 50%'  >Pai:	</td>
			</tr>
			<tr style='height: 5%'>
				<td  id='edita_secoes_teclado_id_secao' style='font-weight: bold'>sem_selecao</td>
				<td  id='edita_secoes_teclado_id_pai'	></td>
			</tr>
		<tr  id='linha_chave_teclado' style='height: 90%; padding: 0px; border-spacing: 0px; line-height: 0px'>
			<td colspan='2' style=' padding: 0px' >
			<textarea data-id-chave-secao='-1' data-alterado='gravado' id='textarea_teclado'  class='edicao_versao' style='background-color: lightgray'>
			</textarea>
			</td>
		</tr>
	</table>	
	</div>
	<div style='height: 20%'>
		<table class='tabela_de_edicao_sem_borda' style='height: 100%; border: 1px solid black; width: 100%; border-collapse: collapse; border-spacing: 0' cellspacing='0'>
			<tr style='height: 20%; border: 1px solid black; line-height: 0px'>
				<td ><input id='grava_textarea_teclado' type='button' value='grava' onclick='let temp_textarea=document.getElementById(`textarea_teclado`); grava_trecho(temp_textarea.getAttribute(`data-id-chave-secao`), temp_textarea.getAttribute(`data-id-secao`, document.getElementById(`versoes_teclado`), `textarea_teclado`), temp_textarea.value); this.disabled=true'></td>
				<td ><input id='botao_lixeira_teclado' type='button' value='lixeira' value='lixeira' onclick='if (document.getElementById(`edita_secoes_teclado_id_secao`).innerText==`sem_selecao`){alert(`Você não selecionou uma seção nas janelas de níveis.`); return;} transpoe_subarvore(document.getElementById(`edita_secoes_teclado_id_secao`).innerText,`lixeira`)'></td>
				<td ><input id='separa_textarea_teclado' type='button' value='separa' onclick='retorna_texto_de_textarea();'></td>
				<td ><input id='junta_textarea_teclado' type='button' value='junta' onclick='junta_proximo();'></td>
				<td ><input type='button' value='sobe'></td>
				<td ><input type='button' value='desce'></td>
			</tr>
			<tr style='height: 80%; border: 1px solid black'>
				<td style='height: 40%; width: 100%;' colspan='6' ><div id='versoes_teclado' class='div_versoes' ></div></td>
			</tr>
		</table>	
	</div>
</div>
";

include "identifica.php.cripto";

$max_niveis=10;
$padding_niveis = 100;

$top_niveis = 50; // posicao da extremidade superior dos niveis
$left_geral = 20; // o ponto mais a esquerda dos niveis
$top_arvore = 200; // posicao da extremidade superior da arvore
$left_arvore = 1500; // extremida esquerda da arvore (vai ser alterado por flutua_para_direita)
$altura_cabecalio = 24;
$altura_cabecalio_arvore = 30;
$top_cabecalio = $top_niveis - $altura_cabecalio;
$height_niveis= 1000;
$height_pais = 100;
$largura_nivel= 400;
$largura_pai= $largura_nivel * 0.9;
$padding_nivel= 10;
$padding_pai = 10;
$altura_blank = 500;
$largura_folha = 350;
$altura_folha = 20;
$padding_folha = 10;
echo 
"<script>
var padding_folha = ".$padding_folha.";";

if ($param_tipo_secao == "raiz") {echo "document.getElementById('table_de_busca').style.visibility='visible';";}

echo "</script>";


$padding_arvore = 20;
$padding_arvore_ts = 20;
$divisao =  6;  // em que parte da largura da folha o nivel inferior comeca
$separador_de_pais = 15; // espaco de separacao entre pais
$max_tamanho_arvore = 1000;


$cor_nivel = array("#006633", "#008040", "#00994d", "#00b359", "#00cc66", "#00e673");
$cor_letra_nivel = array ("white","black","black","black","black","black");
//$cor_nivel = array("#000066", "#000080", "#000099", "#0000b3", "#0000cc", "#0000e6");
//$cor_letra_nivel = array ("white","white","white","white","white","white");

function retorna_num_letra_a($ordem){

	return chr($ordem + 64);
	
}

function retorna_style($propriedade, $valor, $id_secao){
	global $style;
	global $para; // assume tag de paragrafo, se for paragrafo
	global $barra_para;  // assume tag com barra paragrafo, para terminar a tag de paragrafo
	global $radical_de_nucleo;
	$regra="";
 	if ($propriedade == "eh_paragrafo"){
		if ($valor == "sim"){
			$para = "<p id='".$radical_de_nucleo.$id_secao."'>";
			$barra_para = "</p>";
		} else {
			$para = "";
			$barra_para = "";
		}
	}

	if ($propriedade == "margem_simetrica") {
		$regra ="padding-left: ".$valor."; padding-right: ".$valor."; ";	
	}
	

	if ($propriedade == "alinhamento") {
		if ($valor == "centro") {
			$regra = "text-align: center;";
		}
		if ($valor == "esquerda") {
			$regra = "text-align: left;";
		}
		if ($valor == "direita") {
			$regra = "text-align: right;";
		}
		if ($valor == "justificado") {
			$regra = "text-align: justify;";
		}
	}
	if ($propriedade == "tamanho_fonte"){
		$regra = " font-size: ".$valor."em; ";
	}
	if ($propriedade == "tipo_fonte") {
		if ($valor == "bold") {
			$regra = "font-weight: bold;";
		}
		if ($valor == "normal") {
			$regra = "font-weight: normal;";
		}
		if ($valor == "italico") {
			$regra = " font-style: italic;";
		}
		if ($valor == "normal") {
			$regra = " font-style: normal;";
		}

	}
$style=$style.$regra;

} // fim retorna_style


function retorna_blank($key, $altura_blank){
return "<div id='blank_".$key."' class='blank' style='height: ".$altura_blank."px'>blank</div>";

 //return "<div id='blank_".$key."' style='height: 500px'>".$key."</div>";
}

$arvore = "";
$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);


if ($param_tipo_secao == "raiz") {$sql="call mostra_documento_completo('".$param_tipo_secao."')";}
else {
	if ($param_filhos == "false") {$sql="call mostra_arvore_niveis_pais_seleciona_tipo('".$param_tipo_secao."');";} else 
	{$sql= "call mostra_arvore_niveis_pais_seleciona_tipos_com_filhos_esq_dir('".$param_tipo_secao."');";}
	//echo $sql;
}

$result=$conn->query("$sql");
$numero_registrados = $result->num_rows;
$niveis = [];
$pais = [];
// echo "<table>";
$velho_titulo = "Dissertacao";
$velho_nome_tipo_secao = "raiz";
$contagem_paragrafos=1;

$top_folha = $top_arvore + $altura_cabecalio;

$min_folha = 100000000; // o menor left de todas as folhas
$max_folha = 0;  // o maior right de todas as folhas (considerando right = left + largura)
$min_top_folha = 10000000; 
$max_top_folha = 0;

$conta_folhas =0;
$conta_imagem =0;
$conta_matches=0; // usado quando eh feita uma busca por string, para saber quantos matches foram encontrados.
if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
	$id_chave             = $row["id_chave_filho"];
	$conta_versoes        = $row["conta_versoes"]; 
	$nivel             = $row["nivel"]; 
	$id_secao             = $row["id_filho"]; 
	$id_pai             = $row["id_pai"]; 
//	$titulo             = $row titulo'  titulo eh a descricao da tabela secoes, ou seja, o texto completo
	$titulo             = $row["ultima_versao"]; // ultima_versao eh a ultima versao da secao, obtida da tabela versoes
	$data_versao        = $row["data"]; // data da ultima versao  
	$id_tipo_secao      = $row["id_nested_tipo_secao"]; 
	$nome_tipo_secao    = $row["nome_nested_tipo_secao"];
	$tem_filho	    = $row["tem_filho"];
	//$style="justify-content: space-between; font-size: 0.9rem;";
	$largura_pai = $largura_niveis_array[$nivel] * 0.95;	
	$conn3= new mysqli("localhost", $username, $pass, $database);
	if ($nivel > $param_n_niveis) {continue;} // determina quantos niveis vai mostrar, independentemente de quantos existam
	$sql3="call retorna_valores_de_propriedades_do_tipo_secao('".$nome_tipo_secao."');";
	$result3=$conn3->query("$sql3");
	$style="";
		if ($result3->num_rows>0){
		while ($row3=$result3->fetch_assoc()){
			$propriedade = $row3["nome_propriedade"];
			$valor       = $row3["nome_valor_discreto"];
			$tipo	     = $row3["nome_nested_tipo_secao"];
			retorna_style($propriedade, $valor, $id_secao);
			// echo "<script>alert('".$style."');</script>";

		}
	}

	$conn3->close();

	if ($nivel == 1 and $id_secao == "lixeira") {$eh_da_lixeira = "sim";} 
	if ($nivel == 1 and $id_secao != "lixeira") {$eh_da_lixeira = "nao";} // precisa saber se eh uma secao que estah dentro da lixeira para que nao possa ser jogada na lixeira de novo

	if ($velho_nome_tipo_secao != $nome_tipo_secao) {
		$contagem_paragrafos=1;
	} else {
		$contagem_paragrafos++;
	}

	$titulo_de_arvore = $titulo; // este titulo eh apenas para arvore, porque table dah problema na arvore	

	if ($nome_tipo_secao == "item_lista_num") {
		$titulo = "<table class='itens_numerados_ou_nao'><tr><td >".$contagem_paragrafos.")</td><td id='".$radical_de_nucleo.$id_secao."'>".$titulo."</td></tr></table>";
				
	}
	
	if ($nivel > $max_niveis) {echo "Excedeu número máximo de níveis (".$max_niveis.")!"; exit();}
	$left = 0;
	for ($k = 0; $k < $nivel; $k++){
		$left = $left + $largura_niveis_array[$k] + $padding_nivel;
	}
//	$left = ($largura_niveis_array[$nivel] + $padding_nivel)*($nivel - 1) + $left_geral;
	$indice_pai = $nivel."-".$id_pai;
//echo $nome_tipo_secao;	
        if ($top_folha < $min_top_folha) {$min_top_folha = $top_folha;}
        if (($top_folha + $altura_folha + $padding_folha) > $max_top_folha) {$max_top_folha = $top_folha + $altura_folha + $padding_folha;}	
	$left_folha = $left_arvore +  $nivel * $largura_folha/$divisao;

        if ($left_folha < $min_folha) {$min_folha = $left_folha;};	
        if (($left_folha + $largura_folha) > $max_folha) {$max_folha = $left_folha + $largura_folha;}	

	$zti1 = $left_folha-$left_arvore+$padding_folha;
	$zti2 = $top_folha-$top_arvore+$padding_folha;

// data-id-chave eh a chave primaria da tabela secoes
	$arvore = $arvore."<div id='folha_arvore_".$id_secao."' class='folha_de_arvore pode_mostrar_trechos  contem_trechos sub_ganha_foco' data-y='".$conta_folhas."' data-x='".$nivel."' data-nivel='".$nivel."' data-cor-nivel='".$cor_nivel[$nivel]."' data-cor-letra='".$cor_letra_nivel[$nivel]."' data-tem-filho='".$tem_filho."' data-id-secao='".$id_secao."' data-conta-versoes='".$conta_versoes."' data-nome-tipo-secao='".$nome_tipo_secao."' data-gemeo='secao_".$id_secao."' data-da-lixeira='".$eh_da_lixeira."' data-id-chave='".$id_chave."' data-version-date='".$data_versao."' data-id-pai='".$id_pai."' data-titulo='".$titulo_de_arvore."' style=' background-color: ".$cor_nivel[$nivel]."; color: ".$cor_letra_nivel[$nivel]."; width: ".$largura_folha."px; left: ".$zti1."px; top: ".$zti2."px;'  onclick='simula_key_down(`Escape`);'>".$id_secao."</div>"; // note a repeticao da propriedade de nivel com data-x e data-nivel -> apenas para nao ter que mudar um pedaco de codigo na function inicializa() do index.html 
	$conta_folhas++;
	$top_folha = $top_folha + ($altura_folha + $padding_folha);
	
	if ($nivel==0) { echo "<div  style='visibility: hidden' id='secao_".$id_secao."' data-id-filho='".$id_secao."' data-id-secao='".$id_secao."' data-id-pai='".$id_pai."' data-titulo='".$titulo_de_arvore."' data-nivel='".$nivel."' data-version-date='".$data_versao."' data-conta-versoes='".$conta_versoes."' data-id-chave='".$id_chave."' data-gemeo='folha_arvore_".$id_secao."' data-nome-tipo-secao='".$nome_tipo_secao."'  data-da-lixeira='".$eh_da_lixeira."'  class='secao sub_ganha_foco contem_trechos' ></div>";  continue;}
//&#10148;

	if ($nome_tipo_secao=="item_lista_num") {
		 $alinha="left"; $tamanho_fonte="1.1rem"; $border="none"; $estilo_fonte="normal";} else { $alinha="right"; $tamanho_fonte="0.9rem"; $border="none";$estilo_fonte="italic";
	}
	$velho_nome_tipo_secao = $nome_tipo_secao;

	if ($tem_filho == "NAO_TEM_FILHO") 
		{
			$border="none";
			$div_padding = "";
			$barra_div_padding = "";
			$espaco="";
			$back_ground_color = "background-color: ".$cor_nivel[$nivel+1]."; color: ".$cor_letra_nivel[$nivel+1]."; ";
			$largura_pai_efetivo = $largura_pai;
		} else 
		{

			
			$border = "1px solid darkblue";
			$back_ground_color = "";
			if ($para=="" && $nome_tipo_secao != "item_lista_num") // se nao houver paragrafo que eh o nucleo de informacao mais obvio, ou item_list, entao o nucleo de informacao passa a ser o div_padding	
				{$div_padding = "<div id='".$radical_de_nucleo.$id_secao."' class='div_para_padding'>";} else
				{$div_padding = "<div class='div_para_padding'>";}
			$barra_div_padding = "<label id='label_".$id_secao."' style='color: yellow; display: run-in; margin-left: 0px; float: right'></label>&nbsp&nbsp&nbsp</div>";
			$espaco = retorna_blank($id_secao."_separador_blank",$separador_de_pais);
			$largura_pai_efetivo = $largura_pai * 0.9;

		}
		if ($nome_tipo_secao =="imagem")
			{
				$conta_imagem++;
				$div_padding = "<div class='div_para_imagem'><img src='../../imagens/".$titulo."' width='100%'></div>";
				$para = "<div style='display: none'>";
				$barra_para = "</div>";
				$barra_div_padding="";
			}
		if ($nome_tipo_secao =="legenda_imagem")
			{
				$para = $para."Fig. ".$conta_imagem." - "; // note que a legenda de figura vai mostrar a numeração da imagem imediatamente anterior... 
			}

		if ($nome_tipo_secao == "tabela") {
				$tamanho_fonte = "0.7rem";
				$temp_tabela = "<table class='tabela_do_texto'>";
				$linhas_de_tabela = preg_split("/\\\\n|\n/", $titulo);
				$temp_tabela=$temp_tabela."<tr>";
				$conta_linhas=0;
				foreach($linhas_de_tabela as $linha){
					if (preg_match("/^----/",$linha)){continue;} 
					$linha_sem_r = preg_replace('/\\\r|\r/',"",$linha);
//					$linha_sem_r= $linha;
					$celulas = explode("|", $linha_sem_r);
					foreach($celulas as $celula){
						if ($conta_linhas >0) {
						$temp_tabela=$temp_tabela."<td>".$celula."</td>";
						}
						else
						{
						$temp_tabela=$temp_tabela."<th>".$celula."</th>";

						}

					}
				$temp_tabela=$temp_tabela."</tr>";
				$conta_linhas++;
				}
				$temp_tabela =  $temp_tabela."</table>";		
				$titulo=$temp_tabela;	
		}

// data-id-chave eh a chave primaria da tabela secoes

$temp_palavra_de_busca = tira_acento($param_palavra_de_busca); 
$temp_titulo = tira_acento($titulo);
if ( $param_palavra_de_busca =="" || preg_match("/".$temp_palavra_de_busca."/i", $temp_titulo)==1){
	$conta_matches++;
   if ($param_palavra_de_busca !="" && preg_match("/".$temp_palavra_de_busca."/i", $temp_titulo)==1) {
 	$titulo = preg_replace("/".$param_palavra_de_busca."/i", "<b>$0</b>", $titulo); // cria bold no matches
   }; 
	$itz = $espaco."<div id='secao_".$id_secao."' data-id-filho='".$id_secao."' data-id-secao='".$id_secao."' data-id-pai='".$id_pai."' data-tem-filho='".$tem_filho."' data-titulo='".$titulo_de_arvore."' data-nivel='".$nivel."' data-y='-1' data-version-date='".$data_versao."' data-conta-versoes='".$conta_versoes."' data-id-chave='".$id_chave."' data-gemeo='folha_arvore_".$id_secao."' data-nome-tipo-secao='".$nome_tipo_secao."'  data-da-lixeira='".$eh_da_lixeira."'  data-cor-nivel='".$cor_nivel[$nivel+1]."' data-cor-letra='".$cor_letra_nivel[$nivel+1]."' class='secao sub_ganha_foco contem_trechos' style='".$back_ground_color." width: ".$largura_pai_efetivo."px; ".$style."' onclick='simula_key_down(`Escape`);' >".$div_padding.$para.$titulo.$barra_para.$barra_div_padding."<input type='checkbox' class='seleciona_secao' id='marca_".$id_secao."' style='display: none' data-tem-filho='".$tem_filho."' onclick='lista_para_apagar.push(this.parentElement); this.disabled=true;'></div>"; // sao os elementos das janelas de niveis? data-y='-1' significa que ainda nao foi atribuído um indice data-y ao elemento da janela de niveis



	if (array_key_exists($indice_pai, $pais)){$pais[$indice_pai]=$pais[$indice_pai].$itz;} else 
		{
	$zti3 = $left + $padding_pai;
	$pais[$indice_pai]="<div id='pai_".$id_pai."' class='pai' data-id-pai='".$id_pai."' data-nivel='".$nivel."' style='background-color: ".$cor_nivel[$nivel]."; color: ".$cor_letra_nivel[$nivel]."; left: ".$zti3."px; width: ".$largura_pai."px; top: ".$top_niveis."px;'><div class='titulo'>".$velho_titulo."</div>".$itz;
		}
$velho_titulo = $titulo;
	if ( array_key_exists($nivel, $niveis)) {} else 
		{
			$niveis[$nivel]="<div id='cabecalio_de_nivel_".$nivel."' class='cabecalio_de_nivel' style='background-color: ".$cor_nivel[$nivel+1]."; color: ".$cor_letra_nivel[$nivel+1]."; left: ".$left."px; width: ".$largura_niveis_array[$nivel]."px; height: ".$altura_cabecalio."px; top: ".$top_cabecalio."px'>Nível: ".$nivel." (Escolha Box 1)</div>"."<div id='nivel_".$nivel."' data-nivel='".$nivel."' class='nivel ganha_foco' style='background-color: ".$cor_nivel[$nivel+1]."; color: ".$cor_letra_nivel[$nivel+1].";  left: ".$left."px; width: ".$largura_niveis_array[$nivel]."px; top: ".$top_niveis."px; height: ".$height_niveis."px'>";
		}
}
//	echo "<tr><td>".$nivel."</td><td>".$id_secao."</td><td>".$id_pai."</td><td>".$titulo."</td></tr>"; 
    } //fim do while
if ($conta_matches ==0) {
echo "<script>alert('Nao foi encontrado o padrão: ".$param_palavra_de_busca."'); recarrega('raiz', 'dummy_radio');document.getElementById('conta_matches').innerHTML='Não foram encontradas seções contendo a palavra \"".$param_palavra_de_busca."\" no tipo \"".$param_tipo_secao."\".'; document.getElementById('conta_matches').style.visibility='visible';</script>";
}
else
{
	if ($param_palavra_de_busca == "") {
		echo "<script>document.getElementById('conta_matches').innerHTML='O tipo \"".$param_tipo_secao."\" tem ".$conta_matches." seções.'; document.getElementById('conta_matches').style.visibility='visible';</script>";
	} else
	{
		echo "<script>document.getElementById('conta_matches').innerHTML='Foram encontradas ".$conta_matches." seções contendo a palavra ".$param_palavra_de_busca." no tipo \"".$para_tipo_secao."\".'; document.getElementById('conta_matches').style.visibility='visible';</script>";
	}
}
}
else { echo "<tr><td>Não tem nomes duplicados</td></tr>";}

echo "<script>var quantidade_total_de_niveis=".sizeof($niveis)."; </script>";

foreach($niveis as $key => $level) {
	foreach($pais as $chave => $valor) {
		$indices = explode("-",$chave);
		//echo $indices[0]."-".$key."  ".$valor." + ";
		if ($key == $indices[0]){
			$niveis[$key]=$niveis[$key].$valor.retorna_blank("interno_".$chave."_separador",$separador_de_pais)."</div>".retorna_blank($chave."_separador",$separador_de_pais);
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

$zti4 = $min_folha-$padding_arvore;
$zti5 = $min_top_folha - $padding_arvore;

echo "<div id='flutua_para_direita' class='moldura ganha_foco' style=' width: ".$largura_moldura."px; height: ".$altura_moldura."px; left: ".$zti4."px; top: ".$zti5."px'  onclick='simula_key_down(`Escape`);'><div id='cabecalio_flutua_para_direita' class='cabecalio_de_arvore' style='width: ".$largura_moldura."px; height: ".$altura_cabecalio."px;'><label  style='color: yellow; display: run-in; margin-left: 0px; float: left; font-weight: bold; font-size: 1rem; padding-top: 0px'>Escolha Box 2</label><div style='top: 0px; right: 40px; position: absolute'><input type='checkbox'  id='check_mostra_trechos' onclick='percorre_arvore_trechos(this.checked)' checked>Mostra Trechos</input></div></div>".$arvore."</div>";
//echo "</table>";
$conn->next_result();

$conn->close();

// ARVORE DE TIPOS PARA SELECIONAR

$min_folha_ts = 100000000; // o menor left de todas as folhas
$max_folha_ts = 0;  // o maior right de todas as folhas (considerando right = left + largura)
$min_top_folha_ts = 10000000;
$max_top_folha_ts = 0;
$largura_folha_ts = 350;
$altura_folha_ts = 20;
$divisao_ts = 5; // fracao da largura da folha para tab de nivel
$max_tamanho_arvore_ts = 500;
$cor_nivel_tipos_secoes = array("#3366ff", "#4d79ff", "#668cff", "#809fff", "#99b3ff", "#b3c6ff");
$cor_letra_nivel_tipos_secoes = array ("black","black","black","black","black","black");
$left_arvore_ts = 1500; // extremida esquerda da arvore (vai ser alterado por flutua_para_direita) - o ts significa tipo_secao
$top_arvore_ts = 200; // posicao da extremidade superior da arvore
$padding_folha_ts = 10;
$top_folha_ts = $top_arvore_ts + $altura_cabecalio_arvore;



//$sql="select nome_nested_tipo_secao, id_chave_nested_tipo_secao from nested_tipos_secoes order by id_chave_nested_tipo_secao";
$sql = "call mostra_arvore_niveis_tipos_secoes_com_pai();";

$conn2= new mysqli("localhost", $username, $pass, $database);

// $top_folha_ts e demais _ts estao definidos em index.php

$result=$conn2->query("$sql");
$conta=0;
$conta_colunas=0;
$arvore_tipos = "";
if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
        $id             = $row["id_tipo_secao"];
        $nome             = $row["nome_secao_tipo_secao"];
        $nivel             = $row["nivel"];
	$pai 			= $row["pai"];

        if ($nome == $param_tipo_secao) {$checado="checked";} else {$checado="";}
        if ($top_folha_ts < $min_top_folha_ts) {$min_top_folha_ts = $top_folha_ts;}
        if (($top_folha_ts + $altura_folha_ts + $padding_folha_ts) > $max_top_folha_ts) {$max_top_folha_ts = $top_folha_ts + $altura_folha_ts + $padding_folha_ts;}

        $left_folha_ts = $left_arvore_ts +  $nivel * $largura_folha_ts/$divisao_ts;

        if ($left_folha_ts < $min_folha_ts) {$min_folha_ts = $left_folha_ts;};
        if (($left_folha_ts + $largura_folha_ts) > $max_folha_ts) {$max_folha_ts = $left_folha_ts + $largura_folha_ts;}

	if ($nome == "raiz") {
		$miolo_folha = "<input type='radio'  name='secao' id='check_".$nome."' class='selecao_do_tipo' value='".$nome."' ".$checado." onclick='recarrega(`".$nome."`, this.id);'><label>&nbsp&nbsp".$nome."</label></input>";
	} else
	{
		$miolo_folha = "<input type='radio'  name='secao' id='check_".$nome."' class='selecao_do_tipo' value='".$nome."' ".$checado." onclick='recarrega(`".$nome."`, this.id);'><label>&nbsp&nbsp".$nome."</label></input>"; 
	}

	$zti6 = $left_folha_ts-$left_arvore_ts+$padding_folha_ts;
	$zti7 = $top_folha_ts-$top_arvore_ts+$padding_folha_ts;

        $arvore_tipos = $arvore_tipos."<div id='folha_arvore_tipos_secoes_".$id."' data-id-tipo-secao='".$id."' data-primeiro-filho='sem_filhos_registrados' class='folha_de_arvore sub_ganha_foco arvore_de_tipos' data-id-secao='".$nome."' data-nome-tipo-secao='".$nome."' data-cor-nivel='".$cor_nivel_tipos_secoes[$nivel]."' data-id-pai='".$pai."' data-cor-letra='".$cor_letra_nivel_tipos_secoes[$nivel]."' style=' background-color: ".$cor_nivel_tipos_secoes[$nivel]."; color: ".$cor_letra_nivel_tipos_secoes[$nivel]."; width: ".$largura_folha_ts."px; left: ".$zti6."px; top: ".$zti7."px;'  onclick='simula_key_down(`Escape`);'>".$miolo_folha."</div>";
        $top_folha_ts = $top_folha_ts + ($altura_folha_ts + $padding_folha_ts);


//      echo "<td class='check_na_table'><input type='radio'  name='secao' id='check_".$id."' value='".$nome."' ".$checado." onclick='recarrega(`".$nome."`, this.id);'><label>&nbsp&nbsp".$nome."</label></input></td>";       
        $conta++;
        $conta_colunas++;
        //if ($conta_colunas > $numero_de_colunas_de_radio_button) {
        //        $conta_colunas=0;
        //        echo "</tr><tr>";
        //}
        }
}

$largura_moldura_ts = $max_folha_ts-$min_folha_ts+2*$padding_arvore_ts;
$altura_moldura_ts = $max_top_folha_ts-$min_top_folha_ts + 2*$padding_arvore_ts;
if ($altura_moldura_ts > $max_tamanho_arvore_ts) {$altura_moldura_ts = $max_tamanho_arvore_ts;}

$zti8 =$min_folha_ts-$padding_arvore_ts;
$zti9 =$min_top_folha_ts - $padding_arvore_ts - $altura_cabecalio_arvore;

echo "
<div id='seletor' class='moldura_ts ganha_foco' style=' width: ".$largura_moldura_ts."px; height: ".$altura_moldura_ts."px; left: ".$zti8."px; top: ".$zti9."px' onclick='simula_key_down(`Escape`);'><div id='cabecalio_seletor' class='cabecalio_de_arvore' style=' width: ".$largura_moldura_ts."px; height: ".$altura_cabecalio_arvore."px;'><label style='color: yellow; display: run-in; margin-left: 0px; float: left; font-weight: bold; font-size: 1rem; padding-top: 0px'>Escolha o tipo de seção:</label><div style='top: 0px; right: 40px; position: absolute'><input type='checkbox' id='check_mostra_filhos' >Mostra Folhas</input></div></div>
".$arvore_tipos."</div>";
$conn2->next_result();
$conn2->close();
?>


