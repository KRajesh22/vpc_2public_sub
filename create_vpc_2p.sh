#!/bin/bash

NOW=$(date +"%F")
LOGFILE="vpc-$NOW.log"

echo Creating VPC...
aws ec2 create-vpc --cidr-block 10.0.0.0/16 >> $LOGFILE
vpc=`grep VpcId $LOGFILE | cut -d : -f2 | cut -c3-14`
echo VPC $vpc is Created!

echo Creating Subnet 10.0.1.0/24
aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.1.0/24 \
--availability-zone eu-west-1a >> $LOGFILE
sub1=`grep SubnetId $LOGFILE | cut -d : -f2 | cut -c3-17`

echo Creating Subnet 10.0.2.0/24
aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.2.0/24 \
--availability-zone eu-west-1b >> $LOGFILE
sub2=`grep SubnetId $LOGFILE | cut -d : -f2 | cut -c3-17 | awk 'NR==2{print $1}'`

echo Subnets $sub1 and $sub2 are created!

echo Creating Internet Gateway..
aws ec2 create-internet-gateway >> $LOGFILE
gw=`grep InternetGatewayId $LOGFILE | cut -d : -f2 | cut -c3-14`
echo Internet GW $gw created!

echo Attaching IGW to VPC
aws ec2 attach-internet-gateway --internet-gateway-id \
$gw --vpc-id $vpc
echo Attached

echo Creating route-table
aws ec2 create-route-table --vpc-id $vpc >> $LOGFILE
rtp=`grep RouteTableId $LOGFILE | cut -d : -f2 | cut -c3-14`

echo Adding default-route to $rtp
aws ec2 create-route --route-table-id $rtp --destination-cidr-block 0.0.0.0/0 \
--gateway-id $gw >> $LOGFILE

echo Associating $sub1 and $sub2 with $rtp
aws ec2 associate-route-table --route-table-id $rtp --subnet-id $sub1 >> $LOGFILE
aws ec2 associate-route-table --route-table-id $rtp --subnet-id $sub2 >> $LOGFILE
echo Done!
