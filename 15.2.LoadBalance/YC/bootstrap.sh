#!/bin/bash
yum install httpd -y
service httpd start
cd /var/www/html
echo "<img src="https://storage.yandexcloud.net/storage-website-test.hashicorp.com/ny.jpg" alt="NY">" > index.html