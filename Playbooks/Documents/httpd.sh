#! bin/bash
sudo yum update httpd
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd