#!/bin/bash
#!/bin/bash
{
echo `<html>`;
echo `<body>`;

echo `<table style="width:100%">`;
 echo `<tr>`; 
  
    echo `<th>`; CPU echo `</th>`;
    echo`<th>`; MEMORY echo`</th>`;
    echo `<th>`; DISK-USG echo `</th> `;
    echo `</th>`;

  echo `</tr>`;
  echo `<tr>`;
   echo `<td>`; <a href="/cpu.html">cpu</a>        echo `</td>`;
  
  echo `<td>`;    
    count=0;
    total=0; 
for i in $( awk '{ print $0; }' cpu-avg.sh )
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
echo "average for cpu is : $total / $count" | bc "
    echo `</td>`;
    
     echo `<td>`; <a href="/memory.html">memory</a>   echo `</td>`;
     echo `<td>`;
   count=0;
   total=0; 
for i in $( awk '{ print $0; }' memory-avg.sh )
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
echo "avg of memory : $total / $count" | b "
     echo `</td>`;
     
     
     echo `<td>`;  <a href="/disk.html">disk</a>       echo `</td>`;
      echo `<td>`;  
  count=0;
  total=0; 

for i in $( awk '{ print $0; }' disk-avg.sh )
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
echo "$total / $count" | bc
      echo `</td>`;
     
     
 echo  `</tr>`;
  
 
 echo `</table>`;
 


 echo `</body>`;
 echo `</html>`;
}
