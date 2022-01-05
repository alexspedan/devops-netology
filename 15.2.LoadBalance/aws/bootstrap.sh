#!/bin/bash
yum install httpd -y
service httpd start
cd /var/www/html
echo "<img src="https://s3.eu-central-1.amazonaws.com/netology-apedan/ny.jpg" alt="NY">" > index.html