while true 
do
	ps -auxw | grep -v grep | grep -v vim | grep -i "gera_tex2"
done
