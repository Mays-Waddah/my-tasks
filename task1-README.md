
Part 1:
Create a volume group, and set 16M as extends. And divided a volume group containing 50 extends on
volume group lv, make it as ext4 file system, and mounted automatically under /mnt/data. Please
note that this should be implemented on the second disk.

-------------solution--------------
1)Create a volume group:

//fdisk -l : to show info and find the disk name ("/dev/sda")
//pvs to display information about that physical volumes

 [root@osboxes mays]# pvcreate /dev/sda1   >> initializes /dev/sda1 for use as LVM physical volumes.
>>  Physical volume "/dev/sda1" successfully created.

 [root@osboxes mays]# vgcreate vg1 /dev/sda1
>>  Volume group "vg1" successfully created

 [root@osboxes ~]# vgs
  VG   #PV #LV #SN Attr   VSize    VFree
  vg01   1   0   0 wz--n- 1020.00m 1020.00m

 // Add physical volumes to a volume group
 [root@osboxes ~]#vgcreate -s 16M vg1 /dev/sda1
>>  Volume group "vg1" successfully created






----------------------------------------------------------------------------------
Part 2: users, groups and permissions
1- Add user: user1, set uid=601 Password: redhat. The user's login shell should be
non-interactive. (no ssh access to server)
2- Add user1 to group TrainingGroup.
3- Add users: user2, user3. The Additional group of the two users: user2, user3 is the admin
group Password: redhat, user 3 with root permissions



-------------solution--------------
1)

-i'll start with the nonlogin part to add user with no login in one command :

[root@osboxes ~]# adduser user1 -s /sbin/nologin
to check : 
[root@osboxes ~]# cat /etc/passwd |grep user1
>>user1:x:601:1003::/home/user1:/sbin/nologin

2)

*Add user1 to group TrainingGroup.
[root@osboxes ~]# groupadd TrainingGroup
[root@osboxes ~]# usermod -a -G TrainingGroup user1
-check :
[root@osboxes ~]# groups user1
user1 : user1 TrainingGroup

*create password : redhat >> 
[root@osboxes ~]#passwd user1

*set userid =601 >>
[root@osboxes ~]#usermod -u 601 user1

3- Add users: user2, user3. The Additional group of the two users: user2, user3 is the admin
group Password: redhat, user 3 with root permissions

*useradd user2
admin access to user3: //add user3 to sudo group

1-useradd user3 ,2-passwd user3 ,3-add user to the sudo group,4-su user3 5- sudo tee /etc/sudoers.d/user3
   Verify it by running the (id username ) : 
 >> We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility. <<

*group additional password :
[root@osboxes mays]# gpasswd additional

/* add user2,user3 to group additional + check info:
[root@osboxes mays]# usermod -a -G  additional user3
[user3@osboxes mays]$ id user3
uid=1004(user3) gid=1006(user3) groups=1006(user3),10(wheel),1007(additional)

[root@osboxes mays]# usermod -a -G  additional user2
[root@osboxes mays]# id user2
uid=1003(user2) gid=1005(user2) groups=1005(user2),1007(additional)
*/
--------------------------
-to check user1 info i used:
[root@osboxes mays]# id user1
uid=601(user1) gid=1003(user1) groups=1003(user1),1004(TrainingGroup)



--------------------------------------------------------------------------------------
Part 3: 
SSH Generate SSH key and connect to different VM without password. 
-------------solution--------------
SSH keys enable the automation that makes modern cloud services and other computer-dependent services possible and cost-effective+t used to avoid enter username/pass to ssh server.
-root user

1)ssh-keygen
2)file: /root/.ssh/id_rsa ( the default )
3)passphrase : enter + enter
4)ssh-copy-id -i /root/.ssh/id_rsa.pub root@targetclient-server
: we used copy id command as we can do (cat id_rsa.pub) then copy it to paste in the targeted server so we login.
5)we enter the root pass to add the key to the target server then we can log in the machine with another server and it wont ask for the password.

—----------------------------------------------------------------------------------







Part 4:
 permissions

Copy /etc/fstab to /var/tmp name admin, the user1 could read, write and modify it, while user2 can’t do
any permission.

-------------solution--------------
cp /etc/fstab /var/tmp/  :copy command
setfacl -m u:user1:rwx /var/tmp/fstab  :setfacl to change the permissions
 setfacl -m u:user2:--- /var/tmp/fstab

------------------------------------------------------------------------------------------
Part 5: permissions //permenent
SELinux must be running in the Enforcing mode (permanent even after reboot).

-------------solution--------------
 cp /etc/fstab /var/tmp/

 setfacl -m u:user1:rwx /var/tmp/fstab

 setfacl -m u:user2:--- /var/tmp/fstab

---------------------------------------------------------------------------------------------
Part 6:bash script and processes kill
Write a shell script that will keep running for 10 mins in the background and check the process that it's created and try to kill using commands.
 //either with while true; or nohup&

-------------solution--------------
#nohup bash myprocess.sh &
#ps (to show processes)
#kill -l [ #of process] | -L

—------------------------------------------------------------------------------------------

Part 7: Yum Repo //needs installation of yum …
 1- Install tmux on your machine
 2- Install apache server on your machine(httpd) 
*and Install mysql.
 3- Create a local yum repository on your local machine(available publicly) with the zabbix rpms: https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/
4- Disable all other repositories and keep only the new repo
================================
-------------solution--------------
-first i had to install yum updates , solve the (no URLs in mirror list ) + no basuer ..
-make sure no DNS problems.
-make sure internet is connected (tried ping google.com).
[root@osboxes mays]# cd /etc/yum.repos.d/
[root@osboxes yum.repos.d]# sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
[root@osboxes yum.repos.d]# sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
[root@osboxes yum.repos.d]# yum update -y

—-------- yum repo issue is fixed—---------------

start installing tmux server :
sudo yum -y install tmux 
#Installed:
  tmux-2.7-1.el8.x86_64
Complete!


apache :
sudo dnf install httpd 
sudo systemctl start httpd #to start the service
showing status : sudo systemctl status httpd
  sql :
*i had to add my server to the hosts :
ssh root@osboxes  then agreed to fingerprint .
(# Permanently added 'osboxes,fe80::c7ea:1043:1b02:9a4f%enp0s3' (ECDSA) to the list of known hosts.
root@osboxes's password: # i entered it 
Activate the web console with: systemctl enable --now cockpit.socket
Last login: Sun Aug 21 02:13:41 2022 #successfully done !
*make sure if all packages are updated using :
sudo dnf update , sudo yum update .
#nothing to do , all is completed !
*search before installing : #sudo yum search mysql-server 
*see info :sudo yum info mysql-server
*finally install it : sudo yum install mysql-server  #agreed to install packages.
 
*Enabling MySQL 8 mysqld.service,server : sudo systemctl enable mysqld.service
-Created symlink /etc/systemd/system/multi-user.target.wants/mysqld.service → /usr/lib/systemd/system/mysqld.service.
*start the revice:sudo systemctl start mysqld.service 
*show status:sudo systemctl status mysqld.service 
 
local repo :
-since httpd is installed , enabled and started.
-check the httpd service using the netstat command below and make sure the HTTP port '80' is on the 'LISTEN' state :  netstat -plntu
-we have to install zappix rpms then locate it in a directory…see /etc/yum.repos.d and /var/www/html/ … should be after installation /var/www/html/zabbix
- sudo yum install createrepo_c 
 
 
 
Install and Configure Zabbix 4.0 LTS :
Firstly, we need to add the Zabbix 4.0 LTS repository to the system using the rpm :
rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/8/x86_64/zabbix-release-4.0-2.el8.noarch.rpm 
[root@osboxes mays]# rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/8/x86_64/zabbix-release-4.0-2.el8.noarch.rpm
Retrieving https://repo.zabbix.com/zabbix/4.0/rhel/8/x86_64/zabbix-release-4.0-2.el8.noarch.rpm
warning: /var/tmp/rpm-tmp.obBBxt: Header V4 RSA/SHA512 Signature, key ID a14fe591: NOKEY
Verifying...                          ################################# [100%]
Preparing...                          ################################# [100%]
Updating / installing...
  1:zabbix-release-4.0-2.el8         ################################# [100%]
*then, remove system packages cache and check all available repository on the system :
yum clean all #do it after working with packages 
yum repolist  #to list all repos in my server
*run the command below to install Zabbix Server and Agent :
yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-agent 
 
—------------------------------------------------------------------------------------------------------
5- Install zabbix rpms from the new repo (Download zabbix, zabbix-web,php, zabbix-server, zabbix-agent rpm’s and their dependencies)  :
dnf clean all 
*Switch DNF module version for PHP 
dnf module switch-to php:7.4 
rpm -Uvh https://repo.zabbix.com/zabbix/6.2/rhel/8/x86_64/zabbix-release-6.2-1.el8.noarch.rpm 
-install php: # dnf install php-cli php-common php-devel php-pear php-gd php-mbstring php-mysqlnd php-xml php-bcmath 
-configure the PHP configuration :vim /etc/php.ini 
adding these :date.timezone = Asia/Jakarta 
max_execution_time = 600 
max_input_time = 600 
memory_limit = 256M 
post_max_size = 32M 
upload_max_filesize = 16M  
and save.
restart the service: systemctl restart httpd 
—-php installation is completed—--
*Install Zabbix server, frontend, agent :
yum install zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent .
Create initial database using zabbix: #to store data in it later
#mysql -uroot 
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin; 
mysql> create user zabbix@localhost identified by 'password'; 
mysql> grant all privileges on zabbix.* to zabbix@localhost; 
mysql> SET GLOBAL log_bin_trust_function_creators = 1; 
mysql> quit; 
–bye !---
*import initial schema and data 
zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix  zabbix 
mysql -uroot -p 
password 
mysql> SET GLOBAL log_bin_trust_function_creators = 0; 
mysql> quit; 
* Configure the database for Zabbix server by Edit file /etc/zabbix/zabbix_server.conf 
DBPassword=password 
systemctl restart zabbix-server zabbix-agent httpd php-fpm 
# systemctl enable zabbix-server zabbix-agent httpd php-fpm 
—--------------------------
 Disable all other repositories and keep only the new repo :
#yum-config-manager --disable \*--enablerepo=zabbix update


 
 
 
 
 
 
 

 

Part 8: Network management
1- Open port 443 , 80 2- Make the changes permanent 3- Block ssh connection for your colleague ip to the VM.
-------------solution--------------
-should be a root user
1)firewall-cmd --list-all
We use it first to check all ports and see its status if enabled or disabled so if they are already opened we don’t try to open again.
2) firewall-cmd --get-services
to check if the service available
3)firewall-cmd --get-zones
to list the zones as we choose the public mostly cuz it’s the default
4)firewall-cmd --zone=public --permanent --add-port 443/tcp
5)firewall-cmd --zone=public --permanent --add-port 80/tcp
opening ports
firewall-cmd --reload
firewall-cmd --list-all
reload and confirm to save changes.
-we used -permanent to make changes permanent in our network.

or : //mostly used if there are several ports to be opened
#!/bin/bash for i in 443 80
 do firewall-cmd --zone=public --add-port=${i}/tcp done

-Block ssh connection for your colleague ip to the VM.
vi /etc/hosts/deny
sshd 172.20.49.65
esc + :wq!
—----------------------------------------------------------------------------------------
Part 9: Cronjob 
Create a cronjob that will run at 1:30 AM every day and collect the users logged in and save them in a file Format : timestamp – users Note: the cronjob can run a script.

-------------solution--------------

crontab -e (to enter and edit then enter i for insert)
30 01 * * *  /var/log/syslog
vi myscript.sh
#! /bin/bash then greb users /var/log/syslog > /etc/fstab ,
 esc and : wq! to save changes .
finally:chmod +x myscript.sh (to execute the script).
—------------------------------------------------------------------------------------

Part 10: Mariadb
 1- install mariadb from the local repo that was created earlier. 
2- open ports in iptables from mariadb. 
3- create database , user(note: handle permissions).
4- connect to the database created in step 3 using the new user (with password) Example schema : Create a MariaDB database called studentdb on rhce1 and add ten records each containing “student firstname” (Allen, David, Mary, Dennis, Joseph, Dennis, Ritchie, Robert, David, and Mary), “student lastname” (Brown,Brown, Green, Green, Black, Black, Salt, Salt, Suzuki, and Chen), program enrolled in (3 x mechanical, 3 x electrical,and 4 x computer science), expected graduation year (2 x 2017, 3 x 2018, 5 x 2020), and a student number (110-001 to 110-010

-------------solution--------------
-create a local repo
-find rpms 
install them
-use downloadonly and the link then install
