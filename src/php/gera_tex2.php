<?php
//  ATENÇÃO -> o awk tem que ser o mawk. Não funciona com gawk (GNU)

if(isset($_GET["mode"])){
  $param_mode= $_GET["mode"];
} else $param_mode = "verbose"; // quiet ou verbose

$id_arquivo = ""; // guarda o ultimo identificador de label e caption de figura, para que posso haver substituicao depois

$nome_base = "../../latex/USPSC-3.1/USPSC-modelo-IAU_RedarTex";
$nome_do_tex = $nome_base.".tex";
$nome_do_pdf = $nome_base.".pdf";

function insere($nome_arquivo, $ponto_de_insercao, $nome_tipo_secao, $texto, $nome_secao, $nivel){
global $param_mode;
global $id_arquivo;

//unset($file);
$file = file($nome_arquivo);
$indice = array_search($ponto_de_insercao, $file, false);
$id_arquivo = pathinfo($texto, PATHINFO_FILENAME);

$texto_latex = $texto;

if ($nivel == 1 && $nome_tipo_secao=="topico") {
	$texto_latex = "\\chapter[".$texto."]{".$texto."}\\label{".$texto."}";
}
if ($nivel == 2 && $nome_tipo_secao=="topico") {
	$texto_latex = "\\section[".$texto."]{".$texto."}\\label{".$texto."}";
}
if ($nivel == 3 && $nome_tipo_secao=="topico") {
	$texto_latex = "\\subsection[".$texto."]{".$texto."}\\label{".$texto."}";
}
if ($nivel == 4 && $nome_tipo_secao=="topico") {
	$texto_latex = "\\subsubsection[".$texto."]{".$texto."}\\label{".$texto."}";
}

if ($nome_tipo_secao == "imagem"){
	$texto_latex = "\n
\\begin{figure}[htb]\n
	\\begin{center}\n
		\\includegraphics[scale=0.5]{../../imagens/".$texto."}\n
	\\end{center}\n
	\\caption{\label{".$id_arquivo."}@[caption-".$id_arquivo."]@}\n
	\\legend{Fonte: \citeonline{cite-".$id_arquivo."}}\n
\\end{figure}";
}



//echo $indice.")".$file[$indice]." arquivo -> ".$nome_arquivo." -> ".$texto_latex." tam: ".sizeof($file)."\n";
//if ($nome_tipo_secao == "paragraforesumo") {
//echo "\n";
//echo "\n";
//echo "\n";
//echo "putz -> (".$ponto_de_insercao.")";
//echo " indice -> [".$indice."]";
//echo " texto -> ".$texto_latex;
//foreach($file as $linha){ echo "(".$linha.")";}
//echo "\n";
//echo "\n";
//echo "\n";
//echo "\n";
//}

array_splice( $file, $indice , 0, $texto_latex."\n");
if ($param_mode == "verbose") {echo "> ".$nome_tipo_secao." ";}
//echo "Vai inserir secoes/paragrafos no arquivo: ".$nome_arquivo."\n";
file_put_contents($nome_arquivo, implode("",$file));
}

function substitui_label_caption($nome_arquivo, $label_de_busca, $substituicao){


exec('sed -i "s/@\['.$label_de_busca.'\]@/'.$substituicao.'/g" '.$nome_arquivo);

error_log(print_r("sed -i 's/@\\[".$label_de_busca."\\]@/".$substituicao."/g' ".$nome_arquivo, true));
error_log(print_r($substituicao, true));


}

function converte_acento_para_exec($linha){

$linha = str_replace("á","\\\\\'a",$linha);
$linha = str_replace("Á","\\\\\'A",$linha);
$linha = str_replace("é","\\\\\'e",$linha);
$linha = str_replace("É","\\\\\'E",$linha);
$linha = str_replace("â","\\\\\^a",$linha);
$linha = str_replace("Â","\\\\\^A",$linha);
$linha = str_replace("ê","\\\\\^e",$linha);
$linha = str_replace("Ê","\\\\\^E",$linha);
$linha = str_replace("à","\\\\\`a",$linha);
$linha = str_replace("À","\\\\\`A",$linha);
$linha = str_replace("ç","\\\\\c{c}",$linha);
$linha = str_replace("Ç","\\\\\c{C}",$linha);
$linha = str_replace("õ","\\\\\~o",$linha);
$linha = str_replace("Õ","\\\\\~O",$linha);
$linha = str_replace("ã","\\\\\~a",$linha);
$linha = str_replace("Ã","\\\\\~A",$linha);
$linha = str_replace("í","\\\\\'{\i}",$linha);
$linha = str_replace("Í","\\\\\'I",$linha);
$linha = str_replace("ó","\\\\\'o",$linha);
$linha = str_replace("Ó","\\\\\'O",$linha);
$linha = str_replace("ô","\\\\\^o",$linha);
$linha = str_replace("Ô","\\\\\^O",$linha);
$linha = str_replace("ú","\\\\\'u",$linha);
$linha = str_replace("Ú","\\\\\'U",$linha);
$linha = str_replace("ü","\\\\\\\"u",$linha);
$linha = str_replace("Ü","\\\\\\\"U",$linha);

return $linha;
}



function converte_acento($linha){

$linha = str_replace("á","\\\\\\\\\\\\\"acute\"a",$linha);
$linha = str_replace("Á","\\\\\\\\\\\\\"acute\"A",$linha);
$linha = str_replace("é","\\\\\\\\\\\\\"acute\"e",$linha);
$linha = str_replace("É","\\\\\\\\\\\\\"acute\"E",$linha);
$linha = str_replace("â","\\\\\\\\\^a",$linha);
$linha = str_replace("Â","\\\\\\\\\^A",$linha);
$linha = str_replace("ê","\\\\\\\\\^e",$linha);
$linha = str_replace("Ê","\\\\\\\\\^E",$linha);
$linha = str_replace("à","\\\\\\\\\`a",$linha);
$linha = str_replace("À","\\\\\\\\\`A",$linha);
$linha = str_replace("ç","\\\\\\\\\\\c{c}",$linha);
$linha = str_replace("Ç","\\\\\\\\\\\c{C}",$linha);
$linha = str_replace("õ","\\\\\\\\\~o",$linha);
$linha = str_replace("Õ","\\\\\\\\\~O",$linha);
$linha = str_replace("ã","\\\\\\\\\~a",$linha);
$linha = str_replace("Ã","\\\\\\\\\~A",$linha);
$linha = str_replace("í","\\\\\\\\\\\\\"acute\"{\i}",$linha);
$linha = str_replace("Í","\\\\\\\\\\\\\"acute\"I",$linha);
$linha = str_replace("ó","\\\\\\\\\\\\\"acute\"o",$linha);
$linha = str_replace("Ó","\\\\\\\\\\\\\"acute\"O",$linha);
$linha = str_replace("ô","\\\\\\\\\^o",$linha);
$linha = str_replace("Ô","\\\\\\\\\^O",$linha);
$linha = str_replace("ú","\\\\\\\\\\\\\"acute\"u",$linha);
$linha = str_replace("Ú","\\\\\\\\\\\\\"acute\"U",$linha);
$linha = str_replace("ü","\\\\\\\\\\\\\"u",$linha);
$linha = str_replace("Ü","\\\\\\\\\\\\\"U",$linha);

return $linha;
}

function converte_acento_para_file_put($linha){
//                        12345678

$linha = str_replace("_","\_",$linha);
$linha = str_replace("}","\}",$linha); // se voce quiser usar comandos latex no box1 e box2, tem que tirar esta linha. Daí, todos o colchetes do texto precisam vir com \{
$linha = str_replace("{","\{",$linha);
$linha = str_replace("&","\&",$linha);
$linha = str_replace("á","\'a",$linha);
$linha = str_replace("Á","\'A",$linha);
$linha = str_replace("é","\'e",$linha);
$linha = str_replace("É","\'E",$linha);
$linha = str_replace("â","\^a",$linha);
$linha = str_replace("Â","\^A",$linha);
$linha = str_replace("ê","\^e",$linha);
$linha = str_replace("Ê","\^E",$linha);
$linha = str_replace("à","\`a",$linha);
$linha = str_replace("À","\`A",$linha);
$linha = str_replace("ç","\c{c}",$linha);
$linha = str_replace("Ç","\c{C}",$linha);
$linha = str_replace("õ","\~o",$linha);
$linha = str_replace("Õ","\~O",$linha);
$linha = str_replace("ã","\~a",$linha);
$linha = str_replace("Ã","\~A",$linha);
$linha = str_replace("í","\'{\i}",$linha);
$linha = str_replace("Í","\'I",$linha);
$linha = str_replace("ó","\'o",$linha);
$linha = str_replace("Ó","\'O",$linha);
$linha = str_replace("ô","\^o",$linha);
$linha = str_replace("Ô","\^O",$linha);
$linha = str_replace("ú","\'u",$linha);
$linha = str_replace("Ú","\'U",$linha);
$linha = str_replace("ü","\"u",$linha);
$linha = str_replace("Ü","\"U",$linha);

return $linha;
}



function retorna_arquivos_que_tem_partes_textuais(){
unset($retorno);
exec("grep -HiRr \"^\\\\\\\\\\postextual\" ../../latex/USPSC-3.1/. | grep RedarTex | grep -v \.swp | awk 'BEGIN{FS=\":\"}{print $1}'",$retorno );
return $retorno;
} 

// INICIO



include "identifica.php.cripto";
unset($retorna_zip);
if ($param_mode == "verbose") {echo "\nVai executar unzip\n";}
exec("cd ../../latex
unzip -o USPSC-3.1.zip", $retorna_unzip);

do {
unset($retorno_do_bash);
exec("ps -aux | grep -v grep | grep -io unzip ", $retorno_do_bash);
if ($param_mode == "verbose") {echo "\nExecutando unzip\n";}
} while ($retorno_do_bash == "unzip");


if ($param_mode == "verbose") {echo "\nexecutou o unzip\n";}
if ($param_mode == "verbose") {print_r(implode("\ndeszipa: ",$retorna_unzip));}

unset($retorna_inicializa);
exec("../bash/inicializa_tex_com_change_DIR.bash", $retorna_inicializa);

do {
unset($retorno_do_bash);
exec("ps -aux | grep -v grep | grep -io inicializa_tex ", $retorno_do_bash);
if ($param_mode == "verbose") {echo "\nExecutando inicializa_tex_com_DIR\n";}
} while ($retorno_do_bash == "inicializa_tex");

if ($param_mode == "verbose") {echo "\nExecutou o inicializa_tex_com_DIR\n";}
if ($param_mode == "verbose") {print_r (implode("",$retorna_inicializa));}


unset($arquivos_textuais);
$arquivos_textuais = retorna_arquivos_que_tem_partes_textuais();
$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);
$myfile = fopen("../bash/copia_substitui_tex.bash", "w") or die("Não foi possível abrir o arquivo!");

$temporario_corpo = fopen("temporario.txt", "w");

$velho_nome_tipo_secao = ""; // serve para iniciar a lista

$sql="call mostra_documento_completo_niveis('raiz')";
fwrite($myfile,"touch ../bash/copia_tex.bash\n"); 
fwrite($myfile,"chmod u+x ../bash/copia_tex.bash\n"); 

// copia os PDFs just in case


fwrite($myfile, "find ../../latex/* | grep -i \"\.pdf\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.pdf/,\"_RedarTex.pdf\", $0); print \"\\cp \"input\" \"  $0\" \";}' > ../bash/copia_tex.bash 
");

fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.cls/,\"_RedarTex.cls\", $0); print \"\\cp \"input\" \"  $0\" \";}' >> ../bash/copia_tex.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.tex/,\"_RedarTex.tex\", $0); print \"\\cp \"input\" \"  $0\" \";}' >> ../bash/copia_tex.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.cls/,\"_RedarTex.cls\", $0); gsub(/\_RedarTex.cls/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0); print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.cls\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex.bash
");

fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.cls/,\"_RedarTex.cls\", $0); gsub(/\_RedarTex.cls/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex.bash
");
fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.cls\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex.bash
");
fwrite($myfile,"../bash/copia_tex.bash\n\n");
fwrite($myfile,"sed -i 's/USPSC-classe\/USPSC/USPSC-classe\/USPSC_RedarTex/g' ../../latex/USPSC-3.1/USPSC-modelo-IAU_RedarTex.tex\n");

foreach ($arquivos_textuais as $valor){
	fwrite($myfile, "sed -i \"/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@\" ".$valor."\n");

}


foreach ($arquivos_textuais as $valor){
	fwrite($myfile, "sed -i \"/include.*Cap[1-5]/d\" ".$valor."\n");

}

foreach ($arquivos_textuais as $valor){
	fwrite($myfile, "sed -i \"/Capítulo [1-5]/d\" ".$valor."\n");

}

$result=$conn->query("$sql");
$conta=0;
if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
		$id_chave             = $row["id_chave_filho"];
		$conta_versoes        = $row["conta_versoes"]; 
		$nivel             	  = $row["nivel"]; 
		$id_secao             = $row["id_filho"]; 
//		$id_pai               = $row["id_pai"]; 
		$titulo               = $row["ultima_versao"]; // ultima_versao eh a ultima versao da secao, obtida da tabela versoes
		$data_versao          = $row["data"]; // data da ultima versao  
		$id_tipo_secao        = $row["id_nested_tipo_secao"]; 
		$nome_tipo_secao      = $row["nome_nested_tipo_secao"];
		$tem_filho	          = $row["tem_filho"];
		//echo $nivel.") [".$nome_tipo_secao."] ".$id_secao." - ".$titulo."\n";
		
		$secao_sem_underscore = str_replace("_", "", $id_secao);
		$secao_sem_espaco_sem_underscore = str_replace(" ", "", $secao_sem_underscore);
		$nome_tipo_sem_underscore = str_replace("_", "", $nome_tipo_secao);
		$texto_com_acentuacao_latex = converte_acento($titulo);
		$texto_com_acentuacao_para_fileput = converte_acento_para_file_put($titulo);
		
		if (
			$nome_tipo_secao == "autor"  				|| 
			$nome_tipo_secao == "titulo" 				||
			$nome_tipo_secao == "orientador"			||
			$nome_tipo_secao == "titulo_abstract"			||
			$nome_tipo_secao == "sub_titulo"			||
			$nome_tipo_secao == "autor_abr"				||
			$nome_tipo_secao == "autor_ficha"			||
			$nome_tipo_secao == "orientador_ficha"			||
			$nome_tipo_secao == "coorientador"			||
			$nome_tipo_secao == "programa_pos"			||
			$nome_tipo_secao == "programa_pos_maiuscula"		||
			$nome_tipo_secao == "curso"				||
			$nome_tipo_secao == "curso_maiuscula"			||
			$nome_tipo_secao == "mestre_ou_doutor"			||
			$nome_tipo_secao == "titulo_pos"			||
			$nome_tipo_secao == "universidade"			||
			$nome_tipo_secao == "universidade_maiuscula"		||
			$nome_tipo_secao == "unidade_faculdade"			||
			$nome_tipo_secao == "unidade_faculdade_maiuscula"	||
			$nome_tipo_secao == "localidade"		 	||
			$nome_tipo_secao == "palavras_chave"		 	||
			$nome_tipo_secao == "epigrafe"			 	||
			$nome_tipo_secao == "dedicatoria"		 	||
			$nome_tipo_secao == "ano" 	
				
		)
		{
			$conta++;
			if ($param_mode == "verbose") {echo "\nLeu ".$nome_tipo_secao."\n";}
			if ($param_mode == "verbose") {echo "Vai gravar os comandos de substituicao no batch: ";}
			fwrite($myfile,"touch ../bash/substitui_tex_".$conta.".bash\n"); 
			fwrite($myfile,"chmod u+x ../bash/substitui_tex_".$conta.".bash\n");
			fwrite($myfile,"find ../../latex/* | grep -i \"\_RedarTex.tex\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[".$nome_tipo_sem_underscore."\]@/".$texto_com_acentuacao_latex."/g\\\" \"$0}' > ../bash/substitui_tex_".$conta.".bash\n");
			fwrite($myfile,"../bash/substitui_tex_".$conta.".bash\n\n");
		}
			


	}
}
else {echo "Deu problema: ".$sql;}
if ($param_mode == "verbose") {fwrite($myfile, 'echo "Talvez tenha dado certo..."
');}
if ($param_mode == "verbose") {fwrite($myfile, 'pwd
');}
fclose($myfile);
if ($param_mode == "verbose") {echo "\nArquivo do batch foi fechado\n";}
unset($retorno_do_bash_copia_substitui);
if ($param_mode == "verbose") {echo "\nVai executar copia_substitui_tex\n";}
exec("../bash/copia_substitui_tex.bash", $retorno_do_bash_copia_substitui);



do {
if ($param_mode == "verbose") {echo "Executando copia_substitui_tex\n";}
unset($retorno_do_bash);
exec("ps -aux | grep -v grep | grep -io copia_substitui_tex ", $retorno_do_bash);
if ($param_mode == "verbose") {echo "executando copia_substitui! ".implode("",$retorno_do_bash)."\n";}
} while ($retorno_do_bash == "copia_substitui_tex");




if ($param_mode == "verbose") {print_r(implode("\ncomando: ",$retorno_do_bash_copia_substitui));}

//$conn->close();
$conn2= new mysqli("localhost", $username, $pass, $database);
$result=$conn2->query("$sql");
$conta=0;
if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
		$id_chave             = $row["id_chave_filho"];
		$conta_versoes        = $row["conta_versoes"]; 
		$nivel             	  = $row["nivel"]; 
		$id_secao             = $row["id_filho"]; 
//		$id_pai               = $row["id_pai"]; 
		$titulo               = $row["ultima_versao"]; // ultima_versao eh a ultima versao da secao, obtida da tabela versoes
		$data_versao          = $row["data"]; // data da ultima versao  
		$id_tipo_secao        = $row["id_nested_tipo_secao"]; 
		$nome_tipo_secao      = $row["nome_nested_tipo_secao"];
		$tem_filho	          = $row["tem_filho"];
		//echo $nivel.") [".$nome_tipo_secao."] ".$id_secao." - ".$titulo."\n";
		
		$secao_sem_underscore = str_replace("_", "", $id_secao);
		$secao_sem_espaco_sem_underscore = str_replace(" ", "", $secao_sem_underscore);
		$nome_tipo_sem_underscore = str_replace("_", "", $nome_tipo_secao);
		$velho_tipo_sem_underscore = str_replace("_", "", $velho_nome_tipo_secao);

		$texto_com_acentuacao_latex = converte_acento($titulo);
		$texto_com_acentuacao_para_fileput = converte_acento_para_file_put($titulo);
		
		if ($nome_tipo_secao == 'item_lista_num') {$texto_com_acentuacao_para_fileput = "\\item ".$texto_com_acentuacao_para_fileput;}

			if (
				$nome_tipo_secao == "topico" || 
				$nome_tipo_secao == "paragrafo" || 
				$nome_tipo_secao == "chama_ref" || 
				$nome_tipo_secao == "citacao" || 
				$nome_tipo_secao == "imagem" || 
				$nome_tipo_secao == "legenda_imagem" || 
				$nome_tipo_secao == "grafico" || 
				$nome_tipo_secao == "legenda_grafico" || 
				$nome_tipo_secao == "tabela" || 
				$nome_tipo_secao == "legenda_tabela" || 
				$nome_tipo_secao == "item_lista_nao_num" || 
				$nome_tipo_secao == "item_lista_num"
			   ) 
			   {
		  		foreach ($arquivos_textuais as $value)
				{
					if ($nome_tipo_secao == 'paragrafo') {$texto_com_acentuacao_para_fileput = $texto_com_acentuacao_para_fileput."\n";}
					if ($nome_tipo_secao == 'item_lista_num' && $velho_nome_tipo_secao != 'item_lista_num') 
						{
							insere(
								$value, 
								"% @[pontoinsercaotextoprincipal]@\n", 
								$nome_tipo_sem_underscore, 	
								"\n\\begin{alineas}", 
								$secao_sem_espaco_sem_underscore, 
								$nivel
							      ); 
							// $secao_sem_espaco_sem_underscore nao estah sendo usada... eh para no futuro permitir label
						}
					if ($velho_nome_tipo_secao == 'item_lista_num' && $nome_tipo_secao != 'item_lista_num') 
						{
							insere(
								$value, 
								"% @[pontoinsercaotextoprincipal]@\n", 
								$velho_tipo_sem_underscore, 
								"\\end{alineas}\n", "", $nivel
							      );
					
						}
					if ($nome_tipo_secao == 'legenda_imagem'){
						substitui_label_caption($value, "caption-".$id_arquivo, converte_acento_para_exec($titulo));
					}
					else {
					insere(
						$value, 
						"% @[pontoinsercaotextoprincipal]@\n", 
						$nome_tipo_sem_underscore, 
						$texto_com_acentuacao_para_fileput, 
						$secao_sem_espaco_sem_underscore, 
						$nivel
					      );	
					}
				} // foreach
			   }	
			if ($nome_tipo_secao == "paragrafo_resumo") {
					insere("../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Resumo_RedarTex.tex", "% @[pontoinsercaoparagraforesumo]@\n", $nome_tipo_sem_underscore, $texto_com_acentuacao_para_fileput, $secao_sem_espaco_sem_underscore, $nivel);
				}
			if ($nome_tipo_secao == "paragrafo_agradecimento") {
					insere("../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Agradecimentos_RedarTex.tex", "% @[pontoinsercaoparagrafoagradecimento]@\n", $nome_tipo_sem_underscore, $texto_com_acentuacao_para_fileput, $secao_sem_espaco_sem_underscore, $nivel);
				}

			$velho_nome_tipo_secao = $nome_tipo_secao;

	}
}
else {echo "Deu problema: ".$sql;}

if ($param_mode == "verbose") {echo "\nVai executar pdflatex\n";}
unset($retorno_pdflatex);
exec("cd ../../latex/USPSC-3.1
pwd
pdflatex -interaction=nonstopmode ".$nome_do_tex,$retorno_pdflatex);
do {
unset($retorno_do_bash);
exec("ps -aux | grep -v grep | grep -io pdflatex ", $retorno_do_bash);
if ($param_mode == "verbose") {echo "executando pdflatex! ".implode("",$retorno_do_bash)."\n";}
} while ($retorno_do_bash == "pdflatex");

if ($param_mode == "verbose") {print_r(implode("<br>",$retorno_pdflatex));}

if ($param_mode == "verbose") {echo "\nVai executar evince\n";}

if ($param_mode == "verbose") {exec("evince ".$nome_do_pdf);}
if ($param_mode == "quiet") { echo $nome_do_pdf;};

?>	
