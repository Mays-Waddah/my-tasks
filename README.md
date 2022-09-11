# my-tasks documentation
this is my documentation for task 2 in shell scripting , instrusctions about the solution
make sure to have apache server set (httpd service , check ports ).
helpful site to install apache, zones, firewall ..( https://phoenixnap.com/kb/how-to-install-apache-centos-8 )
helpful site for ports ( https://linuxconfig.org/redhat-8-open-and-close-ports )
you can see the scripts in the repo.
plz make sure that sql server is set, too .
make sure that you installed cron to use the service for scheduling jobs by using commands :
sudo systemctl start crond.service
sudo systemctl enable crond.service
sudo systemctl status crond.service
------------------------------------
I wrote scripts , that I am willing to execute in crontabs then append them to the apache server to show them on index
website when i use my VM IP.
i saved the output of the script in a normal file so later I do cat file >> /var/www/html/index.html

-For the first part of the task, I created a script with commands to show the correct data , then I redirected the output on another file so I can use it in the next part to find the average of data in the file.
-never forget to change permissions on scripts you make to execute! -
-second part for finding avg we can use a loop, store # of lines and # of words to find avg using | bc .
-last but not least, I created three files that I am taking their URLs to add on the index so when we click them the data is shown.
so I created a script that include the commands for the three URLs that shown in the index.html , I redirected each part of commands for the suitable files (I named files accoarding to which data they should display).
-Finally creating a crontab, add the timing and commands for zthe jobs by putting the bath of the script we want to execute.
_THANK YOU_
