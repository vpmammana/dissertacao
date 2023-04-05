touch ../bash/copia_tex.bash
chmod u+x ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.pdf" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.pdf/,"_RedarTex.pdf", $0); print "\cp "input" "  $0" ";}' > ../bash/copia_tex.bash 
find ../../latex/* | grep -i "\.cls" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.cls/,"_RedarTex.cls", $0); print "\cp "input" "  $0" ";}' >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.tex/,"_RedarTex.tex", $0); print "\cp "input" "  $0" ";}' >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.cls" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{gsub(/\.cls/,"_RedarTex.cls", $0); gsub(/\_RedarTex.cls/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0); print "find ../../latex/. -type f -name "quote"*_RedarTex.cls"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.cls" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{gsub(/\.cls/,"_RedarTex.cls", $0); gsub(/\_RedarTex.cls/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{gsub(/\.tex/,"_RedarTex.tex", $0); gsub(/\_RedarTex.tex/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{gsub(/\.tex/,"_RedarTex.tex", $0); gsub(/\_RedarTex.tex/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"/include[{]USPSC-TA-PreTextual\/USPSC-Errata_RedarTex[}]/d"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{gsub(/\.tex/,"_RedarTex.tex", $0); gsub(/\_RedarTex.tex/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"/include[{]USPSC-TA-PosTextual\/USPSC-Apendices_RedarTex[}]/d"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "utfpr" | grep -v  "RedarTex" | awk -v quote="'" '{gsub(/\.tex/,"_RedarTex.tex", $0); gsub(/\_RedarTex.tex/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.cls"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
../bash/copia_tex.bash

sed -i 's/USPSC-classe\/USPSC/USPSC-classe\/USPSC_RedarTex/g' ../../latex/USPSC-3.1/USPSC-modelo-IAU_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-EESC_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-EESC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_10_10_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_10_10_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCe_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCe_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-Tutorial-num_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-Tutorial-num_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-EESC_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo-EESC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-Tutorial_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-Tutorial_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCp_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCp_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCe_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCp_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCp_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IAU_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo-IAU_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IQSC_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo-IQSC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCp_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCp_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCe_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_09_16_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_09_16_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-IQSC_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-IQSC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo_RedarTex.tex
sed -i "/^.chapter.Bibliografia..Bibliografia/d" ../../latex/USPSC-3.1/./USPSC-modelo_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-EESC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_10_10_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCe_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial-num_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-EESC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCp_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCp_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IAU_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IQSC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCp_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_09_16_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-IQSC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-EESC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_10_10_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCe_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial-num_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-EESC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCp_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCe_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCp_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IAU_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IQSC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCp_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCe_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./dissertacao_elaine_2022_09_16_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-IQSC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo_RedarTex.tex
touch ../bash/substitui_tex_1.bash
chmod u+x ../bash/substitui_tex_1.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[titulo\]@/HIST\\\\\\"acute"ORIA E CARACTERIZA\\\\\\c{C}\\\\\~AO DE 10 ANOS DO WASH, UM PROGRAMA HETER\\\\\\"acute"ARQUICO DE APRENDIZAGEM STEAM - TESTE/g\" "$0}' > ../bash/substitui_tex_1.bash
../bash/substitui_tex_1.bash

touch ../bash/substitui_tex_2.bash
chmod u+x ../bash/substitui_tex_2.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[subtitulo\]@/HIST\\\\\\"acute"ORIA, M\\\\\\"acute"ETODOS E RESULTADOS/g\" "$0}' > ../bash/substitui_tex_2.bash
../bash/substitui_tex_2.bash

touch ../bash/substitui_tex_3.bash
chmod u+x ../bash/substitui_tex_3.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autor\]@/ELAINE DA SILVA TOZZI/g\" "$0}' > ../bash/substitui_tex_3.bash
../bash/substitui_tex_3.bash

touch ../bash/substitui_tex_4.bash
chmod u+x ../bash/substitui_tex_4.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autorabr\]@/TOZZI, E.S./g\" "$0}' > ../bash/substitui_tex_4.bash
../bash/substitui_tex_4.bash

touch ../bash/substitui_tex_5.bash
chmod u+x ../bash/substitui_tex_5.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autorficha\]@/TOZZI, ELAINE DA SILVA/g\" "$0}' > ../bash/substitui_tex_5.bash
../bash/substitui_tex_5.bash

touch ../bash/substitui_tex_6.bash
chmod u+x ../bash/substitui_tex_6.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[tituloabstract\]@/HISTORY AND CHARACTERIZATION OF A DECADE OF WASH: A HETERARCHIAL STEAM EDUCATION PROGRAM/g\" "$0}' > ../bash/substitui_tex_6.bash
../bash/substitui_tex_6.bash

touch ../bash/substitui_tex_7.bash
chmod u+x ../bash/substitui_tex_7.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[orientador\]@/Prof. Dr. Paulo S\\\\\\"acute"ergio de Camargo Filho/g\" "$0}' > ../bash/substitui_tex_7.bash
../bash/substitui_tex_7.bash

touch ../bash/substitui_tex_8.bash
chmod u+x ../bash/substitui_tex_8.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[orientadorficha\]@/Camargo, Paulo S\\\\\\"acute"ergio/g\" "$0}' > ../bash/substitui_tex_8.bash
../bash/substitui_tex_8.bash

touch ../bash/substitui_tex_9.bash
chmod u+x ../bash/substitui_tex_9.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[coorientador\]@/Dr. Victor Pellegrini Mammana/g\" "$0}' > ../bash/substitui_tex_9.bash
../bash/substitui_tex_9.bash

touch ../bash/substitui_tex_10.bash
chmod u+x ../bash/substitui_tex_10.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[programapos\]@/PROGRAMA DE P\\\\\\"acute"OS-GRADUA\\\\\\c{C}\\\\\~AO EM ENSINO DE CI\\\\\^ENCIAS HUMANAS, SOCIAIS E DA NATUREZA - PPGEN/g\" "$0}' > ../bash/substitui_tex_10.bash
../bash/substitui_tex_10.bash

touch ../bash/substitui_tex_11.bash
chmod u+x ../bash/substitui_tex_11.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[programaposmaiuscula\]@/PROGRAMA DE P\\\\\\"acute"OS-GRADUA\\\\\\c{C}\\\\\~AO EM ENSINO DE CI\\\\\^ENCIAS HUMANAS, SOCIAIS E DA NATUREZA - PPGEN/g\" "$0}' > ../bash/substitui_tex_11.bash
../bash/substitui_tex_11.bash

touch ../bash/substitui_tex_12.bash
chmod u+x ../bash/substitui_tex_12.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[mestreoudoutor\]@/Mestre/g\" "$0}' > ../bash/substitui_tex_12.bash
../bash/substitui_tex_12.bash

touch ../bash/substitui_tex_13.bash
chmod u+x ../bash/substitui_tex_13.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[titulopos\]@/Mestre em Ensino de Ci\\\\\^encias Humanas, Sociais e da Natureza/g\" "$0}' > ../bash/substitui_tex_13.bash
../bash/substitui_tex_13.bash

touch ../bash/substitui_tex_14.bash
chmod u+x ../bash/substitui_tex_14.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[universidade\]@/UNIVERSIDADE TECNOL\\\\\\"acute"OGICA FEDERAL DO PARAN\\\\\\"acute"A/g\" "$0}' > ../bash/substitui_tex_14.bash
../bash/substitui_tex_14.bash

touch ../bash/substitui_tex_15.bash
chmod u+x ../bash/substitui_tex_15.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[universidademaiuscula\]@/UNIVERSIDADE TECNOL\\\\\\"acute"OGICA FEDERAL DO PARAN\\\\\\"acute"A/g\" "$0}' > ../bash/substitui_tex_15.bash
../bash/substitui_tex_15.bash

touch ../bash/substitui_tex_16.bash
chmod u+x ../bash/substitui_tex_16.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[unidadefaculdade\]@/Programa de P\\\\\\"acute"os-Gradua\\\\\\c{c}\\\\\~ao em Ensino de Ci\\\\\^encias Humanas, Sociais e da Natureza - PPGE/g\" "$0}' > ../bash/substitui_tex_16.bash
../bash/substitui_tex_16.bash

touch ../bash/substitui_tex_17.bash
chmod u+x ../bash/substitui_tex_17.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[unidadefaculdademaiuscula\]@/PROGRAMA DE P\\\\\\"acute"OS-GRADUA\\\\\\c{C}\\\\\~AO EM ENSINO DE CI\\\\\^ENCIAS HUMANAS, SOCIAIS E DA NATUREZA - PPGEN/g\" "$0}' > ../bash/substitui_tex_17.bash
../bash/substitui_tex_17.bash

touch ../bash/substitui_tex_18.bash
chmod u+x ../bash/substitui_tex_18.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[localidade\]@/LONDRINA 2023/g\" "$0}' > ../bash/substitui_tex_18.bash
../bash/substitui_tex_18.bash

touch ../bash/substitui_tex_19.bash
chmod u+x ../bash/substitui_tex_19.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[palavraschave\]@/Papert, STEAM, STEM, WASH/g\" "$0}' > ../bash/substitui_tex_19.bash
../bash/substitui_tex_19.bash

touch ../bash/substitui_tex_20.bash
chmod u+x ../bash/substitui_tex_20.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[epigrafe\]@/"Brasil Mostra Tua Cara". Brasil Meu Brasil ande pra frente. Venha com a gente pra Avenida desfilar . \\\\\\"acute"E chegada a hora da verdade. N\\\\\~ao \\\\\\"acute"e preciso mais voc\\\\\^e se disfar\\\\\\c{c}ar. Levante os panos, mostra tua cara. E assuma essa cara que voc\\\\\^e tem. Brasil Terra dos Ianom\\\\\^amis. Essas matas s\\\\\~ao de Oxossi. Deixa na terra as riquezas de Oxum. Devolva pro povo o que \\\\\\"acute"e do povo. Bote os malditos pra fora. E vamos refazer essa na\\\\\\c{c}\\\\\~ao. Pois,o pa\\\\\\"acute"{\i}s que  \\\\\\"acute"e o olho d’\\\\\\"acute"agua do mundo n\\\\\~ao pode ver sofrer. N\\\\\~ao pode ver chorar um povo que trabalha, canta e \\\\\\"acute"e feliz. Chega de tanta injusti\\\\\\c{c}a, chega de corrup\\\\\\c{c}\\\\\~ao. Vamos arrumar a casa, vamos dividir o nosso ch\\\\\~ao. E chega de sofrer e chega de chorar. Oh p\\\\\\"acute"atria amada idolatrada. Salve-se Brasil! Antonio Carlos (TC) Santos Silva Alu\\\\\\"acute"{\i}zio Jeremias (Samba Enredo, 1988)/g\" "$0}' > ../bash/substitui_tex_20.bash
../bash/substitui_tex_20.bash

touch ../bash/substitui_tex_21.bash
chmod u+x ../bash/substitui_tex_21.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[dedicatoria\]@/Dedico esta disserta\\\\\\c{c}\\\\\~ao aos meus genitores: Maria Imaculada de Oliveira Silva e Joaquim Roberto da Silva./g\" "$0}' > ../bash/substitui_tex_21.bash
../bash/substitui_tex_21.bash

touch ../bash/substitui_tex_22.bash
chmod u+x ../bash/substitui_tex_22.bash
find ../../latex/* | grep -v "utfpr" | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[ano\]@/2023/g\" "$0}' > ../bash/substitui_tex_22.bash
../bash/substitui_tex_22.bash

