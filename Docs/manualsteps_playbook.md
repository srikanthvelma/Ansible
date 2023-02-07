Writing manual steps from below Playbook
----------------------------------------

[refer]https://github.com/asquarezone/AnsibleZone/blob/master/Jan23/tomcat-first/tomcat.yml for Playbook


```
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo adduser -m -U -d /opt/home -s /bin/false tomcat     # -m create home, -U create group with same name, -d home dir, -s shell
wget https://www-eu.apache.org/dist/tomcat/tomcat-10.1.4/v10/bin/apache-tomcat-10.tar.gz
sudo tar -xf apache-tomcat-10.tar.gz         or sudo tar -xf apache-tomcat-10.tar.gz -C /opt/tomcat
sudo mv ~/apache-tomcat-10/ /opt/tomcat      or sudo ln -s /opt/tomcat/apache-tomcat-10 /opt/tomcat/latest
sudo chown -R tomcat tomcat
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh
sudo vi /etc/systemd/system/tomcat.service     # add required content
sudo systemctl daemon-reload
sudo systemctl start tomcat.service
sudo systemctl enable tomcat.service
sudo vi /opt/tomcat/latest/webapps/manager/META-INF/context.xml  # add required content here
sudo vi /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml    # add required content here
sudo systemctl restart tomcat.service


```