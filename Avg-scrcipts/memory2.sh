#!/bin/bash

count=0;
total=0; 

for i in $( awk '{ print $2; }' memory-avg.txt )
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
echo "Average of memory is : $total / $count" | bc "
