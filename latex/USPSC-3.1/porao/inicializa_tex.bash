#ATEN\c{C}\~AO -> underscore \'e um car\'acter especial para o LaTeX e portanto n\~ao pode ser usado como identifiar. Mas o RaderTex utiliza underscore como nome de se\c{c}\~oes. Provavelmente nao terei problemas se tirar o underscore, mas da\'{\i} tem que tomar cuidado para n\~ao ter um dois identificadores diferentes tipo "titulo_abstract" e "tituloabstract", porque para o LaTeX ser\~a o mesmo identificador


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
sed -i "s/tituloadic[{]Modelo para TCC em \\\LaTeX\\\ utilizando o Pacote USPSC para o ICMC[}]/tituloadic{@[titulo]@}/g" USPSC-TCC-pre-textual-ICMC.tex                 


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

#"da USP" aparece apenas em TUTORIAL, ent\~ao n\~ao precisa mudar
# USP Sao Carlos aparece apenas em TUTORIAL e n\~ao precisa mudar

#Troca o nome da cidade
touch troca_cidade.bash
chmod u+x troca_cidade.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/local[{]S..ao Carlos[}]/local{@[localidade]@}/g\" "$0;}' > troca_cidade.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
./troca_cidade.bash

#Troca ano
touch troca_ano.bash
chmod u+x troca_ano.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/data[{]2021[}]/data{@[ano]@}/g\" "$0;}' > troca_ano.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
./troca_ano.bash

#Troca o nome da Universidade
touch troca_universidade.bash
chmod u+x troca_universidade.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Universidade de S\\\\\~ao Paulo/@[universidade]@/g\" "$0;}' > troca_universidade.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
./troca_universidade.bash

#Troca o nome da Universidade maiuscula
touch troca_universidade_m.bash
chmod u+x troca_universidade_m.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/UNIVERSIDADE DE S\\\\\~AO PAULO/@[universidademaiuscula]@/g\" "$0;}' > troca_universidade_m.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
./troca_universidade_m.bash

#Troca o nome da Universidade
touch troca_universidade2.bash
chmod u+x troca_universidade2.bash
find * | grep -i "\.tex" | awk -v aspas="\"" '{print "sed -i \"s/Universidade Estadual Paulista .J\\\\\\"quote"ulio de Mesquita Filho./@[universidade]@/g\" "$0;}' > troca_universidade2.bash
# voce pode executar o bash abaixo manualmente, chamando no prompt, ou tirando a marca de comentario
./troca_universidade2.bash
#nao ha casos de UNESP maiuscula segundo o verificador

#Troca o nome da unidadefaculdade
touch troca_unidadefaculdade_nome_da_unidade.bash
chmod u+x troca_unidadefaculdade_nome_da_unidade.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdade]@/@[unidadefaculdade]@/g\" "$0;}' > troca_unidadefaculdade_nome_da_unidade.bash
./troca_unidadefaculdade_nome_da_unidade.bash

#Troca o nome da unidadefaculdade - a troca abaixo tem que vir depois da "@[unidadefaculdade]@". De outra forma corrompe tudo
touch troca_unidadefaculdade_unidade_usp.bash
chmod u+x troca_unidadefaculdade_unidade_usp.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdade]@/@[unidadefaculdade]@/g\" "$0;}' > troca_unidadefaculdade_unidade_usp.bash
./troca_unidadefaculdade_unidade_usp.bash


#Troca o nome da unidadefaculdade
touch troca_unidade_faculdade_escola.bash
chmod u+x troca_unidade_faculdade_escola.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Escola de Engenharia de S\\\\\~ao Carlos/@[unidadefaculdade]@/g\" "$0;}' > troca_unidade_faculdade_escola.bash
./troca_unidade_faculdade_escola.bash

#Troca o nome da unidadefaculdademaiuscula
touch troca_unidade_faculdade_escola_maiuscula.bash
chmod u+x troca_unidade_faculdade_escola_maiuscula.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/ESCOLA DE ENGENHARIA DE S\\\\\~AO CARLOS/@[unidadefaculdademaiuscula]@/g\" "$0;}' > troca_unidade_faculdade_escola_maiuscula.bash
./troca_unidade_faculdade_escola_maiuscula.bash

#Troca o nome da unidadefaculdade mas respeita o chave no final
touch troca_unidadefaculdade_respeita_chave_no_final2.bash
chmod u+x troca_unidadefaculdade_respeita_chave_no_final2.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdade]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[unidadefaculdade]@}/g\" "$0;}' > troca_unidadefaculdade_respeita_chave_no_final2.bash
./troca_unidadefaculdade_respeita_chave_no_final2.bash

#Troca o nome da unidadefaculdade
touch troca_unidadefaculdade2.bash
chmod u+x troca_unidadefaculdade2.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdade]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[unidadefaculdade]@/g\" "$0;}' > troca_unidadefaculdade2.bash
./troca_unidadefaculdade2.bash

#Troca o nome da unidadefaculdademaiuscula respeita chave no final
touch troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash
chmod u+x troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdademaiuscula]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(MANUFATURA)]*[}]/@[unidadefaculdademaiuscula]@}/g\" "$0;}' > troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash
./troca_unidadefaculdade_respeita_chave_no_final_maiuscula2.bash


#Troca o nome da unidadefaculdademaiuscula
touch troca_unidadefaculdademaiuscula2.bash
chmod u+x troca_unidadefaculdademaiuscula2.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdademaiuscula]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(MANUFATURA)]*/@[unidadefaculdademaiuscula]@/g\" "$0;}' > troca_unidadefaculdademaiuscula2.bash
./troca_unidadefaculdademaiuscula2.bash

#Troca o nome da unidadefaculdade respeita chave no final
touch troca_unidadefaculdade_respeita_chave_no_final_3.bash
chmod u+x troca_unidadefaculdade_respeita_chave_no_final_3.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdade]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[unidadefaculdade]@}/g\" "$0;}' > troca_unidadefaculdade_respeita_chave_no_final_3.bash
./troca_unidadefaculdade_respeita_chave_no_final_3.bash


#Troca o nome da unidadefaculdade
touch troca_unidadefaculdade3.bash
chmod u+x troca_unidadefaculdade3.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdade]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[unidadefaculdade]@/g\" "$0;}' > troca_unidadefaculdade3.bash
./troca_unidadefaculdade3.bash

#Troca o nome da unidadefaculdade respeita chave no final
touch troca_unidadefaculdade_respeita_chave_no_final_4.bash
chmod u+x troca_unidadefaculdade_respeita_chave_no_final_4.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdademaiuscula]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*[}]/@[unidadefaculdademaiuscula]@}/g\" "$0;}' > troca_unidadefaculdade_respeita_chave_no_final_4.bash
./troca_unidadefaculdade_respeita_chave_no_final_4.bash


#Troca o nome da unidadefaculdade
touch troca_unidadefaculdade4.bash
chmod u+x troca_unidadefaculdade4.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[unidadefaculdademaiuscula]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*/@[unidadefaculdademaiuscula]@/g\" "$0;}' > troca_unidadefaculdade4.bash
./troca_unidadefaculdade4.bash

#Troca o nome da unidadefaculdade respeita chave no final
touch troca_programa_pos_respeita_chave_no_final.bash
chmod u+x troca_programa_pos_respeita_chave_no_final.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Programa de P\\\\\\"quote"os-Gradua\\\\\c[{]c[}]\\\\\~ao em [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[programapos]@}/g\" "$0;}' > troca_programa_pos_respeita_chave_no_final.bash
./troca_programa_pos_respeita_chave_no_final.bash

#Troca o nome da unidadefaculdade
touch troca_programa_pos.bash
chmod u+x troca_programa_pos.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/Programa de P\\\\\\"quote"os-Gradua\\\\\c[{]c[}]\\\\\~ao em [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[programapos]@/g\" "$0;}' > troca_programa_pos.bash
./troca_programa_pos.bash

#Troca o nome da unidadefaculdademaiuscula respeita chave no final
touch troca_programa_pos_respeita_chave_no_final_maiuscula.bash
chmod u+x troca_programa_pos_respeita_chave_no_final_maiuscula.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/PROGRAMA DE P\\\\\\"quote"OS-GRADUA\\\\\c[{]C[}]\\\\\~AO EM [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*[}]/@[programaposmaiuscula]@}/g\" "$0;}' > troca_programa_pos_respeita_chave_no_final_maiuscula.bash
./troca_programa_pos_respeita_chave_no_final_maiuscula.bash


#Troca o nome da unidadefaculdademaiuscula
touch troca_programa_pos_maiuscula.bash
chmod u+x troca_programa_pos_maiuscula.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/PROGRAMA DE P\\\\\\"quote"OS-GRADUA\\\\\c[{]C[}]\\\\\~AO EM [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*/@[programaposmaiuscula]@/g\" "$0;}' > troca_programa_pos_maiuscula.bash
./troca_programa_pos_maiuscula.bash

#Troca o nome da curso respeita chave no final
touch troca_curso_respeita_chave_no_final.bash
chmod u+x troca_curso_respeita_chave_no_final.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[curso]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/@[curso]@}/g\" "$0;}' > troca_curso_respeita_chave_no_final.bash
./troca_curso_respeita_chave_no_final.bash

#Troca o nome da curso
touch troca_curso.bash
chmod u+x troca_curso.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[curso]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/@[curso]@/g\" "$0;}' > troca_curso.bash
./troca_curso.bash

#Troca o nome da cursomaiuscula respeita chave no final
touch troca_curso_respeita_chave_no_final_maiuscula.bash
chmod u+x troca_curso_respeita_chave_no_final_maiuscula.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[cursomaiuscula]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*[}]/@[cursomaiuscula]@}/g\" "$0;}' > troca_curso_respeita_chave_no_final_maiuscula.bash
./troca_curso_respeita_chave_no_final_maiuscula.bash

#Troca o nome da cursomaiuscula
touch troca_cursomaiuscula.bash
chmod u+x troca_cursomaiuscula.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@[cursomaiuscula]@[A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( DE )( E )(Manufatura)]*/@[cursomaiuscula]@/g\" "$0;}' > troca_cursomaiuscula.bash
./troca_cursomaiuscula.bash

#Troca o mestreoudoutor - nao aparece TITULO em maiuscula, segundo o verificador.bash
touch troca_mestreoudoutor_pos.bash
chmod u+x troca_mestreoudoutor_pos.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de Mestre[ ,;]/t\\\\\\"quote"itulo de @[mestreoudoutor]@ /g\" "$0;}' > troca_mestreoudoutor_pos.bash
./troca_mestreoudoutor_pos.bash

#Troca o mestreoudoutor
touch troca_mestreoudoutor_pos.bash
chmod u+x troca_mestreoudoutor_pos.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de Doutor[ ,;]/t\\\\\\"quote"itulo de @[mestreoudoutor]@ /g\" "$0;}' > troca_mestreoudoutor_pos.bash
./troca_mestreoudoutor_pos.bash

#Troca o mestreoudoutor
touch troca_mestreoudoutor_pos.bash
chmod u+x troca_mestreoudoutor_pos.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de Mestre.Doutor/t\\\\\\"quote"itulo de @[mestreoudoutor]@/g\" "$0;}' > troca_mestreoudoutor_pos.bash
./troca_mestreoudoutor_pos.bash

#Troca o titulo respeita chave no final
touch troca_titulo_respeita_chave_no_final__pos.bash
chmod u+x troca_titulo_respeita_chave_no_final__pos.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*[}]/t\\\\\\"quote"itulo de @[titulopos]@}/g\" "$0;}' > troca_titulo_respeita_chave_no_final__pos.bash
./troca_titulo_respeita_chave_no_final__pos.bash

#Troca o titulo
touch troca_titulo_pos.bash
chmod u+x troca_titulo_pos.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/t\\\\\\"quote"itulo de [A-Za-z\\\\\\"quote"{}\\\\\~\\\\\^\\\\\\\"\\\\\`( de )( e )(Manufatura)]*/t\\\\\\"quote"itulo de @[titulopos]@/g\" "$0;}' > troca_titulo_pos.bash
./troca_titulo_pos.bash

#Coloca um "para" entre os tags de programa_pos e unidadefaculdade, que eh uma forma forcada de resolver o problema 
touch afasta_programa_unidade.bash
chmod u+x afasta_programa_unidade.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/@\[programapos\]@@\[unidadefaculdade\]@/@[programapos]@ vinculado a @[unidadefaculdade]@/g\" "$0;}' > afasta_programa_unidade.bash
./afasta_programa_unidade.bash


#\'a
touch troca_acento_agudo_a.bash
chmod u+x troca_acento_agudo_a.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'a/\\\\\\"quote"a/g\" "$0;}' > troca_acento_agudo_a.bash
./troca_acento_agudo_a.bash

#\'A
touch troca_acento_agudo_a_M.bash
chmod u+x troca_acento_agudo_a_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'A/\\\\\\"quote"A/g\" "$0;}' > troca_acento_agudo_a_M.bash
./troca_acento_agudo_a_M.bash

#\'e
touch troca_acento_agudo_e.bash
chmod u+x troca_acento_agudo_e.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'e/\\\\\\"quote"e/g\" "$0;}' > troca_acento_agudo_e.bash
./troca_acento_agudo_e.bash

#\'E
touch troca_acento_agudo_e_M.bash
chmod u+x troca_acento_agudo_e_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'E/\\\\\\"quote"E/g\" "$0;}' > troca_acento_agudo_e_M.bash
./troca_acento_agudo_e_M.bash

#\^a
touch troca_acento_flex_a.bash
chmod u+x troca_acento_flex_a.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/\^a/\\\\\\"quote"a/g\" "$0;}' > troca_acento_flex_a.bash
./troca_acento_flex_a.bash

#\^A
touch troca_acento_flex_a_M.bash
chmod u+x troca_acento_flex_a_M.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/\^A/\\\\\\"quote"A/g\" "$0;}' > troca_acento_flex_a_M.bash
./troca_acento_flex_a_M.bash

#\^e
touch troca_acento_flex_e.bash
chmod u+x troca_acento_flex_e.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/\^e/\\\\\\"quote"e/g\" "$0;}' > troca_acento_flex_e.bash
./troca_acento_flex_e.bash

#\^E
touch troca_acento_flex_e_M.bash
chmod u+x troca_acento_flex_e_M.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/\^E/\\\\\\"quote"E/g\" "$0;}' > troca_acento_flex_e_M.bash
./troca_acento_flex_e_M.bash

#\`a
touch troca_acento_crase.bash
chmod u+x troca_acento_crase.bash
find * | grep -i "\.tex" | awk -v quote="\`" '{print "sed -i \"s/\`a/\\\\\\\\\\"quote"a/g\" "$0;}' > troca_acento_crase.bash
./troca_acento_crase.bash

#\`A
touch troca_acento_crase_M.bash
chmod u+x troca_acento_crase_M.bash
find * | grep -i "\.tex" | awk -v quote="\`" '{print "sed -i \"s/\`A/\\\\\\\\\\"quote"A/g\" "$0;}' > troca_acento_crase_M.bash
./troca_acento_crase_M.bash

#"a
touch troca_acento_trema_a.bash
chmod u+x troca_acento_trema_a.bash
find * | grep -i "\.tex" | awk -v quote="\"" '{print "sed -i \"s/"a/\\\\\\"quote"a/g\" "$0;}' > troca_acento_trema_a.bash
./troca_acento_trema_a.bash

#"A
touch troca_acento_trema_a_M.bash
chmod u+x troca_acento_trema_a_M.bash
find * | grep -i "\.tex" | awk -v quote="\"" '{print "sed -i \"s/"A/\\\\\\"quote"A/g\" "$0;}' > troca_acento_trema_a_M.bash
./troca_acento_trema_a_M.bash

#\c{c}
touch troca_acento_cedilha.bash
chmod u+x troca_acento_cedilha.bash
find * | grep -i "\.tex" | awk -v quote="none" '{print "sed -i \"s/\c{c}/\\\\\\c{c}/g\" "$0;}' > troca_acento_cedilha.bash
./troca_acento_cedilha.bash

#\c{C}
touch troca_acento_cedilha_M.bash
chmod u+x troca_acento_cedilha_M.bash
find * | grep -i "\.tex" | awk -v quote="none" '{print "sed -i \"s/\c{C}/\\\\\\c{C}/g\" "$0;}' > troca_acento_cedilha_M.bash
./troca_acento_cedilha_M.bash

#\~o
touch troca_acento_til_o.bash
chmod u+x troca_acento_til_o.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/\~o/\\\\\\"quote"o/g\" "$0;}' > troca_acento_til_o.bash
./troca_acento_til_o.bash

#\~O
touch troca_acento_til_o_M.bash
chmod u+x troca_acento_til_o_M.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/\~O/\\\\\\"quote"O/g\" "$0;}' > troca_acento_til_o_M.bash
./troca_acento_til_o_M.bash

#\~a
touch troca_acento_til_a.bash
chmod u+x troca_acento_til_a.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/\~a/\\\\\\"quote"a/g\" "$0;}' > troca_acento_til_a.bash
./troca_acento_til_a.bash

#\~A
touch troca_acento_til_a_M.bash
chmod u+x troca_acento_til_a_M.bash
find * | grep -i "\.tex" | awk -v quote="~" '{print "sed -i \"s/\~A/\\\\\\"quote"A/g\" "$0;}' > troca_acento_til_a_M.bash
./troca_acento_til_a_M.bash

#\'{\i}
touch troca_acento_agudo_i.bash
chmod u+x troca_acento_agudo_i.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'{\i}/\\\\\\"quote"{\\\\\\i}/g\" "$0;}' > troca_acento_agudo_i.bash
./troca_acento_agudo_i.bash

#\'I
touch troca_acento_agudo_i_M.bash
chmod u+x troca_acento_agudo_i_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'I/\\\\\\"quote"I/g\" "$0;}' > troca_acento_agudo_i_M.bash
./troca_acento_agudo_i_M.bash

#\'o
touch troca_acento_agudo_o.bash
chmod u+x troca_acento_agudo_o.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'o/\\\\\\"quote"o/g\" "$0;}' > troca_acento_agudo_o.bash
./troca_acento_agudo_o.bash

#\'O
touch troca_acento_agudo_o_M.bash
chmod u+x troca_acento_agudo_o_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'O/\\\\\\"quote"O/g\" "$0;}' > troca_acento_agudo_o_M.bash
./troca_acento_agudo_o_M.bash

#\^o
touch troca_acento_flex_o.bash
chmod u+x troca_acento_flex_o.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/\^o/\\\\\\"quote"o/g\" "$0;}' > troca_acento_flex_o.bash
./troca_acento_flex_o.bash

#\^O
touch troca_acento_flex_o_M.bash
chmod u+x troca_acento_flex_o_M.bash
find * | grep -i "\.tex" | awk -v quote="^" '{print "sed -i \"s/\^O/\\\\\\"quote"O/g\" "$0;}' > troca_acento_flex_o_M.bash
./troca_acento_flex_o_M.bash

#\'u
touch troca_acento_agudo_u.bash
chmod u+x troca_acento_agudo_u.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'u/\\\\\\"quote"u/g\" "$0;}' > troca_acento_agudo_u.bash
./troca_acento_agudo_u.bash

#\'u
touch troca_acento_trema_u.bash
chmod u+x troca_acento_trema_u.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'u/\\\\\\"quote"u/g\" "$0;}' > troca_acento_trema_u.bash
./troca_acento_trema_u.bash

#\'U
touch troca_acento_agudo_u_M.bash
chmod u+x troca_acento_agudo_u_M.bash
find * | grep -i "\.tex" | awk -v quote="'" '{print "sed -i \"s/\'U/\\\\\\"quote"U/g\" "$0;}' > troca_acento_agudo_u_M.bash
./troca_acento_agudo_u_M.bash


































































