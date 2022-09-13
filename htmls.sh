#!/bin/bash

echo "CPU Usage : "  >> cpu.html 
echo " "    >> cpu.html 
top | grep %Cpu  >> cpu.html 
echo " " >> cpu.html > /dev/null
vmstat | awk '{print $6} '  >>cpu-avg.txt


#used memory
echo "Memory Usage : "  >> memory.html
echo " "  >> memory.html 
free |grep Mem | awk '{print $2,$3,$6} ' >> memory.html 
free | grep Mem
awk '{ print $1; }' >>memory-avg.txt

echo "Disk Usage: "  >> disk.html 
echo " " >> disk.html  
 df >> disk.html 
 df | awk '{print $4} ' >> disk-avg.txt
 #the available space avg
 




 

