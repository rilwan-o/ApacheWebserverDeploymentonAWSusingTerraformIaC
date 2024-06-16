#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start
sudo chkconfig httpd on
git clone https://github.com/cloudboostauk/webApp-RQGen-A.git
sudo cp -R webApp-Quizz-B/ /var/www/html/
sudo chmod -R 755 /var/www/html/webApp-Quizz-B
sudo chown -R apache:apache /var/www/html/webApp-Quizz-B
sudo service httpd start

