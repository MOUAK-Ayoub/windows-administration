#!/bin/bash

# the shell script create a policy and attach it to a user 
# Then, the script create access keys to the user
# Finally, the script creates a bucket for storing a state file
echo " Create policy: "
aws iam create-policy \
 --policy-name TfUserPolicy \
 --policy-document file://./TfUserPolicy.json
 
sleep 5s

terraform_policy_arn=$(aws iam list-policies --query 'Policies[?PolicyName==`"TfUserPolicy"`].Arn' --output text)

echo " Create User: "

aws iam create-user --user-name terraform
sleep 5s

echo " Attach policy to user: "

aws iam attach-user-policy --policy-arn $terraform_policy_arn --user-name terraform
sleep 10s

echo "Create Access key to user: "

aws iam create-access-key --user-name terraform 

echo " Create bucket: "

aws s3api create-bucket --bucket terraformstatefile2024
