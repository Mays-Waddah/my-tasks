#!/bin/bash
cat << -EOF
echo -e "  
<html>
<style>

<body>



<table style="width:100%">
  <tr>
    <th> CPU </th>
    <th> MEMORY </th>
    <th> DISK-USG </th>
</th>
  </tr>
  <tr>
    <td> <a href="/cpu.html">cpu</a>        </td>
    <td> <a href="/memory.html">memory</a>  </td>
    <td> <a href="/disk.html">disk</a>      </td>
  </tr>
  
 
</table>


</body>
</html> EOF >> index.html
