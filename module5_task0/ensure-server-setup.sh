#!/bin/bash 

sudo yum install awscli
EC2_INSTANCE=aws ec2 describe-instances --query "Reservations[].Instances[].PublicDnsName"

#connect to the server and install docker 20.10
#SCRIPT="sudo apt-get update; sudo apt-get install docker-ce=20.10; sudo systemctl start docker"
ssh ec2-user@"$EC2_INSTANCE" uname

