<?php 
unset($retorno);
exec("whoami", $retorno) ;
echo implode("",$retorno);
?>
