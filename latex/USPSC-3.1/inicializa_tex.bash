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


sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[titulo]@}/g" USPSC-modelo-ICMCe.tex 
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
sed -i "s/renewcommand[{]\\\titleabstract[}][{]Modelo para teses e disserta\\\c[{]c[}]\\\~oes em LaTeX utilizando a classe USPSC para o ICMC[}]/renewcommand{\\\titleabstract}{@[titulo]@}/g" USPSC-TCC-modelo-ICMCe.tex 



USPSC-pre-textual-EESC.tex          \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-EESC.tex          \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-EESC.tex          \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-EESC.tex          %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-EESC.tex          %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-IAU.tex           \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-IAU.tex           \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-IAU.tex           \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-IAU.tex           %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-IAU.tex           %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-ICMC.tex          \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-ICMC.tex          \orientadoradic{Advisor     Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-ICMC.tex          \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-ICMC.tex          \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-ICMC.tex          %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-ICMC.tex          %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-ICMC.tex          %\orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-ICMC.tex          %\orientadoradic{Orientadora     Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-ICMC.tex          %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-ICMC.tex          %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-ICMC.tex          %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-ICMC.tex          %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-ICMC.tex          %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-ICMC.tex          %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-IFSC.tex          \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-IFSC.tex          \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-IFSC.tex          \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-IFSC.tex          %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-IFSC.tex          %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-IQSC.tex          \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-IQSC.tex          \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-IQSC.tex          \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-IQSC.tex          %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-IQSC.tex          %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-OUTRO.tex         \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-OUTRO.tex         \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-OUTRO.tex         \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-OUTRO.tex         %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-OUTRO.tex         %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-pre-textual-Tutorial.tex      %\orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-pre-textual-Tutorial.tex      \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-pre-textual-Tutorial.tex      %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-pre-textual-Tutorial.tex      %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-TCC-pre-textual-EESC.tex      \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-EESC.tex      %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-EESC.tex      %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-TCC-pre-textual-EESC.tex      \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-TCC-pre-textual-EESC.tex      \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-TCC-pre-textual-ICMC.tex      \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-ICMC.tex      \orientadoradic{Advisor     Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-ICMC.tex      \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-ICMC.tex      \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-TCC-pre-textual-ICMC.tex      %\orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadoradic{Orientadora     Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-TCC-pre-textual-ICMC.tex      %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-TCC-pre-textual-IQSC.tex      \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-IQSC.tex      \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-IQSC.tex      \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-TCC-pre-textual-IQSC.tex      %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-TCC-pre-textual-IQSC.tex      %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}
USPSC-TCC-pre-textual-OUTROS.tex    \orientador{Profa. Dra. Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-OUTROS.tex    %\orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues}
USPSC-TCC-pre-textual-OUTROS.tex    %\orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient}
USPSC-TCC-pre-textual-OUTROS.tex    \orientadorcorpoficha{orientadora Elisa Gon\c{c}alves Rodrigues ;  co-orientador Jo\~ao Alves Serqueira}
USPSC-TCC-pre-textual-OUTROS.tex    \orientadorficha{Rodrigues, Elisa Gon\c{c}alves, orient. II. Serqueira, Jo\~ao Alves, co-orient}















