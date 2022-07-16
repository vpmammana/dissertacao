find * | grep -i \.aux | awk '{print "rm -f "$0}' > apagar.bash
find * | grep -i \.toc | awk '{print "rm -f "$0}' >> apagar.bash
find * | grep -i \.log | awk '{print "rm -f "$0}' >> apagar.bash

