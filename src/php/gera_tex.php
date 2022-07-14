<?php

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

include "identifica.php.cripto";

$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);
$myfile = fopen("../bash/copia_substitui_tex.bash", "w") or die("Não foi possível abrir o arquivo!");

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
			$sem_underscore = str_replace("_", "", $nome_tipo_secao);
			fwrite($myfile,"touch substitui_tex_".$conta.".bash\n"); 
			fwrite($myfile,"chmod u+x substitui_tex_".$conta.".bash\n");
			fwrite($myfile,"find ../../latex/* | grep -i \"\_RedarTex.tex\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[".$sem_underscore."\]@/".converte_acento($titulo)."/g\\\" \"$0}' > substitui_tex_".$conta.".bash\n");
			fwrite($myfile,"./substitui_tex_".$conta.".bash\n\n");

		}


	}
}
else {echo "Deu problema: ".$sql;}
fclose($myfile);
?>	
