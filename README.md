# windows-administration
windows administration with machines in aws

For getting the windows ami use the aws command:
aws ec2 describe-images --owners amazon --filters "Name=name,Values=Windows_Server-2019-English*" --query 'sort_by(Images, &CreationDate)[]Name'

for launching the instances in aws:
0/ connect to aws with your credentials with the command aws configure
1/execute  ./aws_tf_user.sh to create terraform user and the state bucket
2/execute ./init_terraform.sh to create resources