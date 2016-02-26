# vpc_cli_2sub
Create a vpc by bash script or CloudFormation Template.
With this script you will create a VPC (virtual private cloud) on AWS.

The script creates:

1. VPC.
2. Two public subnets in eu-west-1 region ( in to different Avability Zones).
3. Internet Gateway
4. Route table with default entry.

USING bash script:

1. Download .sh file.
2. Add execute permision: chmod +x create_vpc_2p.sh
3. Just run the script: create_vpc_2p.sh
 
USING CloudFormation:
Use the content of the file in AWS CloudFormation console.
More details:
http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-stack.html

Remember, my script include AZ from Virginia Regions.
