#!/bin/bash

cd terraform/

export TF_VAR_aws_access_key=$(aws iam list-access-keys --user-name terraform | jq  '.AccessKeyMetadata.[0].AccessKeyId') 
export TF_VAR_aws_secret_key=$(aws iam list-access-keys --user-name terraform | jq  '.AccessKeyMetadata.[0].SecretAccessKey') 

terraform fmt
terraform init -reconfigure
terraform plan
terraform apply --auto-approve

