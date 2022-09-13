#!/bin/bash

echo -e "  
<html>\n
<style>\n

<body>\n



<table style="width:100%">\n
  <tr>\n
    <th>\n CPU </th>\n
    <th>\n MEMORY </th>\n
    <th>\n DISK-USG </th>\n
</th>\n

  </tr>\n
  <tr>\n
    <td>\n <a href="/cpu.html">cpu</a>        </td>\n
    <td>\n <a href="/memory.html">memory</a>  </td>\n
    <td>\n <a href="/disk.html">disk</a>      </td>\n
  </tr>\n
  
 
</table>\n


</body>\n
</html> \n " >> index.html
