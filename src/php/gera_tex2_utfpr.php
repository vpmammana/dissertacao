<?php
//  ATENÇÃO -> o awk tem que ser o mawk. Não funciona com gawk (GNU)

if(isset($_GET["mode"])){
  $param_mode= $_GET["mode"];
} else $param_mode = "verbose"; // quiet ou verbose ou debug

if(isset($_GET["mantem_bibliografia"])){
  $param_mantem_bibliografia= $_GET["mantem_bibliografia"];
} else $param_mantem_bibliografia = "nao"; // porque talvez, um dia, quem sabe, seja interessante manter a secao de bibliografia separada do capitulo de referencia, com "sim" as referencias apareceriam em duplicidade

if(isset($_GET["enfatiza_data"])){
  $param_enfatiza_data= $_GET["enfatiza_data"];
} else $param_enfatiza_data = "nao";

$id_arquivo = ""; // guarda o ultimo identificador de label e caption de figura, para que posso haver substituicao depois

$nome_base = "../../latex/utfpr/utfprct-tex/utfprct_RedarTex";
$nome_do_tex = $nome_base.".tex";
$itz_explode = explode("/",$nome_do_tex);
$nome_do_tex_sem_path = $itz_explode[sizeof($itz_explode) - 1];
$nome_do_pdf = $nome_base.".pdf";
$nome_do_cls = $nome_base.".cls";
unset($conta_mult_imagem); // array de contadores relacionados a cada arquivo RedarTex que precisa ser alterado

function impar($number){ // retorna true se for impar
    if($number % 2 == 0){
        return ""; 
    }
    else{
        return "%";
    }
}

function retorna_n_linhas($texto){
	
	$linhas=preg_split("/\\\\n|\n/", $texto);
	return sizeof($linhas);

}

function retorna_n_colunas($texto){

	$linhas=preg_split("/\\\\n|\n/", $texto);

	$max=0;

	foreach($linhas as $linha) {
		$linha_sem_r = preg_replace('/\\\r|\r/',"",$linha);
		$celulas = explode("|", $linha_sem_r);
		if ($max < sizeof($celulas)) {$max = sizeof($celulas);}
	}

	return $max;

}

function retorna_formato_colunas($n_colunas){
	$formato = "{";
	for ($i=0; $i<$n_colunas; $i++){
		
		$formato = $formato."|c";

	}

	$formato = $formato."|}";
 	return $formato;
}	

function insere($nome_arquivo, $ponto_de_insercao, $nome_tipo_secao, $texto, $nome_secao, $nivel){
global $param_mode;
global $id_arquivo;
global $conta_mult_imagem;

//unset($file);
$file = file($nome_arquivo);
$indice = array_search($ponto_de_insercao, $file, false);

if (file_exists($texto)){
$id_arquivo = pathinfo($texto, PATHINFO_FILENAME);
}
else
{$id_arquivo = hash('ripemd160', $texto);}

//error_log(print_r("CODIGO: >>>>----".$id_arquivo."----<<<<<<<<<<<<<\n", true));
// $texto_latex = $nome_tipo_secao." -> ".$texto;
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


if ($nome_tipo_secao == "citacao"){
	$texto_latex="\n\\noindent\\begin{center}\\mbox{\\centering\\fbox{\\centering\\par\parbox{0.7\\linewidth}{\\small\\textit{".$texto."}\\normalsize}}}\\end{center}\n\n";
}

if ($nome_tipo_secao == "diagramaMER"){
if ($param_mode == "verbose") {error_log(print_r("DIAGRAMA_MER: >>>>".$nome_tipo_secao."<<<<<<\n", true));}
$linha_sem_r = preg_replace('/\\\r|\r/',"",$texto);
$MER = explode("|", $linha_sem_r);
	$texto_latex="
\\begin{tikzpicture}
  [every entity/.style={fill=blue!20,draw=blue,thick},
   every relationship/.style={fill=orange!20,draw=orange,thick,aspect=1.5}]
  \\node[entity] (".str_replace(" ","",trim($MER[0])).")  at (0,0)   {".trim($MER[0])."};
  \\node[entity] (".str_replace(" ","",trim($MER[2])).") at (10,0)   {".trim($MER[2])."};
  \\node[relationship]    at (5,0) {".trim($MER[1])."}
    edge (".str_replace(" ","",trim($MER[0])).")
    edge (".str_replace(" ","",trim($MER[2])).");
\\end{tikzpicture}
";
}

if ($nome_tipo_secao == "diagramaMER3ario"){
if ($param_mode == "verbose") {error_log(print_r("DIAGRAMA_MER: >>>>".$nome_tipo_secao."<<<<<<\n", true));}
$linha_sem_r = preg_replace('/\\\r|\r/',"",$texto);
$MER = explode("|", $linha_sem_r);
	$texto_latex="
\\begin{tikzpicture}
  [every entity/.style={fill=blue!20,draw=blue,thick},
   every relationship/.style={fill=orange!20,draw=orange,thick,aspect=1.5}]
  \\node[entity] (".str_replace(" ","",trim($MER[0])).")  at (0,0)   {".trim($MER[0])."};
  \\node[entity] (".str_replace(" ","",trim($MER[2])).") at (10,0)   {".trim($MER[2])."};
  \\node[entity] (".str_replace(" ","",trim($MER[3])).") at (5,-3)   {".trim($MER[3])."};
  \\node[relationship]    at (5,0) {".trim($MER[1])."}
    edge (".str_replace(" ","",trim($MER[0])).")
    edge (".str_replace(" ","",trim($MER[2])).")
    edge (".str_replace(" ","",trim($MER[3])).")
	;
\\end{tikzpicture}
";
}

if ($nome_tipo_secao == "diagramaMERquad"){
if ($param_mode == "verbose") {error_log(print_r("DIAGRAMA_MER: >>>>".$nome_tipo_secao."<<<<<<\n", true));}
$linha_sem_r = preg_replace('/\\\r|\r/',"",$texto);
$MER = explode("|", $linha_sem_r);
	$texto_latex="
\\begin{tikzpicture}
  [every entity/.style={fill=blue!20,draw=blue,thick},
   every relationship/.style={fill=orange!20,draw=orange,thick,aspect=1.5}]
  \\node[entity] (".str_replace(" ","",trim($MER[0])).")  at (0,0)   {".trim($MER[0])."};
  \\node[entity] (".str_replace(" ","",trim($MER[2])).") at (10,0)   {".trim($MER[2])."};
  \\node[entity] (".str_replace(" ","",trim($MER[3])).") at (5,-3)   {".trim($MER[3])."};
  \\node[entity] (".str_replace(" ","",trim($MER[4])).") at (5,3)   {".trim($MER[4])."};
  \\node[relationship]    at (5,0) {".trim($MER[1])."}
    edge (".str_replace(" ","",trim($MER[0])).")
    edge (".str_replace(" ","",trim($MER[2])).")
    edge (".str_replace(" ","",trim($MER[3])).")
    edge (".str_replace(" ","",trim($MER[4])).")
	;
\\end{tikzpicture}
";
}

if ($nome_tipo_secao == "imagem"){
        if ($conta_mult_imagem[$nome_arquivo]==0){
	$texto_latex = "\n
\\captionsetup{format=plain}
\\begin{figure}[htb]\n
	\\begin{center}\n
		\\includegraphics[max size={\\textwidth}{\\textheight}]{../../../imagens/".$texto."}\n
	\\end{center}\n
	\\caption{\\label{".$id_arquivo."}@[caption-".$id_arquivo."]@}\n
\\end{figure}\n";
	}
	else
	{
        $texto_latex = "\\begin{minipage}[b]{0.4\\linewidth}
        \\centering
                \\includegraphics[width=1.0\\linewidth]{../../../imagens/".$texto."}
                \\caption{@[caption-".$id_arquivo."]@}
                \\label{".$id_arquivo."}
\\end{minipage}".impar($conta_mult_imagem[$nome_arquivo])."\n\\hspace{0.5cm}"; //.impar($conta_mult_imagem[$nome_arquivo]); // se tem porcento, não quebra a linha
        $conta_mult_imagem[$nome_arquivo]++;
	}
}

if ($nome_tipo_secao == "tabela") {

	$n_linhas=retorna_n_linhas($texto);
	$n_colunas=retorna_n_colunas($texto);
	$formato_colunas = retorna_formato_colunas($n_colunas);
	$linhas=preg_split("/\\\\n|\n/", $texto);
	$texto_latex = "\n
\n
\\begin{table}[htb]
\\tiny
\\caption{\\label{".$id_arquivo."}@[caption-".$id_arquivo."]@}\n
\\centering
\\begin{tabular}".$formato_colunas."
\\hline\n";
	$conta_linhas_tabela=0;
	foreach($linhas as $linha) {
	if ($conta_linhas_tabela >0 && !preg_match('/^----/',$linha_sem_r)) {
		$texto_latex = $texto_latex." \\\\\n";
	}
		$linha_sem_r = preg_replace('/\\\r|\r/',"",$linha);
		if (preg_match('/^----/',$linha_sem_r)) { $celulas = "\\hline\n";}
		else {$celulas = preg_replace("/\|/", " & ",$linha_sem_r);}
		$texto_latex = $texto_latex.$celulas;
		if ($conta_linhas_tabela == 0) {
		}	
		$conta_linhas_tabela++;
	}
	$texto_latex=$texto_latex." \\\\";
		if ($conta_linhas_tabela ==1) {
			$texto_latex = $texto_latex."\\hline\n";
		}


if ($conta_linhas_tabela > 1) {
	$texto_latex = $texto_latex."\n\\hline";
}

$texto_latex = $texto_latex."\n\\end{tabular}
\\end{table}\n\n";

}


if ($nome_tipo_secao == "multimagem"){ // note que o nome da secao chega aqui sem UNDERSCORE... isso é um risco de duplicidade de nomes... 
        $texto_latex="\n
\\captionsetup{format=plain}
\\begin{figure}[htb]\n
\\centering\n
";
        $conta_mult_imagem[$nome_arquivo] =1;
}

if ($nome_tipo_secao != "multimagem" && $nome_tipo_secao != "imagem" && $conta_mult_imagem[$nome_arquivo] > 0){
        $texto_latex=
"\\end{figure}\n\n\n
".$texto_latex;
        $conta_mult_imagem[$nome_arquivo] = 0;
}

	array_splice( $file, $indice , 0, $texto_latex."\n");
	if ($param_mode == "verbose") {echo "> ".$nome_tipo_secao." ";}
	//echo "Vai inserir secoes/paragrafos no arquivo: ".$nome_arquivo."\n";
	file_put_contents($nome_arquivo, implode("",$file));

} // function insere

function substitui_label_caption($nome_arquivo, $label_de_busca, $substituicao){


exec('sed -i "s/@\['.$label_de_busca.'\]@/'.$substituicao.'/g" '.$nome_arquivo, $out_, $code);

// if ($code) {error_log(print_r("CODIGO: >>>>".implode($out_)."<<<<<<<<<<<<<\n", true));}

//	error_log(print_r("sed -i 's/@\\[".$label_de_busca."\\]@/".$substituicao."/g' ".$nome_arquivo, true));
//	error_log(print_r($substituicao, true));


}

function converte_acento_para_exec($linha){
return $linha;
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
return $linha;
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

$linha = str_replace("\\r","",$linha); // para tirar new line e carriage return. No caso de UTFPR está dando pau
$linha = str_replace("\\n","",$linha);
$linha = str_replace("_","\_",$linha);
$linha = str_replace("}","\}",$linha); // se voce quiser usar comandos latex no box1 e box2, tem que tirar esta linha. Daí, todos o colchetes do texto precisam vir com \{
$linha = str_replace("{","\{",$linha);
$linha = str_replace("&","\&",$linha);
$linha = str_replace("%","\%",$linha);
// $linha = str_replace("?","\?",$linha);
$linha = str_replace("{\"","{ \"",$linha); // isso aqui não vai funcionar muito bem porque a segunda aspas ficara sem espaco com a proxima palavra. Melhor usar duplo backstick para abrir as aspas e duplo apostrofo para fechar

return $linha;

$linha = str_replace("[[","",$linha);
$linha = str_replace("]]","",$linha);

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
global $conta_mult_imagem;
unset($retorno);
$retorno[] = "../../latex/utfpr/utfprct-tex/utfprct_RedarTex.tex"; 
$conta_mult_imagem[$retorno[0]]=0;
// exec("grep -HiRr \"^\\\\\\\\\\PosTexto\" ../../latex/utfpr/. | grep RedarTex | grep -v \.swp | awk 'BEGIN{FS=\":\"}{print $1}'",$retorno, $code );
// if ($code) {error_log(print_r("CODIGO: grep >>>>".implode($retorno)."<<<<<<<<<<<<<\n", true));}
return $retorno;
} 

// INICIO

ini_set('max_execution_time', 300);

// error_log(print_r("INI_GET -> ".ini_get("max_execution_time"), true));

//echo "<script>alert('gera_tex2');</script>";


include "identifica.php.cripto";

//	unset($retorna_zip);
//	if ($param_mode == "verbose") {echo "<br>Vai executar unzip<br>";}
//	exec("cd ../../latex && /usr/bin/unzip -o USPSC-3.1.zip", $retorna_unzip, $code);
//if ($code) {error_log(print_r("CODIGO: unzip >>>>".implode($retorna_unzip)."<<<<<<<<<<<<<\n", true));}

// do {
// unset($retorno_do_bash);
// exec("ps -aux | grep -v grep | grep -io unzip ", $retorno_do_bash, $code);
// //if ($code) {error_log(print_r("CODIGO: ps-aux >>>>".implode($retorno_do_bash)."<<<<<<<<<<<<<\n", true));}
// 
// if ($param_mode == "verbose") {echo "<br>Executando unzip<br>";}
// } while ($retorno_do_bash == "unzip");


// if ($param_mode == "verbose") {echo "<br>executou o unzip<br>";}
// if ($param_mode == "verbose") {print_r(implode("<br>deszipa: ",$retorna_unzip));}

// unset($retorna_inicializa);
// exec("../bash/inicializa_tex_com_change_DIR.bash 2>&1", $retorna_inicializa, $code);
//error_log(print_r("CODIGO inicializa: >>>>".implode($retorna_inicializa)."<<<<<<<\n", true));

// do {
// unset($retorno_do_bash);
// exec("ps -aux | grep -v grep | grep -io inicializa_tex ", $retorno_do_bash, $code);
//if ($code) {error_log(print_r("CODIGO: ps-aux >>>>".implode($retorno_do_bash)."<<<<<<<<<<<<<\n", true));}

//if ($param_mode == "verbose") {echo "<br>Executando inicializa_tex_com_DIR<br>";}
//} while ($retorno_do_bash == "inicializa_tex");

//if ($param_mode == "verbose") {echo "<br>Executou o inicializa_tex_com_DIR<br>";}
//if ($param_mode == "verbose") {print_r (implode("",$retorna_inicializa));}


unset($arquivos_textuais);
$arquivos_textuais = retorna_arquivos_que_tem_partes_textuais();
$database = "dissertacao_sem_eixo2";

$conn= new mysqli("localhost", $username, $pass, $database);
$myfile = fopen("../bash/copia_substitui_tex_utfpr.bash", "w") or die("Não foi possível abrir o arquivo!");
$script_file = fopen("../../latex/utfpr/utfprct-tex/mimetiza_pdflatex_utfpr.bash","w") or die ("Não consegui abrir o arquivo de script");

fwrite($script_file, "/usr/bin/pdflatex -interaction=nonstopmode ".$nome_do_tex_sem_path); // demorei um dia inteiro para perceber que tinha que usar /usr/bin - se usa no prompt nao e necessario - curioso
fclose($script_file);

$temporario_corpo = fopen("temporario.txt", "w");

$velho_nome_tipo_secao = ""; // serve para iniciar a lista

$sql="call mostra_documento_completo_niveis_sem_lixeira('raiz')";
fwrite($myfile,"touch ../bash/copia_tex_utfpr.bash\n"); 
fwrite($myfile,"chmod u+x ../bash/copia_tex_utfpr.bash\n"); 

// copia os PDFs just in case


fwrite($myfile, "find ../../latex/* | grep -i \"\.pdf\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.pdf/,\"_RedarTex.pdf\", $0); print \"\\cp \"input\" \"  $0\" \";}' > ../bash/copia_tex_utfpr.bash 
");

fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.cls/,\"_RedarTex.cls\", $0); print \"\\cp \"input\" \"  $0\" \";}' >> ../bash/copia_tex_utfpr.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{input = $0; gsub(/\.tex/,\"_RedarTex.tex\", $0); print \"\\cp \"input\" \"  $0\" \";}' >> ../bash/copia_tex_utfpr.bash
");


fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.cls/,\"_RedarTex.cls\", $0); gsub(/\_RedarTex.cls/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,\"\",$0); gsub(/\//,\"\/\",$0); print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.cls\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
");

fwrite($myfile, "find ../../latex/* | grep -i \"\.cls\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.cls/,\"_RedarTex.cls\", $0); gsub(/\_RedarTex.cls/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
");



fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
");

//fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"/include[{]USPSC-TA-PreTextual\/USPSC-Errata_RedarTex[}]/d\"quote\" \";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
//");
//
//fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.tex\"quote\" | xargs sed -i \"quote\"/include[{]USPSC-TA-PosTextual\/USPSC-Apendices_RedarTex[}]/d\"quote\" \";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
//");

//fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | grep -v \"USPSC\" | grep -v \"RedarTex\" | awk -v quote=\"'\" '{gsub(/\.tex/,\"_RedarTex.tex\", $0); gsub(/\_RedarTex.tex/,\"\", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,\"\",$0); gsub(/\//,\"\/\",$0);print \"find ../../latex/. -type f -name \"quote\"*_RedarTex.cls\"quote\" | xargs sed -i \"quote\"s/include[{]\"$0\"[}]/include{\"$0\"_RedarTex}/g\"quote\" \";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
//");

fwrite($myfile,"../bash/copia_tex_utfpr.bash\n\n");
// fwrite($myfile,"sed -i 's/USPSC-classe\/USPSC/USPSC-classe\/USPSC_RedarTex/g' ../../latex/USPSC-3.1/USPSC-modelo-IAU_RedarTex.tex\n");

//foreach ($arquivos_textuais as $valor){
//	$conta_mult_imagem[$valor]=0; // zera os contadores de mult_imagem para cada arquivo
//	if ($param_mode == "debug") {
//		echo "Zerou conta_mult_imagem[".$valor."]\n";
//	}
//	fwrite($myfile, "sed -i \"/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@\" ".$valor."\n");
//	if ($param_mantem_bibliografia == "nao"){
//		fwrite($myfile, "sed -i \"/^.chapter.Bibliografia..Bibliografia/d\" ".$valor."\n");
//	}
//}


//foreach ($arquivos_textuais as $valor){
//	fwrite($myfile, "sed -i \"/include.*Cap[1-5]/d\" ".$valor."\n");
//
//}

//foreach ($arquivos_textuais as $valor){
//	fwrite($myfile, "sed -i \"/Capítulo [1-5]/d\" ".$valor."\n");
//
//}

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
		
		if ($param_mode == "verbose") {echo "> ".$nome_tipo_secao."\n";}
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
			fwrite($myfile,"touch ../bash/substitui_tex_utfpr_".$conta.".bash\n"); 
			fwrite($myfile,"chmod u+x ../bash/substitui_tex_utfpr_".$conta.".bash\n");
			fwrite($myfile,"find ../../latex/* | grep -v \"USPSC\" | grep -i \"\_RedarTex.tex\|_RedarTex.cls\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[".$nome_tipo_sem_underscore."\]@/".$texto_com_acentuacao_latex."/g\\\" \"$0}' > ../bash/substitui_tex_utfpr_".$conta.".bash\n");

		if ($nome_tipo_sem_underscore == "autor") {
		    unset($parts);
			$parts = explode(" ", $texto_com_acentuacao_latex);
			$lastname = array_pop($parts);
			$firstname = implode(" ", $parts);
		
			fwrite($myfile,"find ../../latex/* | grep -v \"USPSC\" | grep -i \"\_RedarTex.tex\|_RedarTex.cls\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[ultimonome\]@/".$lastname."/g\\\" \"$0}' >> ../bash/substitui_tex_utfpr_".$conta.".bash\n");
			fwrite($myfile,"find ../../latex/* | grep -v \"USPSC\" | grep -i \"\_RedarTex.tex\|_RedarTex.cls\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[primeirosnomes\]@/".$firstname."/g\\\" \"$0}' >> ../bash/substitui_tex_utfpr_".$conta.".bash\n");
		} // fim de autor

		if ($nome_tipo_sem_underscore == "orientador") {
		    unset($parts);
			$parts = explode(" ", $texto_com_acentuacao_latex);
			$lastname = array_pop($parts);
			$firstname = implode(" ", $parts);
		
			fwrite($myfile,"find ../../latex/* | grep -v \"USPSC\" | grep -i \"\_RedarTex.tex\|_RedarTex.cls\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[ultimonomeorientador\]@/".$lastname."/g\\\" \"$0}' >> ../bash/substitui_tex_utfpr_".$conta.".bash\n");
			fwrite($myfile,"find ../../latex/* | grep -v \"USPSC\" | grep -i \"\_RedarTex.tex\|_RedarTex.cls\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[primeirosnomesorientador\]@/".$firstname."/g\\\" \"$0}' >> ../bash/substitui_tex_utfpr_".$conta.".bash\n");
		} // fim de autor

			
		if ($nome_tipo_sem_underscore == "coorientador") {
		    unset($parts);
			$parts = explode(" ", $texto_com_acentuacao_latex);
			$lastname = array_pop($parts);
			$firstname = implode(" ", $parts);
		
			fwrite($myfile,"find ../../latex/* | grep -v \"USPSC\" | grep -i \"\_RedarTex.tex\|_RedarTex.cls\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[ultimonomecoorientador\]@/".$lastname."/g\\\" \"$0}' >> ../bash/substitui_tex_utfpr_".$conta.".bash\n");
			fwrite($myfile,"find ../../latex/* | grep -v \"USPSC\" | grep -i \"\_RedarTex.tex\|_RedarTex.cls\" | awk -v acute=\"'\" -v tilde=\"~\" '{print \"sed -i \\\"s/@\[primeirosnomescoorientador\]@/".$firstname."/g\\\" \"$0}' >> ../bash/substitui_tex_utfpr_".$conta.".bash\n");
		} // fim de autor

			fwrite($myfile,"../bash/substitui_tex_utfpr_".$conta.".bash\n\n");
		}


	}
}
else {echo "Deu problema: ".$sql;}
if ($param_mode == "verbose") {fwrite($myfile, 'echo "Talvez tenha dado certo..."
');}
if ($param_mode == "verbose") {fwrite($myfile, 'pwd
');}
fclose($myfile);
if ($param_mode == "verbose") {echo "<br>Arquivo do batch foi fechado<br>";}
unset($retorno_do_bash_copia_substitui);
if ($param_mode == "verbose") {echo "<br>Vai executar copia_substitui_tex_utfpr<br>";}
exec("../bash/copia_substitui_tex_utfpr.bash", $retorno_do_bash_copia_substitui, $code);

//if ($code) {error_log(print_r("CODIGO: copia_substitui>>>>".implode($retorno_do_bash_copia_substitui)."<<<<<<<\n", true));}


do {
if ($param_mode == "verbose") {echo "Executando copia_substitui_tex_utfpr<br>";}
unset($retorno_do_bash);
exec("ps -aux | grep -v grep | grep -io copia_substitui_tex_utfpr ", $retorno_do_bash, $code);
//if ($code) {error_log(print_r("CODIGO: ps-aux >>>>".implode($retorno_do_bash)."<<<<<<<<<<<<<\n", true));}

if ($param_mode == "verbose") {echo "executando copia_substitui! ".implode("",$retorno_do_bash)."<br>";}
} while ($retorno_do_bash == "copia_substitui_tex_utfpr");




if ($param_mode == "verbose") {print_r(implode("<br>comando: ",$retorno_do_bash_copia_substitui));}

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
				$nome_tipo_secao == "mult_imagem" ||  // aqui nome_tipo_secao ainda tem underscore, mas dentro da insere foi tirado. 
				$nome_tipo_secao == "legenda_imagem" || 
				$nome_tipo_secao == "grafico" || 
				$nome_tipo_secao == "legenda_grafico" || 
				$nome_tipo_secao == "tabela" || 
				$nome_tipo_secao == "legenda_tabela" || 
				$nome_tipo_secao == "item_de_referencia" || 
				$nome_tipo_secao == "item_lista_nao_num" || 
				$nome_tipo_secao == "diagrama_MER" || 
				$nome_tipo_secao == "diagrama_MER_3ario" || 
				$nome_tipo_secao == "diagrama_MER_quad" || 
				$nome_tipo_secao == "item_lista_num"
			   ) 
			   {
			   //var_dump($arquivos_textuais);
			   //exit;
		  		foreach ($arquivos_textuais as $value)
				{
					if ($nome_tipo_secao == 'paragrafo') {$texto_com_acentuacao_para_fileput = $texto_com_acentuacao_para_fileput."\n";}
					if ($nome_tipo_secao == 'chama_ref') {$texto_com_acentuacao_para_fileput = "\\begin{flushright}\n\\setlength{\\absparsep}{0pt}\n\\tiny ".$texto_com_acentuacao_para_fileput." \\normalsize \n\\end{flushright}\n\n";}
					if ($nome_tipo_secao == 'item_de_referencia') 
						{
							if ($param_mantem_bibliografia !="nao"){
							insere(
								$value, 
								"% @[bibliografia]@\n", 
								$nome_tipo_sem_underscore, 	
								$texto_com_acentuacao_para_fileput."\n", 
								$secao_sem_espaco_sem_underscore, 
								$nivel
							      ); 
							// $secao_sem_espaco_sem_underscore nao estah sendo usada... eh para no futuro permitir label
							} else
							{
								$texto_com_acentuacao_para_fileput = "\\begin{flushleft}\n".$texto_com_acentuacao_para_fileput."\n\\end{flushleft}\n\n";
							}
						}
					if ($nome_tipo_secao == 'item_lista_num' && $velho_nome_tipo_secao != 'item_lista_num') 
						{
							insere(
								$value, 
								"% @[pontoinsercaotextoprincipal]@\n", 
								$nome_tipo_sem_underscore, 	
								"\n\\begin{itemize}", 
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
								"\\end{itemize}\n", "", $nivel
							      );
					
						}
					if ($nome_tipo_secao == 'legenda_imagem' || $nome_tipo_secao == 'legenda_tabela'){
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
					$conta_mult_imagem["../../latex/utfpr/utfprct-tex/PreTexto/resumo_RedarTex.tex"] = 0; // precisa atribuir para nao dar erro de falta de indice em insere
					insere("../../latex/utfpr/utfprct-tex/PreTexto/resumo_RedarTex.tex", "% @[pontoinsercaoparagraforesumo]@\n", $nome_tipo_sem_underscore, $texto_com_acentuacao_para_fileput, $secao_sem_espaco_sem_underscore, $nivel);
				}
			if ($nome_tipo_secao == "paragrafo_agradecimento") {
					$conta_mult_imagem["../../latex/utfpr/utfprct-tex/PreTexto/agradecimentos_RedarTex.tex"] = 0;
					insere("../../latex/utfpr/utfprct-tex/PreTexto/agradecimentos_RedarTex.tex", "% @[pontoinsercaoparagrafoagradecimento]@\n", $nome_tipo_sem_underscore, $texto_com_acentuacao_para_fileput, $secao_sem_espaco_sem_underscore, $nivel);
				}

			$velho_nome_tipo_secao = $nome_tipo_secao;

	}
}
else {echo "Deu problema: ".$sql;}

if ($param_mode == "verbose") {echo "\nVai executar pdflatex\n";}
unset($retorno_pdflatex);
exec("cd ../../latex/utfpr/utfprct-tex && ./mimetiza_pdflatex_utfpr.bash 2>&1",$retorno_pdflatex, $code);
exec("echo \"".implode("",$retorno_pdflatex)."\" > saida_erro_pdflatex.txt ");
exec("echo \"".$code."\" >> saida_erro_pdflatex.txt ");

//if ($code) {error_log(print_r("CODIGO: pdflatex >>>>".implode($retorno_pdflatex)."<<<<<<<<<<<<<\n", true));}
//error_log(print_r("CODIGO: pdflatex >>>>".implode($retorno_pdflatex)."<<<<<<<<<<<<<\n", true));
do {
unset($retorno_do_bash);
exec("ps -aux | grep -v grep | grep -io pdflatex ", $retorno_do_bash, $code);
//if ($code) {error_log(print_r("CODIGO: ps-aux >>>>".implode($retorno_do_bash)."<<<<<<<<<<<<<\n", true));}

if ($param_mode == "verbose") {echo "executando pdflatex! ".implode("",$retorno_do_bash)."\n";}
} while ($retorno_do_bash == "pdflatex");

if ($param_mode == "verbose") {print_r(implode("<br>",$retorno_pdflatex));}

if ($param_mode == "verbose") {echo "\nVai executar evince\n";}

if ($param_mode == "verbose") {
		exec("evince ".$nome_do_pdf, $out, $code);
		//if ($code) {error_log(print_r("CODIGO: evince >>>>".implode($out)."<<<<<<<<<<<<<\n", true));}

}
if ($param_mode == "quiet") { echo $nome_do_pdf;};

?>	
