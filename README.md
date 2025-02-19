# AWS-s3-BucketPolicy
The project primarily aims to centralize AWS S3 management to improve progress to deployment.

## Scope
Utilize Terraform to centrally manage S3 buckets and their respective bucket policies for multiple environments such as testing and production environment. Different IAM roles, such as dev and admin, are assigned to monitor and manage specific environments.

## AWS Resource Details
Assume there have two subnet for Dev or QA
- Dev 192.168.10.0/24 
- QA 192.168.20.0/24

## Step to Run the Terrform
1. Create a folder for store all the terrform related files
2. Execute the terrform to bulid the user base on the config in main.tf
3. Verify status in the file

## Optional configuration

### Enable Versioning in bucket resource
```hcl
resource "aws_s3_bucket" "tony-web-app-a-dev" {
  bucket = "tony-web-app-a-dev"
  acl    = "private"

  versioning {
    enabled = true
  }
}
```
### Bucket policy for allow specific IP Address
```hcl
    {
      "Sid": "AllowIP",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::tony-web-app-a-dev/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "192.168.10.0/24"}
      }
    }
```
### Bucket policy for IAM Group
```hcl
    {
      "Sid": "AllowDevGroupAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::400000000003:group/Dev"
      },
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::tony-web-app-a-dev",
        "arn:aws:s3:::tony-web-app-a-dev/*"
      ]
    }
```
### Deny all other IP Address than 192.168.10.0/24
```hcl
    {
      "Sid": "DenyAllOtherIPs",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::tony-web-app-a-dev/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "0.0.0.0/0"}
      }
    }
```
 