<?php

echo "<input style='display: none' id='id_sobe_imagem'
					type='file'
onchange='alert(`teste`);var resposta=``;var nome_arquivo=this.value.replace(/^.*[\\\/]/, resposta);document.getElementById(`textarea_mouse`).value=nome_arquivo;if (this.files && this.files[0]) {var extensao=(files[0].name.split(`.`).pop().toLowerCase());var fd= new FormData();var faili=`fileToUpload`;fd.append(faili,this.files[0],nome_arquivo);var xhr = new XMLHttpRequest();var pousti=`POST`;var nome_faili=`grava_imagem.php`;xhr.open(pousti, nome_faili);xhr.onloadend= function(e) { resposta=xhr.responseText;  };xhr.send(fd);}alert(`teste`);'/>";
