terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

# Provider configuration for AWS
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# S3 Bucket for Tony's Web App A (Dev Environment)
resource "aws_s3_bucket" "tony-web-app-a-dev" {
  bucket = "tony-web-app-a-dev"
  acl    = "private"

  versioning {
    enabled = true
  }
}

# S3 Bucket for Tony's Web App B (QA/Testing Environment)
resource "aws_s3_bucket" "tony-web-app-b-qa" {
  bucket = "tony-web-app-b-qa"
  acl    = "private"

  versioning {
    enabled = true
  }
}

# S3 Bucket Policy for Tony's Web App A (Dev Environment)
# S3 Bucket Policy for Tony's Web App A - Dev
resource "aws_s3_bucket_policy" "tony-web-app-a-dev-policy" {
  bucket = aws_s3_bucket.tony-web-app-a-dev.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "tony-web-app-a-dev-policy",
  "Statement": [
    {
      "Sid": "AllowIP",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::tony-web-app-a-dev/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "192.168.10.0/24"}
      }
    },
    {
      "Sid": "DenyAllOtherIPs",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::tony-web-app-a-dev/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "0.0.0.0/0"}
      }
    },
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
  ]
}
POLICY
}


# S3 Bucket Policy for Tony's Web App B (QA/Testing Environment)
resource "aws_s3_bucket_policy" "tony-web-app-b-qa-policy" {
  bucket = aws_s3_bucket.tony-web-app-b-qa.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "tony-web-app-b-qa-policy",
  "Statement": [
    {
      "Sid": "AllowSpecificIP",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::tony-web-app-b-qa/*",
      "Condition": {
        "IpAddress": { "aws:SourceIp": "192.168.20.0/24" }
      }
    },
    {
      "Sid": "DenyAllOtherIPs",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::tony-web-app-b-qa/*",
      "Condition": {
        "IpAddress": { "aws:SourceIp": "0.0.0.0/0" }
      }
    }
    {
      "Sid": "AllowQAGroupAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::400000000003:group/QA"
      },
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::tony-web-app-b-qa",
        "arn:aws:s3:::tony-web-app-b-qa/*"
      ]
    }	
  ]
}
POLICY
}
