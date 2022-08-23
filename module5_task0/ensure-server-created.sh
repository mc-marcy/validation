#!/bin/bash 

AMI=ami-04505e74c0741db8d
SG=sg-0e62b8c1144bfd1c6

instance=$(aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" \
--filters "Name=instance-state-name,Values=running" "Name=instance-type,Values='t3.micro'" \
--output text)

if [ -z "$instance" ]
then
  echo "no ec2 instances of type t3.micro is running in us-east-1"
  aws ec2 run-instances --image-id $AMI --count 1 --instance-type t3.micro --key-name awesome-key  --security-group-ids $SG
  aws ec2 describe-instances --query "Reservations[].Instances[].PublicDnsName"
else 
  echo "ec2 instances of type t3.micro is running in us-east-1"
  aws ec2 describe-instances --query "Reservations[].Instances[].PublicDnsName"
fi
