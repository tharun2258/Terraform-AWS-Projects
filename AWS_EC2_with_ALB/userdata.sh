#!/bin/bash

# Update all packages to ensure the system is up-to-date
yum update -y

# Install Apache HTTP server (httpd)
yum install -y httpd

# Start the Apache HTTP server and enable it to start on boot
systemctl start httpd
systemctl enable httpd

# Create a simple HTML page to test the web server
echo "<html><body><h1>Hello, World!-1</h1></body></html>" > /var/www/html/index.html

# (Optional) Set proper permissions to ensure Apache can serve the file
chown apache:apache /var/www/html/index.html

# (Optional) Check if Apache is running after starting it
systemctl status httpd
