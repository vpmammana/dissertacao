cd ../../latex/USPSC-3.1
pwd
cp USPSC-modelo-IAU_RedarTex.tex dissertacao_elaine_2022_10_10.tex
sed -i "s/[{]\\\\textheight[}]//g" dissertacao_elaine_2022_10_10.tex
/usr/bin/pandoc -s dissertacao_elaine_2022_10_10.tex -o dissertacao_elaine_2022_10_10.docx 2>&1
