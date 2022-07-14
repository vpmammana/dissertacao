Para gerar o sistema de conversao LATEX, primeiro é preciso recuperar os originais do modelo criado pela usp, com:

unzip USPSC-3.1.zip

Os arquivos serao recuperados.

Depois eh preciso inicializar o sistema, com

inicializa_tex.bash

depois é preciso passar os dados da base para o modelo da USP com 

./copia_substitui_tex.bash

depois é preciso criar o pdf:

com pdflatex USPSC-modelo-IAU_RedarTex.tex
