# AWS-s3-BucketPolicy
The project primarily aims to centralize AWS VM management to improve progress to deployment.

## Scope
Utilize Terraform to centrally manage S3 buckets and their respective bucket policies for multiple environments such as test and prod environment.

## Step to Run the Terrform
1. Create a folder for store all the terrform related files
2. Execute the terrform to bulid the user base on the config in main.tf
3. Verify status in the file

## Content that includes
- VPC created for departnment, aws_vpc
- subnet under vpc
- static internal IP address of the for webserver
- EC2 for webserver 01