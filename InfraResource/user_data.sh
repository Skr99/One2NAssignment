#!/bin/bash

# Update the package list
sudo yum update -y

# Install git and other dependencies
sudo yum install -y git python3 python3-pip

# Clone the Flask app repository
git clone https://github.com/Skr99/One2NAssignment.git /home/ec2-user/One2NAssignment

# Navigate to the repository directory
cd /home/ec2-user/One2NAssignment

# Create a systemd service file for the Flask app
cat <<EOT >> /etc/systemd/system/flaskapp.service
[Unit]
Description=Flask Application

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/One2NAssignment
ExecStart=/usr/bin/python3 /home/ec2-user/One2NAssignment/s3ListContent.py
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd to apply the new service
sudo systemctl daemon-reload

# Enable the Flask app service to start on boot
sudo systemctl enable flaskapp.service

# Start the Flask app service
sudo systemctl start flaskapp.service
