<?php

$arquivo ="USPSC-modelo-IAU_RedarTex.tex";

unset($retorno);
exec("grep -HiRr \"^\\\\\\\\\\postextual\" ../../latex/USPSC-3.1/. | awk 'BEGIN{FS=\":\"}{print $1}'",$retorno );

var_dump($retorno);

exit();

$file = file($arquivo);

//var_dump($file);
$indice = array_search("\postextual\n", $file, false);

echo "(".$indice.")";

echo $file[$indice];

array_splice( $file, $indice - 3, 0, "telesp bestando antes\n" );
array_splice( $file, $indice + 2, 0, "telesp bestando depois\n" );

$indice = array_search("\postextual\n", $file, false);
echo "indice de postextual depois de inserir -> ".$indice."\n";
echo $file[$indice - 1];
echo $file[$indice];
echo $file[$indice - 2];
$resultados = print_r($file, true);
echo $resultados;
file_put_contents($arquivo, implode("",$file));

//$myfile = fopen($arquivo, "w") or die("Não foi possível abrir o arquivo!");
//fwrite ($myfile, $file);
//
//fclose($myfile);

?>
