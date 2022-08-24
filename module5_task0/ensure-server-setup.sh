#!/bin/bash

EC2_INSTANCE=$(aws ec2 describe-instances --query "Reservations[].Instances[].PublicIpAddress" --output text)
#sudo mkdir -p /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

ssh ubuntu@"$EC2_INSTANCE" << "EOF"
   sudo apt-get update
   sudo apt-get -y install ca-certificates curl gnupg lsb-release

   echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

   sudo apt-get update
   sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

   sudo systemctl start docker
   sudo usermod -aG docker ubuntu
EOF
