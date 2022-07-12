#ATENÇÃO -> underscore é um carácter especial para o LaTeX e portanto não pode ser usado como identifiar. Mas o RaderTex utiliza underscore como nome de seções. Provavelmente nao terei problemas se tirar o underscore, mas daí tem que tomar cuidado para não ter um dois identificadores diferentes tipo "titulo_abstract" e "tituloabstract", porque para o LaTeX serã o mesmo identificador

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


sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" USPSC-modelo-ICMCe.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-EESC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-EESC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IAU[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-IAU.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IAU[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-IAU.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/tituloadic[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloadic{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IFSC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-IFSC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IFSC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-IFSC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-IQSC.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-IQSC.tex 
sed -i "s/titulo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-OUTRO.tex 
sed -i "s/tituloresumo[{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-OUTRO.tex 
sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" USPSC-TCC-modelo-ICMCe.tex 

sed -i "s/tituloresumo[{]Tutorial do Pacote USPSC para modelos de trabalhos acad\\\^emicos em LaTeX - vers\\\~ao 3.1[}]/tituloresumo{@[titulo]@}/g" USPSC-pre-textual-Tutorial.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/tituloresumo{@[titulo]@}/g" USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloresumo{@[titulo]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/tituloresumo{@[titulo]@}/g" USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/tituloresumo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/tituloresumo{@[titulo]@}/g" USPSC-TCC-pre-textual-OUTROS.tex    

sed -i "s/renewcommand[{]\\\titleabstract[}][{]@\[titulo\]@[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" USPSC-modelo-ICMCe.tex                         
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the EESC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-EESC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IAU[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-IAU.tex                      
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-ICMC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in LaTeX using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-ICMC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IFSC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-IFSC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IQSC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-IQSC.tex                     
sed -i "s/titleabstract[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-OUTRO.tex                    
sed -i "s/titleabstract[{]USPSC Package tutorial for LaTeX academic work templates - version 3.1[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-Tutorial.tex                 
sed -i "s/renewcommand[{]\\\titleabstract[}][{]@\[titulo\]@[}]/renewcommand{\\\titleabstract}{@[tituloabstract]@}/g" USPSC-TCC-modelo-ICMCe.tex                     
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the EESC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-TCC-pre-textual-EESC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the IQSC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-TCC-pre-textual-IQSC.tex                 
sed -i "s/titleabstract[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package[}]/titleabstract{@[tituloabstract]@}/g" USPSC-TCC-pre-textual-OUTROS.tex               

sed -i "s/titulo[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the IFSC[}]/titulo{@[tituloabstract]@}/g" USPSC-pre-textual-IFSC.tex 
sed -i "s/tituloadic[{]Model for thesis and dissertations in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/tituloadic{@[tituloabstract]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/titulo[{]Model for thesis and dissertations in LaTeX using the USPSC Package to the ICMC[}]/titulo{@[tituloabstract]@}/g" USPSC-pre-textual-ICMC.tex 
sed -i "s/titleabstract[{]Model for thesis and dissertations in LaTeX using the USPSC Package to the ICMC[}]/titleabstract{@[tituloabstract]@}/g" USPSC-pre-textual-ICMC.tex 

sed -i "s/tituloadic[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/tituloadic{@[tituloabstract]@}/g" USPSC-TCC-pre-textual-ICMC.tex
sed -i "s/titulo[{]Model for TCC in \\\LaTeX\\\ using the USPSC Package to the ICMC[}]/titulo{@[tituloabstract]@}/g" USPSC-TCC-pre-textual-ICMC.tex

sed -i "s/titulo[{]Modelo para elabora\\\c[{]c[}]\\\~ao de trabalhos acad\\\^emicos em LaTex utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" USPSC-pre-textual-IQSC.tex                     
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para a EESC[}]/titulo{@[titulo]@}/g" USPSC-TCC-pre-textual-EESC.tex                 
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/titulo{@[titulo]@}/g" USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" USPSC-TCC-pre-textual-IQSC.tex                 
sed -i "s/titulo[{]Modelo para elabora\\\c[{]c[}]\\\~ao de trabalhos acad\\\^emicos em LaTex utilizando o Pacote USPSC para o IQSC[}]/titulo{@[titulo]@}/g" USPSC-TCC-pre-textual-IQSC.tex                 
sed -i "s/titulo[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC[}]/titulo{@[titulo]@}/g" USPSC-TCC-pre-textual-OUTROS.tex               
sed -i "s/tituloadic[{]Modelo para TC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloadic{@[titulo]@}/g" USPSC-TCC-pre-textual-ICMC.tex                 


sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-EESC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-EESC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-IAU.tex           
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-IAU.tex           
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadoradic[{]Advisor     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor     Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadoradic[{]Orientadora     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{orientador(a)     Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-ICMC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-IFSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-IFSC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-IQSC.tex          
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-IQSC.tex          
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-OUTRO.tex         
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-pre-textual-Tutorial.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-EESC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadoradic[{]Advisor     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor     Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadoradic[{]Orientadora     Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{orientador(a)     Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-ICMC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-IQSC.tex      
sed -i "s/orientador[{]Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientador{Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorcorpoficha[{]orientadora Elisa Gon\\\c[{]c[}]alves Rodrigues ;  co-orientador Jo\\\~ao Alves Serqueira[}]/orientadorcorpoficha{orientador(a) @[orientador]@}/g" USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadorficha[{]Rodrigues, Elisa Gon\\\c[{]c[}]alves, orient. II. Serqueira, Jo\\\~ao Alves, co-orient[}]/orientadorficha{@[orientadorficha]@}/g" USPSC-TCC-pre-textual-OUTROS.tex    
sed -i "s/orientadoradic[{]Advisor: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor: Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-ICMC.tex                     
sed -i "s/orientadoradic[{]Orientadora: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Orientador(a): Prof(a). Dr(a). @[orientador]@}/g" USPSC-pre-textual-ICMC.tex                     
sed -i "s/orientadoradic[{]Advisor: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Advisor: Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex                 
sed -i "s/orientadoradic[{]Orientadora: Profa. Dra. Elisa Gon\\\c[{]c[}]alves Rodrigues[}]/orientadoradic{Orientador(a): Prof(a). Dr(a). @[orientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex                 

sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-EESC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-IAU.tex                  
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-ICMC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-IFSC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-IQSC.tex                 
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-OUTRO.tex                
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-Tutorial.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-TCC-pre-textual-EESC.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-TCC-pre-textual-IQSC.tex             
sed -i "s/coorientador[{]Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientador{Prof(a). Dr(a). @[coorientador]@}/g" USPSC-TCC-pre-textual-OUTROS.tex           
sed -i "s/coorientadoradic[{] Co-orientador: Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientadoradic{Co-orientador: Prof(a). Dr(a). @[coorientador]@}/g" USPSC-pre-textual-ICMC.tex                 
sed -i "s/coorientadoradic[{] Co-orientador: Prof. Dr. Jo\\\~ao Alves Serqueira[}]/coorientadoradic{Co-orientador: Prof(a). Dr(a). @[coorientador]@}/g" USPSC-TCC-pre-textual-ICMC.tex             

#Troca o nome da Universidade
touch troca_universidade.bash
chmod u+x troca_universidade.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Universidade de S\\\\\~ao Paulo/@[universidade]@/g\" "$0;}' > troca_universidade.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
#./troca_universidade.bash

#Troca o nome da unidadefaculdade
touch troca_unidadefaculdade.bash
chmod u+x troca_unidadefaculdade.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Escola de Engenharia de S\\\\\~ao Carlos/@[unidadefaculdade]@/g\" "$0;}' > troca_unidadefaculdade.bash
#./troca_unidadefaculdade.bash

#Troca o nome da curso
#touch troca_curso.bash
#chmod u+x troca_curso.bash
#find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Curso de Engenharia [A-Za-z\\'[{][}]\~\^\"\`( de )( e )(Manufatura)]*/@[curso]@/g\" "$0;}' > troca_curso.bash
#./troca_curso.bash


#á
touch troca_acento_agudo_a.bash
chmod u+x troca_acento_agudo_a.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/á/\\\\\\"quote"a/g\" "$0;}' > troca_acento_agudo_a.bash
#./troca_acento_agudo_a.bash

#Á
touch troca_acento_agudo_a_M.bash
chmod u+x troca_acento_agudo_a_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Á/\\\\\\"quote"A/g\" "$0;}' > troca_acento_agudo_a_M.bash
#./troca_acento_agudo_a_M.bash

#é
touch troca_acento_agudo_e.bash
chmod u+x troca_acento_agudo_e.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/é/\\\\\\"quote"e/g\" "$0;}' > troca_acento_agudo_e.bash
#./troca_acento_agudo_e.bash

#É
touch troca_acento_agudo_e_M.bash
chmod u+x troca_acento_agudo_e_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/É/\\\\\\"quote"E/g\" "$0;}' > troca_acento_agudo_e_M.bash
#./troca_acento_agudo_e_M.bash

#â
touch troca_acento_flex_a.bash
chmod u+x troca_acento_flex_a.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/â/\\\\\\"quote"a/g\" "$0;}' > troca_acento_flex_a.bash
#./troca_acento_flex_a.bash

#Â
touch troca_acento_flex_a_M.bash
chmod u+x troca_acento_flex_a_M.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/Â/\\\\\\"quote"A/g\" "$0;}' > troca_acento_flex_a_M.bash
#./troca_acento_flex_a_M.bash

#ê
touch troca_acento_flex_e.bash
chmod u+x troca_acento_flex_e.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/ê/\\\\\\"quote"e/g\" "$0;}' > troca_acento_flex_e.bash
#./troca_acento_flex_e.bash

#Ê
touch troca_acento_flex_e_M.bash
chmod u+x troca_acento_flex_e_M.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/Ê/\\\\\\"quote"E/g\" "$0;}' > troca_acento_flex_e_M.bash
#./troca_acento_flex_e_M.bash

#à
touch troca_acento_crase.bash
chmod u+x troca_acento_crase.bash
find * | grep -i "\.tex" | awk -v quote="\`" '{print "sed -i \"s/à/\\\\\\\\\\"quote"a/g\" "$0;}' > troca_acento_crase.bash
#./troca_acento_crase.bash

#À
touch troca_acento_crase_M.bash
chmod u+x troca_acento_crase_M.bash
find * | grep -i "\.tex" | awk -v quote="\`" '{print "sed -i \"s/À/\\\\\\\\\\"quote"A/g\" "$0;}' > troca_acento_crase_M.bash
#./troca_acento_crase_M.bash

#ä
touch troca_acento_trema_a.bash
chmod u+x troca_acento_trema_a.bash
find * | grep -i "\.tex" | awk -v quote="\"" '{print "sed -i \"s/ä/\\\\\\"quote"a/g\" "$0;}' > troca_acento_trema_a.bash
#./troca_acento_trema_a.bash

#Ä
touch troca_acento_trema_a_M.bash
chmod u+x troca_acento_trema_a_M.bash
find * | grep -i "\.tex" | awk -v quote="\"" '{print "sed -i \"s/Ä/\\\\\\"quote"A/g\" "$0;}' > troca_acento_trema_a_M.bash
#./troca_acento_trema_a_M.bash

#ç
touch troca_acento_cedilha.bash
chmod u+x troca_acento_cedilha.bash
find * | grep -i "\.tex" | awk -v quote="none" '{print "sed -i \"s/ç/\\\\\\c{c}/g\" "$0;}' > troca_acento_cedilha.bash
#./troca_acento_cedilha.bash

#Ç
touch troca_acento_cedilha_M.bash
chmod u+x troca_acento_cedilha_M.bash
find * | grep -i "\.tex" | awk -v quote="none" '{print "sed -i \"s/Ç/\\\\\\c{C}/g\" "$0;}' > troca_acento_cedilha_M.bash
#./troca_acento_cedilha_M.bash

#õ
touch troca_acento_til_o.bash
chmod u+x troca_acento_til_o.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/õ/\\\\\\"quote"o/g\" "$0;}' > troca_acento_til_o.bash
#./troca_acento_til_o.bash

#Õ
touch troca_acento_til_o_M.bash
chmod u+x troca_acento_til_o_M.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/Õ/\\\\\\"quote"O/g\" "$0;}' > troca_acento_til_o_M.bash
#./troca_acento_til_o_M.bash

#ã
touch troca_acento_til_a.bash
chmod u+x troca_acento_til_a.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/ã/\\\\\\"quote"a/g\" "$0;}' > troca_acento_til_a.bash
#./troca_acento_til_a.bash

#Ã
touch troca_acento_til_a_M.bash
chmod u+x troca_acento_til_a_M.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/Ã/\\\\\\"quote"A/g\" "$0;}' > troca_acento_til_a_M.bash
#./troca_acento_til_a_M.bash

#í
touch troca_acento_agudo_i.bash
chmod u+x troca_acento_agudo_i.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/í/\\\\\\"quote"{\\\\\\i}/g\" "$0;}' > troca_acento_agudo_i.bash
#./troca_acento_agudo_i.bash

#Í
touch troca_acento_agudo_i_M.bash
chmod u+x troca_acento_agudo_i_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Í/\\\\\\"quote"I/g\" "$0;}' > troca_acento_agudo_i_M.bash
#./troca_acento_agudo_i_M.bash

#ó
touch troca_acento_agudo_o.bash
chmod u+x troca_acento_agudo_o.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/ó/\\\\\\"quote"o/g\" "$0;}' > troca_acento_agudo_o.bash
#./troca_acento_agudo_o.bash

#Ó
touch troca_acento_agudo_o_M.bash
chmod u+x troca_acento_agudo_o_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Ó/\\\\\\"quote"O/g\" "$0;}' > troca_acento_agudo_o_M.bash
#./troca_acento_agudo_o_M.bash

#ô
touch troca_acento_flex_o.bash
chmod u+x troca_acento_flex_o.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/ô/\\\\\\"quote"o/g\" "$0;}' > troca_acento_flex_o.bash
#./troca_acento_flex_o.bash

#Ô
touch troca_acento_flex_o_M.bash
chmod u+x troca_acento_flex_o_M.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/Ô/\\\\\\"quote"O/g\" "$0;}' > troca_acento_flex_o_M.bash
#./troca_acento_flex_o_M.bash

#ú
touch troca_acento_agudo_u.bash
chmod u+x troca_acento_agudo_u.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/ú/\\\\\\"quote"u/g\" "$0;}' > troca_acento_agudo_u.bash
#./troca_acento_agudo_u.bash

#Ú
touch troca_acento_agudo_u_M.bash
chmod u+x troca_acento_agudo_u_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Ú/\\\\\\"quote"U/g\" "$0;}' > troca_acento_agudo_u_M.bash
#./troca_acento_agudo_u_M.bash


































































