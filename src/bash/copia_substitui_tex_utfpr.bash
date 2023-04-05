touch ../bash/copia_tex_utfpr.bash
chmod u+x ../bash/copia_tex_utfpr.bash
find ../../latex/* | grep -i "\.pdf" | grep -v "USPSC" | grep -v "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.pdf/,"_RedarTex.pdf", $0); print "\cp "input" "  $0" ";}' > ../bash/copia_tex_utfpr.bash 
find ../../latex/* | grep -i "\.cls" | grep -v "USPSC" | grep -v "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.cls/,"_RedarTex.cls", $0); print "\cp "input" "  $0" ";}' >> ../bash/copia_tex_utfpr.bash
find ../../latex/* | grep -i "\.tex" | grep -v "USPSC" | grep -v "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.tex/,"_RedarTex.tex", $0); print "\cp "input" "  $0" ";}' >> ../bash/copia_tex_utfpr.bash
find ../../latex/* | grep -i "\.cls" | grep -v "USPSC" | grep -v "RedarTex" | awk -v quote="'" '{gsub(/\.cls/,"_RedarTex.cls", $0); gsub(/\_RedarTex.cls/,"", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,"",$0); gsub(/\//,"\/",$0); print "find ../../latex/. -type f -name "quote"*_RedarTex.cls"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
find ../../latex/* | grep -i "\.cls" | grep -v "USPSC" | grep -v "RedarTex" | awk -v quote="'" '{gsub(/\.cls/,"_RedarTex.cls", $0); gsub(/\_RedarTex.cls/,"", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
find ../../latex/* | grep -i "\.tex" | grep -v "USPSC" | grep -v "RedarTex" | awk -v quote="'" '{gsub(/\.tex/,"_RedarTex.tex", $0); gsub(/\_RedarTex.tex/,"", $0); gsub (/\.\.\/\.\.\/latex\/utfpr\/utfprct-tex\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex_utfpr.bash
../bash/copia_tex_utfpr.bash

touch ../bash/substitui_tex_utfpr_1.bash
chmod u+x ../bash/substitui_tex_utfpr_1.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[titulo\]@/HISTÓRIA E CARACTERIZAÇÃO DE 10 ANOS DO WASH, UM PROGRAMA HETERÁRQUICO DE APRENDIZAGEM STEAM/g\" "$0}' > ../bash/substitui_tex_utfpr_1.bash
../bash/substitui_tex_utfpr_1.bash

touch ../bash/substitui_tex_utfpr_2.bash
chmod u+x ../bash/substitui_tex_utfpr_2.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[subtitulo\]@/HISTÓRIA, MÉTODOS E RESULTADOS/g\" "$0}' > ../bash/substitui_tex_utfpr_2.bash
../bash/substitui_tex_utfpr_2.bash

touch ../bash/substitui_tex_utfpr_3.bash
chmod u+x ../bash/substitui_tex_utfpr_3.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autor\]@/ELAINE DA SILVA TOZZI/g\" "$0}' > ../bash/substitui_tex_utfpr_3.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[ultimonome\]@/TOZZI/g\" "$0}' >> ../bash/substitui_tex_utfpr_3.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[primeirosnomes\]@/ELAINE DA SILVA/g\" "$0}' >> ../bash/substitui_tex_utfpr_3.bash
../bash/substitui_tex_utfpr_3.bash

touch ../bash/substitui_tex_utfpr_4.bash
chmod u+x ../bash/substitui_tex_utfpr_4.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autorabr\]@/TOZZI, E.S./g\" "$0}' > ../bash/substitui_tex_utfpr_4.bash
../bash/substitui_tex_utfpr_4.bash

touch ../bash/substitui_tex_utfpr_5.bash
chmod u+x ../bash/substitui_tex_utfpr_5.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autorficha\]@/TOZZI, ELAINE DA SILVA/g\" "$0}' > ../bash/substitui_tex_utfpr_5.bash
../bash/substitui_tex_utfpr_5.bash

touch ../bash/substitui_tex_utfpr_6.bash
chmod u+x ../bash/substitui_tex_utfpr_6.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[tituloabstract\]@/HISTORY AND CHARACTERIZATION OF A DECADE OF WASH: A HETERARCHIAL STEAM EDUCATION PROGRAM/g\" "$0}' > ../bash/substitui_tex_utfpr_6.bash
../bash/substitui_tex_utfpr_6.bash

touch ../bash/substitui_tex_utfpr_7.bash
chmod u+x ../bash/substitui_tex_utfpr_7.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[orientador\]@/Prof. Dr. Paulo Sérgio de Camargo Filho/g\" "$0}' > ../bash/substitui_tex_utfpr_7.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[ultimonomeorientador\]@/Filho/g\" "$0}' >> ../bash/substitui_tex_utfpr_7.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[primeirosnomesorientador\]@/Prof. Dr. Paulo Sérgio de Camargo/g\" "$0}' >> ../bash/substitui_tex_utfpr_7.bash
../bash/substitui_tex_utfpr_7.bash

touch ../bash/substitui_tex_utfpr_8.bash
chmod u+x ../bash/substitui_tex_utfpr_8.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[orientadorficha\]@/Camargo, Paulo Sérgio/g\" "$0}' > ../bash/substitui_tex_utfpr_8.bash
../bash/substitui_tex_utfpr_8.bash

touch ../bash/substitui_tex_utfpr_9.bash
chmod u+x ../bash/substitui_tex_utfpr_9.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[coorientador\]@/Dr. Victor Pellegrini Mammana/g\" "$0}' > ../bash/substitui_tex_utfpr_9.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[ultimonomecoorientador\]@/Mammana/g\" "$0}' >> ../bash/substitui_tex_utfpr_9.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[primeirosnomescoorientador\]@/Dr. Victor Pellegrini/g\" "$0}' >> ../bash/substitui_tex_utfpr_9.bash
../bash/substitui_tex_utfpr_9.bash

touch ../bash/substitui_tex_utfpr_10.bash
chmod u+x ../bash/substitui_tex_utfpr_10.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[programapos\]@/Programa de Pós-Graduação em Ensino de Ciências Humanas, Sociais e da Natureza - PPGEN/g\" "$0}' > ../bash/substitui_tex_utfpr_10.bash
../bash/substitui_tex_utfpr_10.bash

touch ../bash/substitui_tex_utfpr_11.bash
chmod u+x ../bash/substitui_tex_utfpr_11.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[programaposmaiuscula\]@/PROGRAMA DE PÓS-GRADUAÇÃO EM ENSINO DE CIÊNCIAS HUMANAS, SOCIAIS E DA NATUREZA - PPGEN/g\" "$0}' > ../bash/substitui_tex_utfpr_11.bash
../bash/substitui_tex_utfpr_11.bash

touch ../bash/substitui_tex_utfpr_12.bash
chmod u+x ../bash/substitui_tex_utfpr_12.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[mestreoudoutor\]@/Mestre/g\" "$0}' > ../bash/substitui_tex_utfpr_12.bash
../bash/substitui_tex_utfpr_12.bash

touch ../bash/substitui_tex_utfpr_13.bash
chmod u+x ../bash/substitui_tex_utfpr_13.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[titulopos\]@/Ensino de Ciências Humanas, Sociais e da Natureza/g\" "$0}' > ../bash/substitui_tex_utfpr_13.bash
../bash/substitui_tex_utfpr_13.bash

touch ../bash/substitui_tex_utfpr_14.bash
chmod u+x ../bash/substitui_tex_utfpr_14.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[universidade\]@/Universidade Tecnológica Federal do Paraná/g\" "$0}' > ../bash/substitui_tex_utfpr_14.bash
../bash/substitui_tex_utfpr_14.bash

touch ../bash/substitui_tex_utfpr_15.bash
chmod u+x ../bash/substitui_tex_utfpr_15.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[universidademaiuscula\]@/UTFPR/g\" "$0}' > ../bash/substitui_tex_utfpr_15.bash
../bash/substitui_tex_utfpr_15.bash

touch ../bash/substitui_tex_utfpr_16.bash
chmod u+x ../bash/substitui_tex_utfpr_16.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[unidadefaculdade\]@/Programa de Pós-Graduação em Ensino de Ciências Humanas, Sociais e da Natureza - PPGE/g\" "$0}' > ../bash/substitui_tex_utfpr_16.bash
../bash/substitui_tex_utfpr_16.bash

touch ../bash/substitui_tex_utfpr_17.bash
chmod u+x ../bash/substitui_tex_utfpr_17.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[unidadefaculdademaiuscula\]@/PROGRAMA DE PÓS-GRADUAÇÃO EM ENSINO DE CIÊNCIAS HUMANAS, SOCIAIS E DA NATUREZA - PPGEN/g\" "$0}' > ../bash/substitui_tex_utfpr_17.bash
../bash/substitui_tex_utfpr_17.bash

touch ../bash/substitui_tex_utfpr_18.bash
chmod u+x ../bash/substitui_tex_utfpr_18.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[localidade\]@/LONDRINA/g\" "$0}' > ../bash/substitui_tex_utfpr_18.bash
../bash/substitui_tex_utfpr_18.bash

touch ../bash/substitui_tex_utfpr_19.bash
chmod u+x ../bash/substitui_tex_utfpr_19.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[palavraschave\]@/Papert, STEAM, STEM, WASH/g\" "$0}' > ../bash/substitui_tex_utfpr_19.bash
../bash/substitui_tex_utfpr_19.bash

touch ../bash/substitui_tex_utfpr_20.bash
chmod u+x ../bash/substitui_tex_utfpr_20.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[epigrafe\]@/Brasil Mostra Tua Cara - Brasil... Meu Brasil ande pra frente. Venha com a gente pra Avenida desfilar . É chegada a hora da verdade. Não é preciso mais você se disfarçar. Levante os panos, mostra tua cara. E assuma essa cara que você tem. Brasil Terra dos Ianomâmis. Essas matas são de Oxossi. Deixa na terra as riquezas de Oxum. Devolva pro povo o que é do povo. Bote os malditos pra fora. E vamos refazer essa nação. Pois, o país que  é o olho d’água do mundo não pode ver sofrer. Não pode ver chorar um povo que trabalha, canta e é feliz. Chega de tanta injustiça, chega de corrupção. Vamos arrumar a casa, vamos dividir o nosso chão. E chega de sofrer e chega de chorar. Oh pátria amada idolatrada. Salve-se Brasil! Antonio Carlos (TC) Santos Silva e Aluízio Jeremias (Samba Enredo, 1988)/g\" "$0}' > ../bash/substitui_tex_utfpr_20.bash
../bash/substitui_tex_utfpr_20.bash

touch ../bash/substitui_tex_utfpr_21.bash
chmod u+x ../bash/substitui_tex_utfpr_21.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[dedicatoria\]@/Dedico esta dissertação aos meus genitores: Maria Imaculada de Oliveira Silva e Joaquim Roberto da Silva./g\" "$0}' > ../bash/substitui_tex_utfpr_21.bash
../bash/substitui_tex_utfpr_21.bash

touch ../bash/substitui_tex_utfpr_22.bash
chmod u+x ../bash/substitui_tex_utfpr_22.bash
find ../../latex/* | grep -v "USPSC" | grep -i "\_RedarTex.tex\|_RedarTex.cls" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[ano\]@/2023/g\" "$0}' > ../bash/substitui_tex_utfpr_22.bash
../bash/substitui_tex_utfpr_22.bash

echo "Talvez tenha dado certo..."
pwd
