echo -n "XXX -> "
grep -HRr "XXX" . |  grep -i .tex| wc -l
echo -n "UNESP -> "
grep -HRr "UNESP" . |  grep -i .tex| wc -l
echo -n "' USP ' -> "
grep -HRr "[( ]USP[) ,;]" . |  grep -i .tex| wc -l
echo -n "Universidade -> "
grep -HRr "Universidade" . |  grep -i .tex| wc -l
echo -n "UNIVERSIDADE -> "
grep -HRr "UNIVERSIDADE" . |  grep -i .tex| wc -l
echo -n "Universidade Estadual -> "
grep -HRr "Universidade Estadual" . |  grep -i .tex| wc -l
echo -n "UNIVERSIDADE ESTADUAL -> "
grep -HRr "UNIVERSIDADE ESTADUAL" . |  grep -i .tex| wc -l
echo -n "Faculdade -> "
grep -HRr "Faculdade" . |  grep -i .tex| wc -l
echo -n "FACULDADE -> "
grep -HRr "FACULDADE" . |  grep -i .tex| wc -l
echo -n "Instituto -> "
grep -HRr "Instituto" . |  grep -i .tex| wc -l
echo -n "INSTITUTO -> "
grep -HRr "INSTITUTO" . |  grep -i .tex| wc -l
echo -n "Escola -> "
grep -HRr "Escola" . |  grep -i .tex| wc -l
echo -n "ESCOLA -> "
grep -HRr "ESCOLA" . |  grep -i .tex| wc -l
echo -n "Programa -> "
grep -HRr "Programa" . |  grep -i .tex| wc -l
echo -n "PROGRAMA -> "
grep -HRr "PROGRAMA" . |  grep -i .tex| wc -l
echo -n "Curso -> "
grep -HRr "Curso" . |  grep -i .tex| wc -l
echo -n "CURSO -> "
grep -HRr "CURSO" . |  grep -i .tex| wc -l
echo -n "P...s-Gradua -> "
grep -HRr "P...s-Gradua" . |  grep -i .tex| wc -l
echo -n "Gradua -> "
grep -HRr "Gradua" . |  grep -i .tex| wc -l
echo -n "P...S-GRADUA -> "
grep -HRr "P...S-GRADUA" . |  grep -i .tex| wc -l
echo -n "GRADUA -> "
grep -HRr "GRADUA" . |  grep -i .tex| wc -l
echo -n "Nome da Unidade USP -> "
grep -HRr "Nome da Unidade USP" . |  grep -i .tex| wc -l
echo -n "Unidade USP -> "
grep -HRr "Unidade USP" . |  grep -i .tex| wc -l
echo -n "[Tt]...tulo  -> "
grep -HRir "t...tulo " . |  grep -i .tex| wc -l
echo -n "Modelo para teses e disserta -> "
grep -HRir "Modelo para teses e disserta" . |  grep -i .tex| wc -l
echo -n "Modelo para TCC em -> "
grep -HRir "Modelo para TCC em" . |  grep -i .tex| wc -l
echo -n "Modelo para TC em -> "
grep -HRir "Modelo para TC em" . |  grep -i .tex| wc -l
echo -n "Model for thesis -> "
grep -HRir "Model for thesis" . |  grep -i .tex| wc -l
echo -n "Modelo para elabora -> "
grep -HRir "Modelo para elabora" . |  grep -i .tex| wc -l
echo -n "Elisa -> "
grep -HRir "Elisa" . |  grep -i .tex| wc -l
echo -n "Silva -> "
grep -HRir "Silva" . |  grep -i .tex| wc -l

