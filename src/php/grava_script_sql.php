<?php

function escape_quote($trecho){
//return $trecho;
return preg_replace("/'/","\\'", $trecho);

}

$data=date("Y_m_d_H_i_s");

$myfile = fopen("script_SQL_".$data.".sql", "w") or die("Não foi possível abrir o arquivo!");
include "identifica.php.cripto";

$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);

$sql="call mostra_documento_completo_com_pai('raiz');";

$result=$conn->query("$sql");

echo "delete from guarda_ids_da_lixeira;<br><br>";
echo "delete from ids_de_referencia;<br><br>";
echo "delete from versoes;<br><br>";
echo "delete from secoes;<br><br>";

fwrite($myfile, "# SCRIPT que permite gerar novamente a dissertacao. Nao grava a sequencia de versoes geradas)\n");
fwrite($myfile, "# Desenvolvido por Victor Mammana\n");
fwrite($myfile, "# Este script nao recria as stored procedures, que estao em tese.sql\n\n\n\n");

fwrite($myfile, "delete from guarda_ids_da_lixeira;\n");
fwrite($myfile, "delete from ids_de_referencia;\n");
fwrite($myfile, "delete from versoes;\n");
fwrite($myfile, "delete from secoes;\n");

echo "insert into secoes values (1,'corpo_tese','raiz','',1,2, (SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao='raiz'));<br><br>";

fwrite($myfile,"insert into secoes values (1,'corpo_tese','raiz','',1,2, (SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao='raiz'));\n\n");


$conta=0;
if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
    $nome_secao       = $row["id_filho"];
	$nome_secao_pai	  = $row["paizao"];
	$nome_tipo	 	  = $row["nome_nested_tipo_secao"];
	$ultima_versao	  = $row["ultima_versao"];
	if ($conta >0) {
	echo "call insere_a_direita_dos_filhos('".$nome_secao_pai."', '".$nome_secao."', '".escape_quote($ultima_versao)."', '', (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = '".$nome_tipo."'));<br>";
			fwrite($myfile,"call insere_a_direita_dos_filhos('".$nome_secao_pai."', '".$nome_secao."', '".escape_quote($ultima_versao)."', '', (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = '".$nome_tipo."'));\n");
}
	$conta++;
	}
}

echo "<br><br>INSERT INTO versoes (id_secao, trecho) SELECT id_chave_categoria, descricao FROM secoes;";
fwrite($myfile,"\n\nINSERT INTO versoes (id_secao, trecho) SELECT id_chave_categoria, descricao FROM secoes;");

?>
