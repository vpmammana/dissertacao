while true 
do
	ps -aux | grep -v grep | grep -i pdflatex
done
