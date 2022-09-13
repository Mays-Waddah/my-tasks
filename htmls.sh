#!/bin/bash
#command >>redirected to html1 >>/dev/null
#files :all-statistics.sh  collected-data.txt  cpu.html  disk.html   index.html  memory.html 



echo "CPU Usage : "  >> cpu.html 
echo " "    >> cpu.html 
top | grep %Cpu  >> cpu.html 
echo " " >> cpu.html > /dev/null
vmstat | awk '{print $6} '  >>cpu-avg.sh


#used memory
echo "Memory Usage : "  >> memory.html
echo " "  >> memory.html 
free |grep Mem | awk '{print $2,$3,$6} ' >> memory.html 
free | grep Mem
awk '{ print $1; }' >>memory-avg.sh

echo "Disk Usage: "  >> disk.html 
echo " " >> disk.html  
 df >> disk.html 
 df | awk '{print $4} ' >> disk-avg.sh  
 #the available space avg
 




 

