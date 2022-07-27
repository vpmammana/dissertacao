<?php 
	include "identifica.php.cripto";
	$database = "dissertacao";
	$sql = "select id_chave_categoria from secoes where id_tipo_secao=(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao='item_de_referencia') limit 1;";
	$conn= new mysqli("localhost", $username, $pass, $database);
	$result=$conn->query("$sql");
	if ($result->num_rows>0) {
		while($row=$result->fetch_assoc()){
			$id_categoria = $row["id_chave_categoria"];
		}
	}
echo $id_categoria;
