#!/bin/bash
# iam appending the average of values collected in the -avg file then appending the average to the same page where we had values shown
count=0;
total=0; 

for i in $( awk '{ print $2; }' cpu-avg.txt )
   do 
     total=$(echo $total+$i )
     ((count++))
   done
echo "Average of cpu is : $total / $count" | bc " >> cpu.html
