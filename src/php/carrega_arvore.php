<?php

if(isset($_GET["tipo_secao"])){
  $param_tipo_secao= $_GET["tipo_secao"];
} else $param_tipo_secao = "topico";

if(isset($_GET["filhos"])){
  $param_filhos= $_GET["filhos"];
} else $param_filhos = "false";

if(isset($_GET["json"])){
  $param_json= $_GET["json"];
} else $param_json = "[0, 300, 650, 650, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500]";

if(isset($_GET["fator_reducao"])){
  $param_fator_reducao= $_GET["fator_reducao"];
} else $param_fator_reducao = "1";


$largura_niveis_array = json_decode($param_json);

echo "
<script>
var mostra_filhos_check = ".$param_filhos.";
var fator_de_reducao_da_largura_da_arvore = ".$param_fator_reducao.";
var tipo_secao_selecionado_no_check = '".$param_tipo_secao."';
var radio_selecionado='check_".$param_tipo_secao."';
var largura_niveis_array=[];
";

for ($p=0; $p < sizeof($largura_niveis_array); $p++){
	echo "largura_niveis_array.push(".$largura_niveis_array[$p].");";
}
echo "</script>";
echo "<div class='menu_principal' id='menu_principal'>
<table>
<br>
<tr>
<td>
<input type='button' value='mostra edição'>
</td>
<td>
<input type='button' value='mostra árvore de seções'>
</td>
<td>
<input type='button' value='mostra árvore de tipos de seções'>
</td>
</tr>
</table>
<br>
</div>
<div class='hint_trechos' id='hint_trechos'></div>
<div class='edita_secoes' id='edita_secoes_mouse'>
	<div class='cabecalio_de_arvore' style='font-size: 3rem; text-align: right; text-overflow: clip; display: block'><label style='color: red; display: run-in; margin-left: 30px; float: left; font-size: 1.5rem'>(tecle 2)</label>Box 2 <label style='color: yellow; display: run-in; margin-left: 0px; float: right'>&#8594;</label></div>
		<div style='height: 70%'>
		<table class='tabela_de_edicao' style='height: 100%'>
			<tr style='height: 5%'>
				<td style='width: 50%'  >Seção:	</td>
				<td style='width: 50%'  >Pai:	</td>
			</tr>
			<tr style='height: 5%'>
				<td  id='edita_secoes_mouse_id_secao' style='font-weight: bold'></td>
				<td  id='edita_secoes_mouse_id_pai'	></td>
			</tr>
			<tr style='height: 90%'>
				<td colspan='2'>
					<textarea data-id-chave-secao='-1' id='textarea_mouse' >
					</textarea>
				</td>
			</tr>
		</table>
		</div>
		<div style='height: 10%'>
		<table class='tabela_de_edicao_sem_borda'>
			<tr>
				<td><input type='button' value='grava' onclick='let temp_textarea=document.getElementById(`textarea_mouse`); grava_trecho(temp_textarea.getAttribute(`data-id-chave-secao`), temp_textarea.value);'></td>
				<td><input type='button' value='lixeira'></td>
				<td><input type='button' value='separa'></td>
				<td><input type='button' value='junta'></td>
				<td><input type='button' value='sobe'></td>
				<td><input type='button' value='desce'></td>
			</tr>
			<tr>
				<td id='edita_secoes_mouse_data' colspan='6'></td>
			</tr>
		</table>	
		</div>
</div>
<div class='edita_secoes' id='edita_secoes_teclado'>
	<div class='cabecalio_de_arvore'   style='font-size: 3rem' ><label style='color: yellow; display: run-in; margin-left: 0px; float: left'>&#8592;</label> Box 1 <label style='color: red; display: run-in; margin-left: 30px; float: right; font-size: 1.5rem'>(tecle 1)</label></div>
	<div style='height: 70%'>
	<table class='tabela_de_edicao_sem_borda' style='height: 100%'>
			<tr style='height: 5%'>
				<td style='width: 50%'  >Seção:	</td>
				<td style='width: 50%'  >Pai:	</td>
			</tr>
			<tr style='height: 5%'>
				<td  id='edita_secoes_teclado_id_secao' style='font-weight: bold'></td>
				<td  id='edita_secoes_teclado_id_pai'	></td>
			</tr>
		<tr style='height: 90%'>
			<td colspan='2'>
			<textarea data-id-chave-secao='-1'  id='textarea_teclado' rows='10'>
			</textarea>
			</td>
		</tr>
	</table>	
	</div>
		<div style='height: 10%'>
		<table class='tabela_de_edicao_sem_borda'>
			<tr>
				<td><input type='button' value='grava' onclick='let temp_textarea=document.getElementById(`textarea_teclado`); grava_trecho(temp_textarea.getAttribute(`data-id-chave-secao`), temp_textarea.value);'></td>
				<td><input type='button' value='lixeira'></td>
				<td><input type='button' value='separa'></td>
				<td><input type='button' value='junta'></td>
				<td><input type='button' value='sobe'></td>
				<td><input type='button' value='desce'></td>
			</tr>
			<tr>
				<td id='edita_secoes_teclado_data' colspan='6'></td>
			</tr>
		</table>	
	</div>
</div>
";

include "identifica.php.cripto";

$max_niveis=5;
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
echo "<script>var padding_folha = ".$padding_folha.";</script>";

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

function retorna_style($propriedade, $valor){
	global $style;
	global $para; // assume tag de paragrafo, se for paragrafo
	global $barra_para;  // assume tag com barra paragrafo, para terminar a tag de paragrafo
	$regra="";
 	if ($propriedade == "eh_paragrafo"){
		if ($valor == "sim"){
			$para = "<p>";
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
		if ($valor == "direito") {
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



if ($param_filhos == "false") {$sql="call mostra_arvore_niveis_pais_seleciona_tipo('".$param_tipo_secao."');";} else 
{$sql= "call mostra_arvore_niveis_pais_seleciona_tipos_com_filhos_esq_dir('".$param_tipo_secao."');";}
//echo $sql;

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

	$sql3="call retorna_valores_de_propriedades_do_tipo_secao('".$nome_tipo_secao."');";
	$result3=$conn3->query("$sql3");
	$style="";
		if ($result3->num_rows>0){
		while ($row3=$result3->fetch_assoc()){
			$propriedade = $row3["nome_propriedade"];
			$valor       = $row3["nome_valor_discreto"];
			$tipo	     = $row3["nome_nested_tipo_secao"];
			retorna_style($propriedade, $valor);
			// echo "<script>alert('".$style."');</script>";

		}
	}

	$conn3->close();

	if ($velho_nome_tipo_secao != $nome_tipo_secao) {
		$contagem_paragrafos=1;
	} else {
		$contagem_paragrafos++;
	}

	$numeracao = "";
	$titulo_de_arvore = $titulo; // este titulo eh apenas para arvore, porque table dah problema na arvore	

	if ($nome_tipo_secao == "item_lista_num") {
		$titulo = "<table class='itens_numerados_ou_nao'><tr><td >".$contagem_paragrafos.")</td><td>".$titulo."</td></tr></table>";
				
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
	$arvore = $arvore."<div id='folha_arvore_".$id_secao."' class='folha_de_arvore pode_mostrar_trechos  contem_trechos sub_ganha_foco' data-y='".$conta_folhas."' data-x='".$nivel."'  data-cor-nivel='".$cor_nivel[$nivel]."' data-cor-letra='".$cor_letra_nivel[$nivel]."' data-id-secao='".$id_secao."' data-conta-versoes='".$conta_versoes."'  data-gemeo='secao_".$id_secao."' data-id-chave='".$id_chave."' data-version-date='".$data_versao."' data-id-pai='".$id_pai."' data-titulo='".$titulo_de_arvore."' style=' background-color: ".$cor_nivel[$nivel]."; color: ".$cor_letra_nivel[$nivel]."; width: ".$largura_folha."px; left: ".$zti1."px; top: ".$zti2."px;'>".$id_secao."</div>"; 
	$conta_folhas++;
	$top_folha = $top_folha + ($altura_folha + $padding_folha);
	
	if ($nivel==0) {continue;}
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
			$div_padding = "<div class='div_para_padding'>";
			$barra_div_padding = "<label id='label_".$id_secao."' style='color: yellow; display: run-in; margin-left: 0px; float: right'></label>&nbsp&nbsp&nbsp</div>";
			$espaco = retorna_blank($id_secao."_separador_blank",$separador_de_pais);
			$largura_pai_efetivo = $largura_pai * 0.9;

		}
// data-id-chave eh a chave primaria da tabela secoes
	$itz = $espaco."<div id='secao_".$id_secao."' data-id-filho='".$id_secao."' data-id-secao='".$id_secao."' data-id-pai='".$id_pai."' data-titulo='".$titulo_de_arvore."' data-nivel='".$nivel."' data-version-date='".$data_versao."' data-conta-versoes='".$conta_versoes."' data-id-chave='".$id_chave."' data-gemeo='folha_arvore_".$id_secao."' data-cor-nivel='".$cor_nivel[$nivel+1]."' data-cor-letra='".$cor_letra_nivel[$nivel+1]."' class='secao sub_ganha_foco contem_trechos' style='".$back_ground_color." width: ".$largura_pai_efetivo."px; ".$style."'>".$numeracao.$div_padding.$para.$titulo.$barra_para.$barra_div_padding."</div>";



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
//	echo "<tr><td>".$nivel."</td><td>".$id_secao."</td><td>".$id_pai."</td><td>".$titulo."</td></tr>"; 
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

echo "<div id='flutua_para_direita' class='moldura ganha_foco' style=' width: ".$largura_moldura."px; height: ".$altura_moldura."px; left: ".$zti4."px; top: ".$zti5."px'><div id='cabecalio_flutua_para_direita' class='cabecalio_de_arvore' style='width: ".$largura_moldura."px; height: ".$altura_cabecalio."px;'><label  style='color: yellow; display: run-in; margin-left: 0px; float: left; font-weight: bold; font-size: 1rem; padding-top: 0px'>Escolha Box 2</label><div style='top: 0px; right: 40px; position: absolute'><input type='checkbox'  id='check_mostra_trechos' onclick='percorre_arvore_trechos(this.checked)' checked>Mostra Trechos</input></div></div>".$arvore."</div>";
//echo "</table>";

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
$sql = "call mostra_arvore_niveis_tipos_secoes();";

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

        if ($nome == $param_tipo_secao) {$checado="checked";} else {$checado="";}
        if ($top_folha_ts < $min_top_folha_ts) {$min_top_folha_ts = $top_folha_ts;}
        if (($top_folha_ts + $altura_folha_ts + $padding_folha_ts) > $max_top_folha_ts) {$max_top_folha_ts = $top_folha_ts + $altura_folha_ts + $padding_folha_ts;}

        $left_folha_ts = $left_arvore_ts +  $nivel * $largura_folha_ts/$divisao_ts;

        if ($left_folha_ts < $min_folha_ts) {$min_folha_ts = $left_folha_ts;};
        if (($left_folha_ts + $largura_folha_ts) > $max_folha_ts) {$max_folha_ts = $left_folha_ts + $largura_folha_ts;}

	if ($nome == "raiz") {
		$miolo_folha = "<label>&nbsp&nbsp".$nome."</label>";
	} else
	{
		$miolo_folha = "<input type='radio'  name='secao' id='check_".$nome."' class='selecao_do_tipo' value='".$nome."' ".$checado." onclick='recarrega(`".$nome."`, this.id);'><label>&nbsp&nbsp".$nome."</label></input>"; 
	}

	$zti6 = $left_folha_ts-$left_arvore_ts+$padding_folha_ts;
	$zti7 = $top_folha_ts-$top_arvore_ts+$padding_folha_ts;

        $arvore_tipos = $arvore_tipos."<div id='folha_arvore_tipos_secoes_".$id."' class='folha_de_arvore sub_ganha_foco' data-cor-nivel='".$cor_nivel_tipos_secoes[$nivel]."' data-cor-letra='".$cor_letra_nivel_tipos_secoes[$nivel]."' style=' background-color: ".$cor_nivel_tipos_secoes[$nivel]."; color: ".$cor_letra_nivel_tipos_secoes[$nivel]."; width: ".$largura_folha_ts."px; left: ".$zti6."px; top: ".$zti7."px;'>".$miolo_folha."</div>";
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
<div id='seletor' class='moldura_ts ganha_foco' style=' width: ".$largura_moldura_ts."px; height: ".$altura_moldura_ts."px; left: ".$zti8."px; top: ".$zti9."px'><div id='cabecalio_seletor' class='cabecalio_de_arvore' style=' width: ".$largura_moldura_ts."px; height: ".$altura_cabecalio_arvore."px;'><label style='color: yellow; display: run-in; margin-left: 0px; float: left; font-weight: bold; font-size: 1rem; padding-top: 0px'>Escolha o tipo de seção:</label><div style='top: 0px; right: 40px; position: absolute'><input type='checkbox' id='check_mostra_filhos' >Mostra Filhos</input></div></div>
".$arvore_tipos."</div>";


?>


