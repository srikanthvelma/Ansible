Installing JAVA using Ansible and Ansible Role
----------------------------------------------
* created a java role which will work for both ubuntu and centos distributions and for multiple version
* used a variable for versions as "version" in group level
* used a variable for java package as " java_package_name "

### Manual steps
```
sudo apt update
sudo apt install openjdk-11-jdk

sudo yum install java-11-openjdk-devel
```

### Role calling
* written a playbook with above conditions 
* created a role with  name java
* created a role calling yaml file and executed