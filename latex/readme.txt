
O PROCEDIMENTO ABAIXO EST\'A DESATUALIZADO, MAS explicita a filosofia do processo de convers\~ao
============================================================================================

		Para gerar o sistema de conversao LATEX, primeiro \'e preciso recuperar os originais do modelo criado pela usp, com:
		
		unzip USPSC-3.1.zip
		
		Os arquivos serao recuperados.
		
		Depois eh preciso inicializar o sistema, com
		
		inicializa_tex.bash
		
		depois \'e preciso passar os dados da base para o modelo da USP com 
		
		./copia_substitui_tex.bash
		
		depois \'e preciso criar o pdf:
		
		com pdflatex USPSC-modelo-IAU_RedarTex.tex


IMPORTANTE
==========

Para rodar o gera_tex2.php do command prompt tem que mimetizar o usu\'ario www-data, com o sudo abaixo:

sudo -u www-data php gera_tex2.php 2>&1 saida_gera_tex2.txt

parece que \'e preciso fazer (checar):

sudo chown -R www-data:www-data /var/www/html/dev_vitor/tese_*

Se n\~ao fizer isso, o usu\'ario www-data n\~ao consegue fazer chmod nos arquivos. Mas isso \'e verdade para o gera_tex2.php chamdo pelo prompt do linux. Se chamar pelo apache, ainda n\~ao tenho certeza do que vai acontecer.

Mas quando coloca www-data:www-data com chown, pode dar problema para fazer git add --all .

Eu ainda n\~ao consegui mapear como a mudan\c{c}a de usu\'ario mudaria o comportamneto do git, porque supostamente o usu\'ario vitor est\'a no grupo de www-data


