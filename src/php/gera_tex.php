<?php
include "identifica.php.cripto";

$database = "dissertacao";

$conn= new mysqli("localhost", $username, $pass, $database);
$myfile = fopen("../bash/copia_substitui_tex.bash", "w") or die("Não foi possível abrir o arquivo!");

$sql="call mostra_documento_completo_niveis('raiz')";

fwrite($myfile, "find ../../latex/* | grep -i \"\.tex\" | awk '{input = $0; gsub(/\.tex/,\"_RedarTex.tex\", $0); print \"cp \"input\" \"  $0;}' > copia_tex.bash
");
fwrite($myfile,"./copia_tex.bash\n\n");

$result=$conn->query("$sql");

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
		echo $nivel.") [".$nome_tipo_secao."] ".$id_secao." - ".$titulo."\n";
		if (
			$nome_tipo_secao == "autor"  || 
			$nome_tipo_secao == "titulo" ||
			$nome_tipo_secao == "orientador"
		)
		{
			fwrite($myfile,"find ../../latex/* | grep -i \"\_RedarTex.tex\" | awk '{print \"sed -i \\\"s/@\[".$nome_tipo_secao."\]@/".$titulo."/g\\\" \\\"$0}' > substitui_tex.bash\n");
			fwrite($myfile,"./substitui_tex.bash\n\n");

		}


	}
}
else {echo "Deu problema: ".$sql;}
fclose($myfile);
?>	
