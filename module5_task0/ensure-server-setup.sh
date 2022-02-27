#!/bin/bash 

if [ "$#" -ne 1 ]; then
    echo "You must enter exactly 1 command line argument with ec2 instance public ip"
    exit -1
fi

EC2_INSTANCE=$1

#connect to the server and install docker 20.10
#SCRIPT="sudo apt-get update; sudo apt-get install docker-ce=20.10; sudo systemctl start docker"
ssh ubuntu@$EC2_INSTANCE "bash -s" < ./install_docker.sh

