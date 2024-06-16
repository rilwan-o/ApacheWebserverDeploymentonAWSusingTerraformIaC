#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
# Install Node.js and npm from NodeSource
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs
sudo service httpd start
sudo chkconfig httpd on
git clone https://github.com/cloudboostauk/webApp-Quizz-B.git
cd webApp-Quizz-B
npm install
npm start
