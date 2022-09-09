<?php
if(function_exists('exec')) {
    echo "exec is enabled<br>";
} else {
    echo "exec is disabled<br>";
}

echo "<br>Diretorio Temporario: ".sys_get_temp_dir()."<br>";

echo "maximum_execution_time: ".ini_get('max_execution_time')."<br>"; 

?>
