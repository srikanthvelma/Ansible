Manual steps to install OpenMRS on Ubuntu
-----------------------------------------
* Created a vm ubuntu 20.04
* java version 11 and Tomcat version 10.1.5
 
### Steps
* Tomcat Installation
```
sudo apt update
sudo apt install openjdk-11-jdk
sudo groupadd tomcat
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.5/bin/apache-tomcat-10.1.5.tar.gz -P /tmp
sudo tar -xf /tmp/apache-tomcat-10.1.5.tar.gz -C /tmp
sudo mv /tmp/apache-tomcat-10.1.5/ /opt/tomcat
sudo chown -R tomcat: /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/
sudo nano /etc/systemd/system/tomcat.service
```
```
[Unit]
Description=Tomcat 10 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```
```
sudo systemctl daemon-reload
sudo systemctl enable --now tomcat
sudo systemctl status tomcat
```
* OpenMRS installation
```
sudo mkdir /var/lib/OpenMRS
sudo chown -R tomcat:tomcat /var/lib/OpenMRS
wget https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.5.0/openmrs.war
sudo cp openmrs.war /opt/tomcat/webapps/
sudo chown -R tomcat:tomcat /opt/tomcat/webapps/openmrs.war




``` 