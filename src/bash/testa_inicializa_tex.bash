sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-pre-textual-EESC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-TCC-pre-textual-EESC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-pre-textual-EESC.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-TCC-pre-textual-EESC.tex 

sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-pre-textual-EESC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-TCC-pre-textual-EESC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-pre-textual-IAU.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-pre-textual-IAU.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-pre-textual-IAU.tex

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-TCC-pre-textual-ICMC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-TCC-pre-textual-ICMC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-TCC-pre-textual-ICMC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-pre-textual-IFSC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-pre-textual-IFSC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-pre-textual-IFSC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-pre-textual-IQSC.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-TCC-pre-textual-IQSC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-pre-textual-IQSC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-TCC-pre-textual-IQSC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-pre-textual-IQSC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-TCC-pre-textual-IQSC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-pre-textual-OUTRO.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" USPSC-TCC-pre-textual-OUTROS.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-pre-textual-OUTRO.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" USPSC-TCC-pre-textual-OUTROS.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-pre-textual-OUTRO.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" USPSC-TCC-pre-textual-OUTROS.tex 


sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[titulo]@}/g" USPSC-modelo-ICMCe.tex  | grep -i "titulo"
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-EESC.tex  | grep -i "titulo"
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-EESC.tex  | grep -i "titulo"
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IAU[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-IAU.tex  | grep -i "titulo"
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IAU[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-IAU.tex  | grep -i "titulo"
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex  | grep -i "titulo"
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex  | grep -i "titulo"
sed -i "s/tituloadic[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloadic{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex  | grep -i "titulo"
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex  | grep -i "titulo"
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IFSC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-IFSC.tex  | grep -i "titulo"
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IFSC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-IFSC.tex  | grep -i "titulo"
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-IQSC.tex  | grep -i "titulo"
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-IQSC.tex  | grep -i "titulo"
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-OUTRO.tex  | grep -i "titulo"
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-OUTRO.tex  | grep -i "titulo"
sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[titulo]@}/g" USPSC-TCC-modelo-ICMCe.tex  | grep -i "titulo"


















