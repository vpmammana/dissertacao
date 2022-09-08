
O PROCEDIMENTO ABAIXO ESTÁ DESATUALIZADO, MAS explicita a filosofia do processo de conversão
============================================================================================

		Para gerar o sistema de conversao LATEX, primeiro é preciso recuperar os originais do modelo criado pela usp, com:
		
		unzip USPSC-3.1.zip
		
		Os arquivos serao recuperados.
		
		Depois eh preciso inicializar o sistema, com
		
		inicializa_tex.bash
		
		depois é preciso passar os dados da base para o modelo da USP com 
		
		./copia_substitui_tex.bash
		
		depois é preciso criar o pdf:
		
		com pdflatex USPSC-modelo-IAU_RedarTex.tex


IMPORTANTE
==========

Para rodar o gera_tex2.php do command prompt tem que mimetizar o usuário www-data, com o sudo abaixo:

sudo -u www-data php gera_tex2.php 2>&1 saida_gera_tex2.txt

parece que é preciso fazer (checar):

sudo chown -R www-data:www-data /var/www/html/dev_vitor/tese_*

Se não fizer isso, o usuário www-data não consegue fazer chmod nos arquivos. Mas isso é verdade para o gera_tex2.php chamdo pelo prompt do linux. Se chamar pelo apache, ainda não tenho certeza do que vai acontecer.

Mas quando coloca www-data:www-data com chown, pode dar problema para fazer git add --all .

Eu ainda não consegui mapear como a mudança de usuário mudaria o comportamneto do git, porque supostamente o usuário vitor está no grupo de www-data


