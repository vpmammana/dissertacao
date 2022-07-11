find ../../latex/* | grep -i "\.tex" | awk '{input = $0; gsub(/\.tex/,"_RedarTex.tex", $0); print "cp "input" "  $0;}' > copia_tex.bash
./copia_tex.bash

find ../../latex/* | grep -i "\_RedarTex.tex" | awk '{print "sed -i \"s/@\[titulo\]@/CARACTERIZAÇÃO DO PROGRAMA Workshop Aficionados por Software e Hardware (WASH)/g\" \"$0}' > substitui_tex.bash
./substitui_tex.bash

find ../../latex/* | grep -i "\_RedarTex.tex" | awk '{print "sed -i \"s/@\[autor\]@/Elaine da Silva Tozzi/g\" \"$0}' > substitui_tex.bash
./substitui_tex.bash

find ../../latex/* | grep -i "\_RedarTex.tex" | awk '{print "sed -i \"s/@\[orientador\]@/Paulo Sérgio Camargo/g\" \"$0}' > substitui_tex.bash
./substitui_tex.bash

