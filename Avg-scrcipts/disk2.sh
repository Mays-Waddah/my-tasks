#!/bin/bash

count=0;
total=0; 

for i in $( awk '{ print $2; }' disk-avg.txt )
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
echo "Average of disk is : $total / $count" | bc "
