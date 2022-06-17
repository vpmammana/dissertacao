cat tese.sql | grep -i "insert into instancias_propriedades"  | awk 'BEGIN{FS="\""}{linha=$0; propriedade=$4; gsub(/@/,"\""propriedade"\"",linha); print linha;}' > temp_insert_instancias.sql
