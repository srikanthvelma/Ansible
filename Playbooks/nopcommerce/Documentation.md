nopCommerce installation on linux
---------------------------------
[Refer]https://docs.nopcommerce.com/en/installation-and-upgrading/installing-nopcommerce/installing-on-linux.html
* This document describes how to install nopcommerce on ubuntu 20.04
### Installing required softwares
1. register microsoft key and feed
```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
```
![preview](images/nop1.png)
2. install dotnet runtime 
```
sudo apt update
sudo apt-get install -y apt-transport-https aspnetcore-runtime-7.0
```
![preview](images/nop2.png)
3.install mysqlserver
* we need not install mysql in this server, instead we can create mysqldb server and use that for this server
* here we got difficulty for this do , when we run "**mysql_secure_installation**" step to overcome this we should run "**alteruser**"
```
sudo apt-get install mysql-server
```
![preview](images/nop3.png)
By default root passwd is empty ,we have to add one and do some config 
```
sudo /usr/bin/mysql_secure_installation
```
![preview](images/nop4.png)
* here we got a problem of setting password,for this we have to following options
* we have open our vm in new window and kill the process
![preview](images/nop5.png)


