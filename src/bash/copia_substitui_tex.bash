touch ../bash/copia_tex.bash
chmod u+x ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.pdf" | grep -v "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.pdf/,"_RedarTex.pdf", $0); print "\cp "input" "  $0" ";}' > ../bash/copia_tex.bash 
find ../../latex/* | grep -i "\.cls" | grep -v "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.cls/,"_RedarTex.cls", $0); print "\cp "input" "  $0" ";}' >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "RedarTex" | awk -v quote="'" '{input = $0; gsub(/\.tex/,"_RedarTex.tex", $0); print "\cp "input" "  $0" ";}' >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.cls" | grep -v "RedarTex" | awk -v quote="'" '{gsub(/\.cls/,"_RedarTex.cls", $0); gsub(/\_RedarTex.cls/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0); print "find ../../latex/. -type f -name "quote"*_RedarTex.cls"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.cls" | grep -v "RedarTex" | awk -v quote="'" '{gsub(/\.cls/,"_RedarTex.cls", $0); gsub(/\_RedarTex.cls/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "RedarTex" | awk -v quote="'" '{gsub(/\.tex/,"_RedarTex.tex", $0); gsub(/\_RedarTex.tex/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.tex"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
find ../../latex/* | grep -i "\.tex" | grep -v "RedarTex" | awk -v quote="'" '{gsub(/\.tex/,"_RedarTex.tex", $0); gsub(/\_RedarTex.tex/,"", $0); gsub (/\.\.\/\.\.\/latex\/USPSC-3.1\//,"",$0); gsub(/\//,"\/",$0);print "find ../../latex/. -type f -name "quote"*_RedarTex.cls"quote" | xargs sed -i "quote"s/include[{]"$0"[}]/include{"$0"_RedarTex}/g"quote" ";}' | sort | uniq >> ../bash/copia_tex.bash
../bash/copia_tex.bash

sed -i 's/USPSC-classe\/USPSC/USPSC-classe\/USPSC_RedarTex/g' ../../latex/USPSC-3.1/USPSC-modelo-IAU_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-IQSC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCp_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-Tutorial_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-EESC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IAU_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCp_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-Tutorial-num_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCe_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-EESC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-IQSC_RedarTex.tex
sed -i "/include.*USPSC.*Cap1/c\% @[pontoinsercaotextoprincipal]@" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCp_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-IQSC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCp_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-EESC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IAU_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCp_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial-num_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCe_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCe_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-EESC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IQSC_RedarTex.tex
sed -i "/include.*Cap[1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCp_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-IQSC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCp_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCe_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-EESC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IAU_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCp_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-Tutorial-num_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-TCC-modelo-ICMCe_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IFSCe_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-EESC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-IQSC_RedarTex.tex
sed -i "/Capítulo [1-5]/d" ../../latex/USPSC-3.1/./USPSC-modelo-ICMCp_RedarTex.tex
touch ../bash/substitui_tex_1.bash
chmod u+x ../bash/substitui_tex_1.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[titulo\]@/CARACTERIZA\\\\\\c{C}\\\\\~AO DO PROGRAMA Workshop Aficionados por Software e Hardware (WASH)/g\" "$0}' > ../bash/substitui_tex_1.bash
../bash/substitui_tex_1.bash

touch ../bash/substitui_tex_2.bash
chmod u+x ../bash/substitui_tex_2.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[subtitulo\]@/HIST\\\\\\"acute"ORIA, M\\\\\\"acute"ETODOS E RESULTADOS/g\" "$0}' > ../bash/substitui_tex_2.bash
../bash/substitui_tex_2.bash

touch ../bash/substitui_tex_3.bash
chmod u+x ../bash/substitui_tex_3.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autor\]@/Elaine da Silva Tozzi/g\" "$0}' > ../bash/substitui_tex_3.bash
../bash/substitui_tex_3.bash

touch ../bash/substitui_tex_4.bash
chmod u+x ../bash/substitui_tex_4.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autorabr\]@/Tozzi, E.S./g\" "$0}' > ../bash/substitui_tex_4.bash
../bash/substitui_tex_4.bash

touch ../bash/substitui_tex_5.bash
chmod u+x ../bash/substitui_tex_5.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[autorficha\]@/Tozzi, Elaine da Silva/g\" "$0}' > ../bash/substitui_tex_5.bash
../bash/substitui_tex_5.bash

touch ../bash/substitui_tex_6.bash
chmod u+x ../bash/substitui_tex_6.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[tituloabstract\]@/Characterization of the Hardware and Software for Geeks Program /g\" "$0}' > ../bash/substitui_tex_6.bash
../bash/substitui_tex_6.bash

touch ../bash/substitui_tex_7.bash
chmod u+x ../bash/substitui_tex_7.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[orientador\]@/Paulo S\\\\\\"acute"ergio Camargo/g\" "$0}' > ../bash/substitui_tex_7.bash
../bash/substitui_tex_7.bash

touch ../bash/substitui_tex_8.bash
chmod u+x ../bash/substitui_tex_8.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[orientadorficha\]@/Camargo, Paulo S\\\\\\"acute"ergio/g\" "$0}' > ../bash/substitui_tex_8.bash
../bash/substitui_tex_8.bash

touch ../bash/substitui_tex_9.bash
chmod u+x ../bash/substitui_tex_9.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[programapos\]@/Programa de P\\\\\\"acute"os-Gradua\\\\\\c{c}\\\\\~ao da UTFPR/g\" "$0}' > ../bash/substitui_tex_9.bash
../bash/substitui_tex_9.bash

touch ../bash/substitui_tex_10.bash
chmod u+x ../bash/substitui_tex_10.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[programaposmaiuscula\]@/PROGRAMA DE P\\\\\\"acute"OS-GRADUA\\\\\\c{C}\\\\\~AO DA UTFPR/g\" "$0}' > ../bash/substitui_tex_10.bash
../bash/substitui_tex_10.bash

touch ../bash/substitui_tex_11.bash
chmod u+x ../bash/substitui_tex_11.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[curso\]@/Curso de P\\\\\\"acute"os-Gradua\\\\\\c{c}\\\\\~ao em Licenciatura/g\" "$0}' > ../bash/substitui_tex_11.bash
../bash/substitui_tex_11.bash

touch ../bash/substitui_tex_12.bash
chmod u+x ../bash/substitui_tex_12.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[cursomaiuscula\]@/CURSO DE P\\\\\\"acute"OS-GRADUA\\\\\\c{C}\\\\\~AO EM LICENCIATURA/g\" "$0}' > ../bash/substitui_tex_12.bash
../bash/substitui_tex_12.bash

touch ../bash/substitui_tex_13.bash
chmod u+x ../bash/substitui_tex_13.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[mestreoudoutor\]@/Mestre/g\" "$0}' > ../bash/substitui_tex_13.bash
../bash/substitui_tex_13.bash

touch ../bash/substitui_tex_14.bash
chmod u+x ../bash/substitui_tex_14.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[titulopos\]@/Mestre em Licenciatura/g\" "$0}' > ../bash/substitui_tex_14.bash
../bash/substitui_tex_14.bash

touch ../bash/substitui_tex_15.bash
chmod u+x ../bash/substitui_tex_15.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[universidade\]@/Universidade Tecnol\\\\\\"acute"ogica Federal do Paran\\\\\\"acute"a/g\" "$0}' > ../bash/substitui_tex_15.bash
../bash/substitui_tex_15.bash

touch ../bash/substitui_tex_16.bash
chmod u+x ../bash/substitui_tex_16.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[universidademaiuscula\]@/UNIVERSIDADE TECNOL\\\\\\"acute"OGICA FEDERAL DO PARAN\\\\\\"acute"A/g\" "$0}' > ../bash/substitui_tex_16.bash
../bash/substitui_tex_16.bash

touch ../bash/substitui_tex_17.bash
chmod u+x ../bash/substitui_tex_17.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[unidadefaculdade\]@/Faculdade de Educa\\\\\\c{c}\\\\\~ao/g\" "$0}' > ../bash/substitui_tex_17.bash
../bash/substitui_tex_17.bash

touch ../bash/substitui_tex_18.bash
chmod u+x ../bash/substitui_tex_18.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[unidadefaculdademaiuscula\]@/FACULDADE DE EDUCA\\\\\\c{C}\\\\\~AO/g\" "$0}' > ../bash/substitui_tex_18.bash
../bash/substitui_tex_18.bash

touch ../bash/substitui_tex_19.bash
chmod u+x ../bash/substitui_tex_19.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[localidade\]@/Londrina/g\" "$0}' > ../bash/substitui_tex_19.bash
../bash/substitui_tex_19.bash

touch ../bash/substitui_tex_20.bash
chmod u+x ../bash/substitui_tex_20.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[palavraschave\]@/Papert, STEAM, STEM, WASH/g\" "$0}' > ../bash/substitui_tex_20.bash
../bash/substitui_tex_20.bash

touch ../bash/substitui_tex_21.bash
chmod u+x ../bash/substitui_tex_21.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[epigrafe\]@/Ci\\\\\^encia \\\\\\"acute"e a compreens\\\\\~ao que o outro constr\\\\\\"acute"oi sobre o conhecimento de algu\\\\\\"acute"em./g\" "$0}' > ../bash/substitui_tex_21.bash
../bash/substitui_tex_21.bash

touch ../bash/substitui_tex_22.bash
chmod u+x ../bash/substitui_tex_22.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[dedicatoria\]@/Coloque a dedicat\\\\\\"acute"oria aqui!/g\" "$0}' > ../bash/substitui_tex_22.bash
../bash/substitui_tex_22.bash

touch ../bash/substitui_tex_23.bash
chmod u+x ../bash/substitui_tex_23.bash
find ../../latex/* | grep -i "\_RedarTex.tex" | awk -v acute="'" -v tilde="~" '{print "sed -i \"s/@\[ano\]@/2022/g\" "$0}' > ../bash/substitui_tex_23.bash
../bash/substitui_tex_23.bash

