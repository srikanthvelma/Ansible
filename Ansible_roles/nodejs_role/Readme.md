Installation of Nodejs using Ansible roles on ubuntu and centos
---------------------------------------------------------------
### Manual steps
#### Ubuntu
* [Refer]https://linuxize.com/post/how-to-install-node-js-on-ubuntu-22-04/
* prefer ubuntu 20.04
* prefer nodejs version v16.x/v.18.x
##### for latest version
  ```
  sudo apt update
  sudo apt install nodejs npm
  nodejs --version
  ```
##### for prefered version
```
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs
nodejs --version
```
#### Centos
* [Refer]https://linuxize.com/post/how-to-install-node-js-on-centos-7/
* prefer centos 7
* prefer nodejs version v16.x/v.18.x
##### for prefered version
```
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs
node --version
```  
### Ansible Playbook
* by using above steps wrriten a single playbook for both ubuntu and centos distribution
* used variables for versions as "**version**" where ever is neccessary
* used "**when**" condition to identify the distribution so that task should for that distribution only
### Ansible Role
* create a role "**nodejs**" by using above playbook
  
  

