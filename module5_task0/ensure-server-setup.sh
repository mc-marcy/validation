#!/bin/bash 
sudo apt-get install -y unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
sudo unzip -q -o awscliv2.zip
sudo ./aws/install

EC2_INSTANCE=aws ec2 describe-instances --query "Reservations[].Instances[].PublicDnsName"
ssh ubuntu@"$EC2_INSTANCE"

