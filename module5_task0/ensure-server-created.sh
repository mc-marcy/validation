#!/bin/bash 

AMI=ami-052efd3df9dad4825
SG=awesome-sg

instance=$(aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" \
--filters "Name=instance-state-name,Values=running" "Name=instance-type,Values='t3.micro'" \
--output text)

if [ -z "$instance" ]
then
  aws ec2 run-instances --image-id $AMI --count 1 --instance-type t3.micro --key-name awesome-key  --security-group-ids $SG 2>/dev/null 1>&2
fi
