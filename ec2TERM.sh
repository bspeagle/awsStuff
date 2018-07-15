#!/bin/bash

#set -x

regions=(ap-south-1
eu-west-3
eu-west-2
eu-west-1
ap-northeast-2
ap-northeast-1
sa-east-1
ca-central-1
ap-southeast-1
ap-southeast-2
eu-central-1
us-east-1
us-east-2
us-west-1
us-west-2)

echo ${regions[*]}

for region in ${regions[*]};
do
	echo '---REGION: '$region' ---';
	
	for instance in `aws ec2 describe-instances --region $region --output text --query "Reservations[*].Instances[*].[InstanceId]"`;
	do
		echo 'ISTANCEID: '$instance;
		aws ec2 modify-instance-attribute --instance-id $instance --no-disable-api-termination --region $region;
		aws ec2 terminate-instances --instance-ids $instance --region $region;	
	done
done