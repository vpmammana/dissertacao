// FUNCOES ESPECIFICAS PARA O CASO DE ALUIZIO

function carrega_instituicao(){

           var resposta='';
           var url='../php/carrega_instituicao.php';

           var oReq=new XMLHttpRequest();
           oReq.open('GET', url, false);
           oReq.onload = function (e) {
                     resposta=oReq.responseText.replace(/(\r\n|\n|\r)/gm,"");
                                         // window.location.reload(true);
					document.getElementById("drop_1_2").setAttribute("data-fkid",resposta);
                     }
           oReq.send();



}

carrega_instituicao();

// FUNCOES QUE PARECEM IMPORTANTES MAS NAO ESTAVAM NO BLOCO DO DROPMENU


// atualiza() recebe uma matriz com todos os campos que precisam ser atualizados (menos foreign keys).

function atualiza_geral (tabela, campo, valor, id){

		var campo=document.getElementById(id_elemento_campo);
	                var resposta='';
	                var url='../php/atualiza_campos.php?banco=escolax&tabela='+tabela+'&campo='+campo+'&id='+id+'&valor='+valor;
	                var oReq=new XMLHttpRequest();
			oReq.open('GET', url, false);
			oReq.onload = function (e) {
				resposta=oReq.responseText;
				alert(resposta);
			}
                oReq.send();
}


function atualiza_fk (id_elemento_campo){

		var campo=document.getElementById(id_elemento_campo);
	                var resposta='';
	                var url='../php/atualiza_campos.php?banco=escolax&tabela='+campo.getAttribute('data-tabela')+'&campo='+campo.getAttribute('data-campo')+'&id='+campo.getAttribute('data-id')+'&valor='+campo.getAttribute('data-fkid')+'&nome='+campo.getAttribute('data-default');
	                var oReq=new XMLHttpRequest();
			oReq.open('GET', url, false);
			oReq.onload = function (e) {
				resposta=oReq.responseText;
				//alert(resposta);
			}
                oReq.send();
}



function desliga_autocomplete(){
// tira o auto complete dos campos dropbtn
var inputElements = document.getElementsByTagName('input');
for (i=0; inputElements[i]; i++) {
if (inputElements[i].className && (inputElements[i].className.indexOf('dropbtn') != -1)) {
inputElements[i].setAttribute('autocomplete','caramba');
}
}
}

desliga_autocomplete();

var x = document.getElementsByClassName('dropbtn');
var i;
for (i = 0; i < x.length; i++) {
// o programa auto_ler_tabela_campo.php é usado para buscar os dados na tabela chave (foreign key)
// se o dropbtn for de inserao de dados, ao inves de atualização, nao faz sentido buscar dados na base, porque o campo tem que estar vazio
  if(x[i].getAttribute('data-momento')=='atualizacao'){
           var resposta='';
           var url='../php/auto_ler_tabela_campo.php?banco=escolax&tabela='+x[i].getAttribute('data-fk-tabela')+'&campo_id='+x[i].getAttribute('data-fk-id')+'&id='+x[i].getAttribute('data-fkid');
           var oReq=new XMLHttpRequest();
           oReq.open('GET', url, false);
           oReq.onload = function (e) {
                     resposta=oReq.responseText;
	             x[i].value=resposta;
                     x[i].setAttribute('data-default',resposta.replace(/(\r\n|\n|\r)/gm,""));
                     }
           oReq.send();
       }
}

// INICIO DOS SCRIPTS DO DROP MENU

function carrega_drop_btn(element){

  if(element.getAttribute('data-momento')=='atualizacao'){
           var resposta='';
		   var url='../php/auto_ler_tabela_campo.php?banco=escolax&tabela='+element.getAttribute('data-fk-tabela')+'&campo_id='+element.getAttribute('data-fk-id')+'&id='+element.getAttribute('data-fkid');
           var oReq=new XMLHttpRequest();
           oReq.open('GET', url, false);
           oReq.onload = function (e) {
                     resposta=oReq.responseText;
                     element.value=resposta;
                     element.setAttribute('data-default',resposta);
		     alert("Você alterou a instituição para: "+resposta);
                     }
           oReq.send();
       }
} // carrega_drop_btn


function ativa_eventos_dropbtn(){ // ativa os eventos de teclado e demais dos dropbtn

var drops=document.getElementsByClassName('dropbtn');
var i;
for (i=0; i<drops.length; i++) {
//console.log(drops[i].id);
var drop_singular=drops[i];


// blur é quando perde o foco: input value tem que retornar ao valor default
// importante verificar se o elemento já tem o evento registrado, antes de registrar um novo. De outra forma, posso ter um x=x+2 para o valor de selecionado porque registro dois eventos que fazem x=x=+1...
if (drop_singular.getAttribute('data-event-blur')==='NAO') {drop_singular.addEventListener('blur', function(e){e.target.setAttribute('data-event-blur','BLUR');  e.target.value=e.target.getAttribute('data-default');}, false);}
if (drop_singular.getAttribute('data-event-focus')==='NAO'){drop_singular.addEventListener('focus',function(e){e.target.setAttribute('data-event-focus','FOCUS');   cai(e.target.id,e.target.getAttribute('data-drop')); e.target.value=''; e.target.value='';}, false);}
if (drop_singular.getAttribute('data-event-keyup')==='NAO') {drop_singular.addEventListener('keyup', 
		function(e){ 
			        e.target.setAttribute('data-event-keyup','KEYUP');
				var selecionado=e.target.getAttribute('data-selecionado');
                                var n_itens=e.target.getAttribute('data-n-itens');
	
				if ((e.keyCode==40) && ((selecionado<parseInt(n_itens)-1) || (selecionado<0)) ) {
							e.target.setAttribute('data-selecionado',parseInt(selecionado)+1);
						   }
 
				if ((e.keyCode==38) && (selecionado>-1)) {
							e.target.setAttribute('data-selecionado',parseInt(selecionado)-1);
						   }
if ((e.keyCode==27) && (e.target.getAttribute('data-momento')=='insercao')) { e.target.setAttribute('data-default','');} // limpa o campo se apertar ESC - importante se o usuario desistir 
				if ((e.keyCode<28) 
					&& (e.keyCode!=9) // evita que saia do dropbox quando o tab é usado 
					&& (e.keyCode!=14) // evita que saia do dropbox quando ocorre shift in 
					&& (e.keyCode!=15) // no manual dizia que shift out é 15, mas parece que 16 na verdade
					&& (e.keyCode!=16)) { // evita que saia do dropbox com SHIFT out
                                                        //console.log(e.keyCode);
							
							if (e.keyCode==13){
                                                                //console.log('selecionado: '+e.target.getAttribute('data-selecionado'));
                                                                //console.log('id input: '+e.target.getAttribute('data-fkid'));
                                                                var drop_elem=e.target.getAttribute('data-drop');
								//console.log('drop element: '+drop_elem);
								e.target.setAttribute('data-fkid',document.getElementById('a_'+drop_elem+'_'+e.target.getAttribute('data-selecionado')).getAttribute('data-id-fk'));
                                                            if (e.target.getAttribute('data-momento')=='atualizacao'){
								atualiza_fk(e.target.id);
								carrega_drop_btn(e.target);}
								else {e.target.value=document.getElementById('a_'+drop_elem+'_'+e.target.getAttribute('data-selecionado')).getAttribute('data-innertext');
e.target.setAttribute('data-default',e.target.value);
//console.log('target: '+e.target.value);
}
								
							} else {e.target.value=e.target.getAttribute('data-default');}
							e.target.setAttribute('data-keyup','inativo');
                                                        if (e.keyCode==8){
										e.target.value='';
										cai(e.target.id,e.target.getAttribute('data-drop'));
									} else {
                                                        			document.activeElement.blur();
                                                                               }

							
						
						   }
 
				else {
					cai(e.target.id,e.target.getAttribute('data-drop'));
				     }
//console.log(selecionado);
		}, false);}
}
}
// fim da funcao que atribui eventos aos dropbtn

ativa_eventos_dropbtn();

function cai(id_input,id_div){


var elemento_input=document.getElementById(id_input);
var elemento_div=document.getElementById(id_div);


console.log("lefto: "+ elemento_input.getBoundingClientRect().left);
console.log("top: "+ elemento_input.getBoundingClientRect().bottom);
console.log("data-selecionado: "+document.getElementById("drop_1_2").getAttribute("data-selecionado"));

elemento_div.style.left = elemento_input.getBoundingClientRect().left+"px";
//elemento_div.style.top  = elemento_input.getBoundingClientRect().bottom +  "px"; // não estou somando window.scrollY porque nao tem scroll no menu.  
elemento_div.style.top  = elemento_input.style.bottom ; // não estou somando window.scrollY porque nao tem scroll no menu.  console.log("XXXX -> " + elemento_input.parentElement.tagName);

var str_busca=elemento_input.value;

if ((str_busca!='') || (parseInt(elemento_input.getAttribute('data-selecionado'))>-1)) {

		elemento_div.setAttribute('data-keyup','keyup');
		var fk_banco=elemento_input.getAttribute('data-fk-banco');
		var fk_tabela=elemento_input.getAttribute('data-fk-tabela');
		var fk_campo=elemento_input.getAttribute('data-fk-id');
		var fk_campo_mostrado=elemento_input.getAttribute('data-fk-campo-mostrado');
		var max_itens=elemento_input.getAttribute('data-max-itens');
		busca_lista(id_input, id_div,fk_banco, fk_tabela, fk_campo, str_busca, max_itens, fk_campo_mostrado);
               
		} 
		else {elemento_div.setAttribute('data-keyup','inativo');}
}


function busca_lista(elemento_input, elemento, banco, tabela, campo, str_busca, max_itens, campo_mostrado){
// busca a lista de valores de campos fk, de acordo com o nome_, usando o que foi teclado como search. Coloca no dropdown
           var resposta='';
           var url='../php/busca_str.php?banco='+banco+'&tabela='+tabela+'&campo='+campo+'&str_busca='+str_busca+'&campo_mostrado='+campo_mostrado+'&nome_tipo_secao=item_de_referencia';
           var oReq=new XMLHttpRequest();
           oReq.open('GET', url, false);
           oReq.onload = function (e) {
								var input=document.getElementById(elemento_input);
                                                                var myNode=document.getElementById(elemento); //é o div?
			
								while (myNode.firstChild) {
								myNode.removeChild(myNode.firstChild);
								}		

                     resposta=oReq.responseText;
                     var matriz=resposta.split('<br>', max_itens);
		     // pode acontecer, como é o caso das tabelas autorizacoes, curadores_conteudos e expectadores, de uma tabela fazer referencia a uma outra sem nome_%
                     if (matriz[0].includes('veio nome')) // a resposta do php completa eh (nao veio nome). Usei uma fracao por causa do acento 
					{
						// se percebe que nao veio nome, ou seja, nao tem nome_, entao ele busca um subselect
						 busca_lista_sub_select(elemento_input, elemento, banco, tabela, campo, str_busca, max_itens);
                                                 return;
					}
 
                     var conta=0;

                     matriz.forEach(function (item, index) {
 							   //console.log('>'+item+'<');
							   if (item.trim()!=''){
								var node = document.createElement('a');            // Create a <li> node
                     						var item_matriz=item.split('<rb>', max_itens);
								var att_innertext = document.createAttribute('data-innertext');
							        att_innertext.value = item_matriz[0];
								node.setAttributeNode(att_innertext);	
								var att_id = document.createAttribute('data-id-fk');
							        att_id.value =	item_matriz[1];
								node.setAttributeNode(att_id);	
                                                                node.id='a_'+elemento+'_'+conta;
								var textnode = document.createTextNode('#'+item_matriz[0]+'#');     // Create a text node
                                                                textnode.id='text_'+elemento+'_'+conta;
								node.appendChild(textnode);                        // Append the text to <a>
								myNode.appendChild(node);     // Append <a> to <div> with id='lista'
								node.addEventListener('mousedown',function (){console.log('clicou');},false);
								if (index==input.getAttribute('data-selecionado'))
									{
										node.style.backgroundColor='#000000';
										node.style.color='#FFFFFF';
									}
								conta=conta+1;
                                                                           }

                                                           ;}
							   );
							   input.setAttribute('data-n-itens',conta);
                     }
           oReq.send();

}

function busca_lista_sub_select(elemento_input, elemento, banco, tabela, campo, str_busca, max_itens){
// funcao para o caso da tabela foreign nao ter nome_... dai tem que buscar na tabela fk da fk.
           //console.log(str_busca);
           var resposta='';
           var url='../php/busca_registro_inteiro.php?banco='+banco+'&tabela='+tabela+'&nome_chave_primaria='+campo+'&busca_str='+str_busca;
           // este codigo PHP busca apenas os campos que nao estao na tabela campos_excluidos... isso reduz o tamanho do string que aparece no dropdown
           var oReq=new XMLHttpRequest();
           oReq.open('GET', url, false);
           oReq.onload = function (e) {
								var input=document.getElementById(elemento_input);
                                                                var myNode=document.getElementById(elemento); //é o div?
			
								while (myNode.firstChild) {
								myNode.removeChild(myNode.firstChild);
								}		

                     resposta=oReq.responseText;
                     var matriz=resposta.split('<br>', max_itens);
		     // pode acontecer, como é o caso das tabelas autorizacoes, curadores_conteudos e expectadores, de uma tabela fazer referencia a uma outra sem nome_%
                     var conta=0;

                     matriz.forEach(function (item, index) {
							   if (item.trim()!=''){

 							   //console.log('>'+item+'<');
								var node = document.createElement('a');            // Create a <li> node
                     						var item_matriz=item.split('<rb>', max_itens);
							//console.log(item_matriz[0]);
								var att_innertext = document.createAttribute('data-innertext');
							        att_innertext.value = item_matriz[0];
								node.setAttributeNode(att_innertext);	
								var att_id = document.createAttribute('data-id-fk');
							        att_id.value =	item_matriz[1];
								node.setAttributeNode(att_id);	
                                                                node.id='a_'+elemento+'_'+conta;
								var textnode = document.createTextNode('#'+item_matriz[0]+'#');     // Create a text node
                                                                textnode.id='text_'+elemento+'_'+conta;
								node.appendChild(textnode);                        // Append the text to <a>
								myNode.appendChild(node);     // Append <a> to <div> with id='lista'
								node.addEventListener('mousedown',function (){console.log('clicou');},false);
								if (index==input.getAttribute('data-selecionado'))
									{
										node.style.backgroundColor='#000000';
										node.style.color='#FFFFFF';
									}
								conta=conta+1;
                                                                           }

                                                           ;}
							   );
							   input.setAttribute('data-n-itens',conta);
                     }
           oReq.send();
}

// FIM DOS SCRIPTS DO DROP MENU

