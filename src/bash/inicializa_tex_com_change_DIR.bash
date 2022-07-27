#ATENÇÃO -> underscore é um carácter especial para o LaTeX e portanto não pode ser usado como identifiar. Mas o RaderTex utiliza underscore como nome de seções. Provavelmente nao terei problemas se tirar o underscore, mas daí tem que tomar cuidado para não ter um dois identificadores diferentes tipo "titulo_abstract" e "tituloabstract", porque para o LaTeX serã o mesmo identificador

# ATENÇÃO -> o awk tem que ser o mawk. Não funciona com gawk (GNU)

echo "Executando Inicializa "

pwd

# a opção -i do sed cria arquivos temporarios que requerem as permissoes adequadas -> PRESTA ATENÇÃO! Uma solução é fazer cat file > sed > file, e daí o arquivo temporário nao eh criado

sed -i 's/      //g'  ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Dedicatoria.tex
sed -i 's/^M//g'  ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Dedicatoria.tex

sed -i '/^.*textit.*/,/fill}/d' ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Dedicatoria.tex
sed -i 's/noindent/noindent\\textit{@[dedicatoria]@} \\vspace*{\\fill}/g' ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Dedicatoria.tex

sed -i 's/	//g'  ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Agradecimentos.tex
sed -i 's/

sed -i '/begin.agradecimentos/,/end.agradecimentos/{//!d}'  ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Agradecimentos.tex  
sed -i 's/begin.agradecimentos./begin{agradecimentos}\n% @[pontoinsercaoparagrafoagradecimento]@\n/g' ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Agradecimentos.tex 
 
sed -i 's/	//g'  ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Resumo.tex
sed -i 's/

sed -i 's/ O resumo deve ressaltar o  objetivo/% @[pontoinsercaoparagraforesumo]@\napaga_daqui_para_frente/g'  ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Resumo.tex
sed -i '/apaga_daqui_para_frente/,/.cite.nbr6028.\./d' ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Resumo.tex 
sed -i 's/	//g'  ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Resumo.tex
sed -i 's/

sed -i 's/Palavras-chave.:.*/Palavras-chave}: @[palavraschave]@/g' ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Resumo.tex

sed -i '/.*textit.*/,/Albert Einstein}/d' ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Epigrafe.tex
sed -i 's/begin.flushright./begin{flushright}\\textit{@[epigrafe]@}/g' ../../latex/USPSC-3.1/USPSC-TA-PreTextual/USPSC-Epigrafe.tex


sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex 

sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex 

sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex 
sed -i "s/autor{Jos\\\'e da Silva}/autor{@[autor]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex 
sed -i "s/autorficha{Silva, Jos\\\'e da}/autorficha{@[autorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex 
sed -i "s/autorabr{SILVA, J.}/autorabr{@[autorabr]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex 



sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-modelo-ICMCe.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IAU[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IAU[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/tituloadic[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloadic{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IFSC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IFSC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex 
sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-modelo-ICMCe.tex 

sed -i "s/tituloresumo[{]Tutorial do Pacote USPSC para modelos de trabalhos acad\\\^emicos em LaTeX - vers\\\~ao 3.1[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-Tutorial.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/tituloresumo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex    

sed -i "s/renewcommand[{]\\\titleabstract[}][{]@\[titulo\]@[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-modelo-ICMCe.tex                         
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the EESC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IAU[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex                      
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in LaTeX using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IFSC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IQSC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex                    
sed -i "s/titleabstract[{]USPSC Package tutorial for LaTeX academic work templates - version 3.1[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-Tutorial.tex                 
sed -i "s/renewcommand[{]\\\titleabstract[}][{]@\[titulo\]@[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-modelo-ICMCe.tex                     
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the EESC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the IQSC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex               

sed -i "s/titulo[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IFSC[}]/titulo{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex 
sed -i "s/tituloadic[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/tituloadic{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/titulo[{]Model for thesis and dissertations in LaTeX using the USPSC Package to the ICMC[}]/titulo{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 
sed -i "s/titleabstract[{]Model for thesis and dissertations in LaTeX using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex 

sed -i "s/tituloadic[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/tituloadic{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex
sed -i "s/titulo[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titulo{@[tituloabstract]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex

sed -i "s/titulo[{]Modelo para elabora\\\c[{]c[}]\\\~ao de trabalhos acad\\\^emicos em LaTex utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex                     
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex                 
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex                 
sed -i "s/titulo[{]Modelo para elabora\\\c[{]c[}]\\\~ao de trabalhos acad\\\^emicos em LaTex utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex                 
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/titulo{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex               
sed -i "s/tituloadic[{]Modelo para TC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloadic{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/tituloadic[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloadic{@[titulo]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex                 


sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex           
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadoradic[{]Advisor     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor     Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadoradic[{]Orientadora     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{orientador(a)     Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadoradic[{]Advisor     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor     Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadoradic[{]Orientadora     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{orientador(a)     Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadoradic[{]Advisor: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor: Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex                     
sed -i "s/orientadoradic[{]Orientadora: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Orientador(a): Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex                     
sed -i "s/orientadoradic[{]Advisor: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor: Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/orientadoradic[{]Orientadora: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Orientador(a): Prof(a). Dr(a). @[orientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex                 

sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-EESC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IAU.tex                  
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IFSC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-IQSC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-OUTRO.tex                
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-Tutorial.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-EESC.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-IQSC.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-OUTROS.tex           
sed -i "s/coorientadoradic[{] Co-orientador: Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientadoradic{Co-orientador: Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-pre-textual-ICMC.tex                 
sed -i "s/coorientadoradic[{] Co-orientador: Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientadoradic{Co-orientador: Prof(a). Dr(a). @[coorientador]@}/g" ../../latex/USPSC-3.1/USPSC-TCC-pre-textual-ICMC.tex             

#"da USP" aparece apenas em TUTORIAL, então não precisa mudar
# USP Sao Carlos aparece apenas em TUTORIAL e não precisa mudar

#Troca o nome da cidade
touch ../../latex/USPSC-3.1/troca_cidade.bash
chmod u+x ../../latex/USPSC-3.1/troca_cidade.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/local[{]S..ao Carlos[}]/local{@[localidade]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_cidade.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
../../latex/USPSC-3.1/troca_cidade.bash

#Troca ano
touch ../../latex/USPSC-3.1/troca_ano.bash
chmod u+x ../../latex/USPSC-3.1/troca_ano.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/data[{]2021[}]/data{@[ano]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_ano.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
../../latex/USPSC-3.1/troca_ano.bash

#Troca o nome da Universidade
touch ../../latex/USPSC-3.1/troca_universidade.bash
chmod u+x ../../latex/USPSC-3.1/troca_universidade.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Universidade de S\\\\\~ao Paulo/@[universidade]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_universidade.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
../../latex/USPSC-3.1/troca_universidade.bash

#Troca o nome da Universidade maiuscula
touch ../../latex/USPSC-3.1/troca_universidade_m.bash
chmod u+x ../../latex/USPSC-3.1/troca_universidade_m.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/UNIVERSIDADE DE S\\\\\~AO PAULO/@[universidademaiuscula]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_universidade_m.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
../../latex/USPSC-3.1/troca_universidade_m.bash

#Troca o nome da Universidade
touch ../../latex/USPSC-3.1/troca_universidade2.bash
chmod u+x ../../latex/USPSC-3.1/troca_universidade2.bash
find ../../latex/. | grep -i "\.tex" | awk -v aspas="\"" '{print "sed -i \"s/Universidade Estadual Paulista .J\\\\\\"quote"ulio de Mesquita Filho./@[universidade]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_universidade2.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
../../latex/USPSC-3.1/troca_universidade2.bash
#nao ha casos de UNESP maiuscula segundo o verificador

#Troca o nome da unidadefaculdade
touch ../../latex/USPSC-3.1/troca_unidadefaculdade_nome_da_unidade.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade_nome_da_unidade.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Nome da Unidade USP/@[unidadefaculdade]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade_nome_da_unidade.bash
../../latex/USPSC-3.1/troca_unidadefaculdade_nome_da_unidade.bash

#Troca o nome da unidadefaculdade - a troca abaixo tem que vir depois da "Nome da Unidade USP". De outra forma corrompe tudo
touch ../../latex/USPSC-3.1/troca_unidadefaculdade_unidade_usp.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade_unidade_usp.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Unidade USP/@[unidadefaculdade]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade_unidade_usp.bash
../../latex/USPSC-3.1/troca_unidadefaculdade_unidade_usp.bash


#Troca o nome da unidadefaculdade
touch ../../latex/USPSC-3.1/troca_unidade_faculdade_escola.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidade_faculdade_escola.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Escola de Engenharia de S\\\\\~ao Carlos/@[unidadefaculdade]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidade_faculdade_escola.bash
../../latex/USPSC-3.1/troca_unidade_faculdade_escola.bash

#Troca o nome da unidadefaculdademaiuscula
touch ../../latex/USPSC-3.1/troca_unidade_faculdade_escola_maiuscula.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidade_faculdade_escola_maiuscula.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/ESCOLA DE ENGENHARIA DE S\\\\\~AO CARLOS/@[unidadefaculdademaiuscula]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidade_faculdade_escola_maiuscula.bash
../../latex/USPSC-3.1/troca_unidade_faculdade_escola_maiuscula.bash

#Troca o nome da unidadefaculdade mas respeita o chave no final
touch ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final2.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final2.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Faculdade [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[unidadefaculdade]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final2.bash
../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final2.bash

#Troca o nome da unidadefaculdade
touch ../../latex/USPSC-3.1/troca_unidadefaculdade2.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade2.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Faculdade [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[unidadefaculdade]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade2.bash
../../latex/USPSC-3.1/troca_unidadefaculdade2.bash

#Troca o nome da unidadefaculdademaiuscula respeita chave no final
touch ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/FACULDADE [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(MANUFATURA)]*[}]/@[unidadefaculdademaiuscula]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash
../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash


#Troca o nome da unidadefaculdademaiuscula
touch ../../latex/USPSC-3.1/troca_unidadefaculdademaiuscula2.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdademaiuscula2.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/FACULDADE [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(MANUFATURA)]*/@[unidadefaculdademaiuscula]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdademaiuscula2.bash
../../latex/USPSC-3.1/troca_unidadefaculdademaiuscula2.bash

#Troca o nome da unidadefaculdade respeita chave no final
touch ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_3.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_3.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Instituto de [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[unidadefaculdade]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_3.bash
../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_3.bash


#Troca o nome da unidadefaculdade
touch ../../latex/USPSC-3.1/troca_unidadefaculdade3.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade3.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Instituto de [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[unidadefaculdade]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade3.bash
../../latex/USPSC-3.1/troca_unidadefaculdade3.bash

#Troca o nome da unidadefaculdade respeita chave no final
touch ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_4.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_4.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/INSTITUTO DE [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*[}]/@[unidadefaculdademaiuscula]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_4.bash
../../latex/USPSC-3.1/troca_unidadefaculdade_respeita_chave_no_final_4.bash


#Troca o nome da unidadefaculdade
touch ../../latex/USPSC-3.1/troca_unidadefaculdade4.bash
chmod u+x ../../latex/USPSC-3.1/troca_unidadefaculdade4.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/INSTITUTO DE [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*/@[unidadefaculdademaiuscula]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_unidadefaculdade4.bash
../../latex/USPSC-3.1/troca_unidadefaculdade4.bash

#Troca o nome da unidadefaculdade respeita chave no final
touch ../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final.bash
chmod u+x ../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Programa de P\\\\\\"quote"os-Gradua\\\\\c[{]c[}]\\\\\~ao em [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[programapos]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final.bash
../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final.bash

#Troca o nome da unidadefaculdade
touch ../../latex/USPSC-3.1/troca_programa_pos.bash
chmod u+x ../../latex/USPSC-3.1/troca_programa_pos.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Programa de P\\\\\\"quote"os-Gradua\\\\\c[{]c[}]\\\\\~ao em [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[programapos]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_programa_pos.bash
../../latex/USPSC-3.1/troca_programa_pos.bash

#Troca o nome da unidadefaculdademaiuscula respeita chave no final
touch ../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final_maiuscula.bash
chmod u+x ../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final_maiuscula.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/PROGRAMA DE P\\\\\\"quote"OS-GRADUA\\\\\c[{]C[}]\\\\\~AO EM [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*[}]/@[programaposmaiuscula]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final_maiuscula.bash
../../latex/USPSC-3.1/troca_programa_pos_respeita_chave_no_final_maiuscula.bash


#Troca o nome da unidadefaculdademaiuscula
touch ../../latex/USPSC-3.1/troca_programa_pos_maiuscula.bash
chmod u+x ../../latex/USPSC-3.1/troca_programa_pos_maiuscula.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/PROGRAMA DE P\\\\\\"quote"OS-GRADUA\\\\\c[{]C[}]\\\\\~AO EM [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*/@[programaposmaiuscula]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_programa_pos_maiuscula.bash
../../latex/USPSC-3.1/troca_programa_pos_maiuscula.bash

#Troca o nome da curso respeita chave no final
touch ../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final.bash
chmod u+x ../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Curso [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[curso]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final.bash
../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final.bash

#Troca o nome da curso
touch ../../latex/USPSC-3.1/troca_curso.bash
chmod u+x ../../latex/USPSC-3.1/troca_curso.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Curso [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[curso]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_curso.bash
../../latex/USPSC-3.1/troca_curso.bash

#Troca o nome da cursomaiuscula respeita chave no final
touch ../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final_maiuscula.bash
chmod u+x ../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final_maiuscula.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/CURSO [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*[}]/@[cursomaiuscula]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final_maiuscula.bash
../../latex/USPSC-3.1/troca_curso_respeita_chave_no_final_maiuscula.bash

#Troca o nome da cursomaiuscula
touch ../../latex/USPSC-3.1/troca_cursomaiuscula.bash
chmod u+x ../../latex/USPSC-3.1/troca_cursomaiuscula.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/CURSO [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*/@[cursomaiuscula]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_cursomaiuscula.bash
../../latex/USPSC-3.1/troca_cursomaiuscula.bash

#Troca o mestreoudoutor - nao aparece TITULO em maiuscula, segundo o verificador.bash
touch ../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
chmod u+x ../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de Mestre[ ,;]/t\\\\\\"quote"itulo de @[mestreoudoutor]@ /g\" "$0;}' >../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash

#Troca o mestreoudoutor
touch ../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
chmod u+x ../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de Doutor[ ,;]/t\\\\\\"quote"itulo de @[mestreoudoutor]@ /g\" "$0;}' >../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash

#Troca o mestreoudoutor
touch ../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
chmod u+x ../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de Mestre.Doutor/t\\\\\\"quote"itulo de @[mestreoudoutor]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash
../../latex/USPSC-3.1/troca_mestreoudoutor_pos.bash

#Troca o titulo respeita chave no final
touch ../../latex/USPSC-3.1/troca_titulo_respeita_chave_no_final__pos.bash
chmod u+x ../../latex/USPSC-3.1/troca_titulo_respeita_chave_no_final__pos.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/t\\\\\\"quote"itulo de @[titulopos]@}/g\" "$0;}' >../../latex/USPSC-3.1/troca_titulo_respeita_chave_no_final__pos.bash
../../latex/USPSC-3.1/troca_titulo_respeita_chave_no_final__pos.bash

#Troca o titulo
touch ../../latex/USPSC-3.1/troca_titulo_pos.bash
chmod u+x ../../latex/USPSC-3.1/troca_titulo_pos.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/t\\\\\\"quote"itulo de @[titulopos]@/g\" "$0;}' >../../latex/USPSC-3.1/troca_titulo_pos.bash
../../latex/USPSC-3.1/troca_titulo_pos.bash

#Coloca um "para" entre os tags de programa_pos e unidadefaculdade, que eh uma forma forcada de resolver o problema 
touch ../../latex/USPSC-3.1/afasta_programa_unidade.bash
chmod u+x ../../latex/USPSC-3.1/afasta_programa_unidade.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@\[programapos\]@@\[unidadefaculdade\]@/@[programapos]@ vinculado a @[unidadefaculdade]@/g\" "$0;}' > ../../latex/USPSC-3.1/afasta_programa_unidade.bash
../../latex/USPSC-3.1/afasta_programa_unidade.bash


#á
touch ../../latex/USPSC-3.1/troca_acento_agudo_a.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_a.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/á/\\\\\\"quote"a/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_a.bash
../../latex/USPSC-3.1/troca_acento_agudo_a.bash

#Á
touch ../../latex/USPSC-3.1/troca_acento_agudo_a_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_a_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Á/\\\\\\"quote"A/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_a_M.bash
../../latex/USPSC-3.1/troca_acento_agudo_a_M.bash

#é
touch ../../latex/USPSC-3.1/troca_acento_agudo_e.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_e.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/é/\\\\\\"quote"e/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_e.bash
../../latex/USPSC-3.1/troca_acento_agudo_e.bash

#É
touch ../../latex/USPSC-3.1/troca_acento_agudo_e_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_e_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/É/\\\\\\"quote"E/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_e_M.bash
../../latex/USPSC-3.1/troca_acento_agudo_e_M.bash

#â
touch ../../latex/USPSC-3.1/troca_acento_flex_a.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_flex_a.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/â/\\\\\\"quote"a/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_flex_a.bash
../../latex/USPSC-3.1/troca_acento_flex_a.bash

#Â
touch ../../latex/USPSC-3.1/troca_acento_flex_a_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_flex_a_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/Â/\\\\\\"quote"A/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_flex_a_M.bash
../../latex/USPSC-3.1/troca_acento_flex_a_M.bash

#ê
touch ../../latex/USPSC-3.1/troca_acento_flex_e.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_flex_e.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/ê/\\\\\\"quote"e/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_flex_e.bash
../../latex/USPSC-3.1/troca_acento_flex_e.bash

#Ê
touch ../../latex/USPSC-3.1/troca_acento_flex_e_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_flex_e_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/Ê/\\\\\\"quote"E/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_flex_e_M.bash
../../latex/USPSC-3.1/troca_acento_flex_e_M.bash

#à
touch ../../latex/USPSC-3.1/troca_acento_crase.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_crase.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="\`" '{print "sed -i \"s/à/\\\\\\\\\\"quote"a/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_crase.bash
../../latex/USPSC-3.1/troca_acento_crase.bash

#À
touch ../../latex/USPSC-3.1/troca_acento_crase_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_crase_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="\`" '{print "sed -i \"s/À/\\\\\\\\\\"quote"A/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_crase_M.bash
../../latex/USPSC-3.1/troca_acento_crase_M.bash

#ä
touch ../../latex/USPSC-3.1/troca_acento_trema_a.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_trema_a.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="\"" '{print "sed -i \"s/ä/\\\\\\"quote"a/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_trema_a.bash
../../latex/USPSC-3.1/troca_acento_trema_a.bash

#Ä
touch ../../latex/USPSC-3.1/troca_acento_trema_a_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_trema_a_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="\"" '{print "sed -i \"s/Ä/\\\\\\"quote"A/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_trema_a_M.bash
../../latex/USPSC-3.1/troca_acento_trema_a_M.bash

#ç
touch ../../latex/USPSC-3.1/troca_acento_cedilha.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_cedilha.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="none" '{print "sed -i \"s/ç/\\\\\\c{c}/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_cedilha.bash
../../latex/USPSC-3.1/troca_acento_cedilha.bash

#Ç
touch ../../latex/USPSC-3.1/troca_acento_cedilha_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_cedilha_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="none" '{print "sed -i \"s/Ç/\\\\\\c{C}/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_cedilha_M.bash
../../latex/USPSC-3.1/troca_acento_cedilha_M.bash

#õ
touch ../../latex/USPSC-3.1/troca_acento_til_o.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_til_o.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/õ/\\\\\\"quote"o/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_til_o.bash
../../latex/USPSC-3.1/troca_acento_til_o.bash

#Õ
touch ../../latex/USPSC-3.1/troca_acento_til_o_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_til_o_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/Õ/\\\\\\"quote"O/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_til_o_M.bash
../../latex/USPSC-3.1/troca_acento_til_o_M.bash

#ã
touch ../../latex/USPSC-3.1/troca_acento_til_a.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_til_a.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/ã/\\\\\\"quote"a/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_til_a.bash
../../latex/USPSC-3.1/troca_acento_til_a.bash

#Ã
touch ../../latex/USPSC-3.1/troca_acento_til_a_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_til_a_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/Ã/\\\\\\"quote"A/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_til_a_M.bash
../../latex/USPSC-3.1/troca_acento_til_a_M.bash

#í
touch ../../latex/USPSC-3.1/troca_acento_agudo_i.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_i.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/í/\\\\\\"quote"{\\\\\\i}/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_i.bash
../../latex/USPSC-3.1/troca_acento_agudo_i.bash

#Í
touch ../../latex/USPSC-3.1/troca_acento_agudo_i_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_i_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Í/\\\\\\"quote"I/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_i_M.bash
../../latex/USPSC-3.1/troca_acento_agudo_i_M.bash

#ó
touch ../../latex/USPSC-3.1/troca_acento_agudo_o.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_o.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/ó/\\\\\\"quote"o/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_o.bash
../../latex/USPSC-3.1/troca_acento_agudo_o.bash

#Ó
touch ../../latex/USPSC-3.1/troca_acento_agudo_o_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_o_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Ó/\\\\\\"quote"O/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_o_M.bash
../../latex/USPSC-3.1/troca_acento_agudo_o_M.bash

#ô
touch ../../latex/USPSC-3.1/troca_acento_flex_o.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_flex_o.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/ô/\\\\\\"quote"o/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_flex_o.bash
../../latex/USPSC-3.1/troca_acento_flex_o.bash

#Ô
touch ../../latex/USPSC-3.1/troca_acento_flex_o_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_flex_o_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/Ô/\\\\\\"quote"O/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_flex_o_M.bash
../../latex/USPSC-3.1/troca_acento_flex_o_M.bash

#ú
touch ../../latex/USPSC-3.1/troca_acento_agudo_u.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_u.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/ú/\\\\\\"quote"u/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_u.bash
../../latex/USPSC-3.1/troca_acento_agudo_u.bash

#ü
touch ../../latex/USPSC-3.1/troca_acento_trema_u.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_trema_u.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/ü/\\\\\\"quote"u/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_trema_u.bash
../../latex/USPSC-3.1/troca_acento_trema_u.bash

#Ú
touch ../../latex/USPSC-3.1/troca_acento_agudo_u_M.bash
chmod u+x ../../latex/USPSC-3.1/troca_acento_agudo_u_M.bash
find ../../latex/. | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Ú/\\\\\\"quote"U/g\" "$0;}' >../../latex/USPSC-3.1/troca_acento_agudo_u_M.bash
../../latex/USPSC-3.1/troca_acento_agudo_u_M.bash

































































