<?php

function insere($nome_arquivo, $ponto_de_insercao, $nome_tipo_secao, $texto, $nome_secao, $nivel){
//unset($file);
$file = file($nome_arquivo);
$indice = array_search($ponto_de_insercao, $file, false);

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
echo $indice.")".$file[$indice]." arquivo -> ".$nome_arquivo." -> ".$texto_latex." tam: ".sizeof($file)."\n";

array_splice( $file, $indice - 3, 0, $texto_latex."\n");

file_put_contents($nome_arquivo, implode("",$file));
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

include "identifica.php.cripto";

unset($arquivos_textuais);
$arquivos_textuais = retorna_arquivos_que_tem_partes_textuais();
$database = "dissertacao_sem_eixo2";

$conn= new mysqli("localhost", $username, $pass, $database);
$myfile = fopen("../bash/copia_substitui_tex.bash", "w") or die("Não foi possível abrir o arquivo!");

$temporario_corpo = fopen("temporario.txt", "w");

$sql="call mostra_documento_completo_niveis('raiz')";
fwrite($myfile,"touch substitui_tex.bash\n"); 
fwrite($myfile,"chmod u+x substitui_tex.bash\n"); 
fwrite($myfile,"touch copia_tex.bash\n"); 
fwrite($myfile,"chmod u+x copia_tex.bash\n"); 

// copia os PDFs just in case



fwrite($myfile, "find ../../latex/* | grep -i \"\.pdf\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.pdf/,\"_RedarTex.pdf\", $0); print \"\\cp \"input\" \"  $0\" \";}' > copia_tex.bash 
");

fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.cls/,\"_RedarTex.cls\", $0); print \"\\cp \"input\" \"  $0\" \";}' >> copia_tex.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.tex/,\"_RedarTex.tex\", $0); print \"\\cp \"input\" \"  $0\" \";}' >> copia_tex.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.cls/,\"_RedarTex.cls\", $0); gsub(/\_RedarTex.cls/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0); print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.cls\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> copia_tex.bash
");

fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.cls/,\"_RedarTex.cls\", $0); gsub(/\_RedarTex.cls/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> copia_tex.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> copia_tex.bash
");
fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.cls\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> copia_tex.bash
");
fwrite($myfile,"./copia_tex.bash\n\n");
fwrite($myfile,"sed -i 's/USPSC-classe\/USPSC/USPSC-classe\/USPSC_RedarTex/g' ../../latex/USPSC-3.1/USPSC-modelo-IAU_RedarTex.tex\n");

foreach ($arquivos_textuais as $valor){
	fwrite($myfile, "sed -i \"/include.*Cap[1-5]/d\" ".$valor."\n");

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
			$nome_tipo_secao == "ano" 	
				
		)
		{
			$conta++;
			echo $nome_tipo_secao."\n";
			fwrite($myfile,"touch substitui_tex_".$conta.".bash\n"); 
			fwrite($myfile,"chmod u+x substitui_tex_".$conta.".bash\n");
			fwrite($myfile,"find ../../latex/* | grep -i \"\_RedarTex.tex\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[".$nome_tipo_sem_underscore."\]@/".$texto_com_acentuacao_latex."/g\\\" \"$0}' > substitui_tex_".$conta.".bash\n");
			fwrite($myfile,"./substitui_tex_".$conta.".bash\n\n");

		}
		else {
			if ($nome_tipo_secao == "topico" || $nome_tipo_secao == "paragrafo") {
		  		foreach ($arquivos_textuais as $value){
					insere($value, "\postextual\n", $nome_tipo_sem_underscore, $texto_com_acentuacao_para_fileput, $secao_sem_espaco_sem_underscore, $nivel);
				}	
			}

		}	


	}
}
else {echo "Deu problema: ".$sql;}
fwrite($myfile, 'echo "Deu certo!"');
fclose($myfile);
echo "Arquivo fechado";
//unset($retorno_do_bash);
//exec("../bash/copia_substitui_tex.bash", $retorno_do_bash);

echo "Executado\n";
//var_dump($retorno_do_bash);
?>	
