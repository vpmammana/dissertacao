<html>
<head>
	<title>
		Dissertação Elaine Tozzi
	</title>
<style>
.nivel {
	border: 1px solid black;
	background-color: gray;
	position: absolute;
}
.pai {
	border: 1px solid black;
	background-color: gray;
	position: absolute;
}
</style>
</head>

<body>
<h1>Dissertação de Elaine Tozzi</h1>

<?php
include "identifica.php.cripto";

$max_niveis=5;
$padding_niveis = 100;
$top_niveis = 500;
$height_niveis= 300;
$largura_nivel= 300;
$largura_pai= 250;
$padding_nivel= 50;
$padding_pai = 10;

$database = "dissertacao_sem_eixo2";

$conn= new mysqli("localhost", $username, $pass, $database);

$sql="call mostra_arvore_niveis_pais();";
$result=$conn->query("$sql");
$numero_registrados = $result->num_rows;
$niveis = [];
$pais = [];

echo "<table>";

if ($result->num_rows>0) {
    while($row=$result->fetch_assoc()){
	$nivel             = $row["nivel"]; 
	$id_secao             = $row["id_filho"]; 
	$id_pai             = $row["id_pai"]; 
	$titulo             = $row["titulo"]; 
	if ($nivel > $max_niveis) {echo "Excedeu número máximo de níveis (".$max_niveis.")!"; exit();}
	$left = ($largura_nivel + $padding_nivel)*$nivel;
//	$top_pai = 
//	if ( array_key_exists($id_pai, $pais) ){} else {$pais[$id_pais]="<div id='pai_".$id_pai."' class='pai' style='left: ".$left + $padding_pai."px; width: ".$largura_pai."px; top: ".$top_niveis."px; height: ".$height_niveis."px'>Este é o nível ".$nivel."<br><br>";}

	if ( array_key_exists($nivel, $niveis) ){} else {$niveis[$nivel]="<div id='nivel_".$nivel."' class='nivel' style='left: ".$left."px; width: ".$largura_nivel."px; top: ".$top_niveis."px; height: ".$height_niveis."px'>Este é o nível ".$nivel."<br><br>";}
	$niveis[$nivel]=$niveis[$nivel].$titulo."<br>";
	echo "<tr><td>".$nivel."</td><td>".$id_secao."</td><td>".$id_pai."</td><td>".$titulo."</td></tr>"; 
    }
}
else { echo "<tr><td>Não tem nomes duplicados</td></tr>";}

foreach($niveis as $level) {
	echo $level."</div>";
}

echo "</table>";

?>

</body>
</html>
