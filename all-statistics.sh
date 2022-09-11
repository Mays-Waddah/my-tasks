#!/bin/bash



echo "This is Disk usage "
df
echo " "

echo "This is free disk  "
free
echo " "

echo "This is memory used " 
 free | awk '{print $2} '
echo " "


echo "This is free memory"
 free | awk '{print $3} '
echo " "

echo "This is cpu
utilization"
vmstat
echo " "

echo"------- this is the end of part one----------"
echo " "


