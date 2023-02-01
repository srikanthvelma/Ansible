Installation of Dotnet using Ansible roles on ubuntu and centos
---------------------------------------------------------------
### Manual steps
#### Ubuntu
* [Refer]
* prefer ubuntu 20.04
* prefer dotnet-sdk-6.0/7.0
##### for prefered version
```
sudo apt update
sudo apt install apt-transport-https
sudo apt install -y dotnet-sdk-7.0
```
#### Centos
* [Refer]https://learn.microsoft.com/en-us/dotnet/core/install/linux-centos
* prefer centos 7
* prefer dotnet-sdk-6.0/7.0
##### for prefered version
```
sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
sudo yum install dotnet-sdk-7.0
```  
### Ansible Playbook
* by using above steps wrriten a single playbook for both ubuntu and centos distribution
* used variables for versions as "**version**" where ever is neccessary
* used "**when**" condition to identify the distribution so that task should for that distribution only
### Ansible Role
* create a role "**dotnet**" by using above playbook
  
  

