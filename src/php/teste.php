<?php

function tes(){

$testa[]="alo";
$testa[]="putz";

return $testa;

}

$teste=tes();

var_dump($teste);

echo "\nteste teste teste\n\n";

foreach($teste as $value) {
	echo $value."\n";

}

echo $teste[0];

?>
