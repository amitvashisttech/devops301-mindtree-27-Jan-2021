#!/bin/bash

yum update -y 
yum install httpd -y 
systemctl start httpd
systemctl enable httpd


mkdir -p /var/www/html/terraform
echo "Welcome to the world of Terraform v12" > /var/www/html/terraform/hello.html
