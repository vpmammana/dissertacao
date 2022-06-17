<?php

if(isset($_GET["json"])){
  $param_json= $_GET["json"];
} else $param_json = "[99]";

echo "<label id='mostra'>".$param_json."</label><br><br>";

$matriz = json_decode($param_json);

for ($i=0; $i < sizeof($matriz); $i++){
	echo "(".$i.") ".$matriz[$i]."<br>";

}

echo "<input id='teste' type='button' value='testa'>
<script>
document.getElementById('teste').addEventListener('click',
	function (e){
myArray = ['aaa', 'bbb', 'ccc'];
var arrStr = encodeURIComponent(JSON.stringify(myArray));	

var resposta='';
var url='../php/test_json.php?json='+arrStr;
var oReq=new XMLHttpRequest();
           oReq.open('GET', url, false);
           oReq.onload = function (e) {
                     resposta=oReq.responseText;
		     document.getElementById('mostra').innerHTML=resposta;
                     }
           oReq.send();

	}

);

</script>

";


?>

