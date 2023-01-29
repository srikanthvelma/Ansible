#! bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.4/bin/apache-tomcat-10.1.4.tar.gz -P /tmp
sudo tar -xf /tmp/apache-tomcat-10.1.4.tar.gz -C /opt/tomcat/
sudo ln -s /opt/tomcat/apache-tomcat-10.1.4 /opt/tomcat/latest
sudo chown -R tomcat: /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'