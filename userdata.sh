#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo yum install git
sudo service httpd start
sudo chkconfig httpd on
git clone https://github.com/cloudboostauk/webApp-RQGen-A.git
sudo cp -R /webApp-RQGen-A/ /var/www/html/
sudo chmod -R 755 /var/www/html/webApp-RQGen-A
sudo chown -R apache:apache /var/www/html/webApp-RQGen-A
sudo service httpd start

