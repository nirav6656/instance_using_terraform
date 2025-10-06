#!/bin/bash
# install_nginx.sh
# Script to install and start Nginx on Amazon Linux

# Exit immediately if a command fails
set -e

echo "----------------------------------------"
echo "Updating system packages..."
echo "----------------------------------------"
sudo yum update -y

echo "----------------------------------------"
echo "Installing Nginx..."
echo "----------------------------------------"
sudo amazon-linux-extras install nginx1 -y

echo "----------------------------------------"
echo "Enabling Nginx to start on boot..."
echo "----------------------------------------"
sudo systemctl enable nginx

echo "----------------------------------------"
echo "Starting Nginx service..."
echo "----------------------------------------"
sudo systemctl start nginx

echo "----------------------------------------"
echo "Checking Nginx status..."
echo "----------------------------------------"
sudo systemctl status nginx --no-pager

echo "----------------------------------------"
echo "Nginx installation complete!"
echo "Access the web server using your EC2 public IP."
echo "----------------------------------------"

