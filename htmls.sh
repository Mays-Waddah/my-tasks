#!/bin/bash
#command >>redirected to html1 >>/dev/null
#files :all-statistics.sh  collected-data.txt  cpu.html  disk.html   index.html  memory.html 



echo "CPU Usage : "  >> cpu.html 
echo " "    >> cpu.html 
vmstat | awk '{print $6} '  >> cpu.html 
echo " " >> cpu.html > /dev/null


echo "Memory Usage : "  >> memory.html
echo " "  >> memory.html 
free | awk '{print $2} ' >> memory.html 

echo "Disk Usage: "  >> disk.html 
echo " " >> disk.html  
 df >> disk.html 



 

