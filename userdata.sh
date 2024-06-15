#!/bin/bash
sudo su
yum update -y
yum install -y httpd
aws s3 cp s3://my-bucket/index.html /var/www/html/
service httpd start
chkconfig httpd on