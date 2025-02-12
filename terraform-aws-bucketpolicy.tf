# Provider configuration for AWS
provider "aws" {
  profile = "default"   # Uses the default AWS profile
  region  = "us-east-1" # Sets the region for resources
}

# S3 Bucket for Tony's Web App A
resource "aws_s3_bucket" "tony-web-app-a" {
  bucket = "tony-web-app-a"  # Bucket name
  acl    = "private"         # Only owner has access
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket for Tony's Web App B
resource "aws_s3_bucket" "tony-web-app-b" {
  bucket = "tony-web-app-b"  # Bucket name
  acl    = "private"         # Only owner has access
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket Policy for Tony's Web App A
resource "aws_s3_bucket_policy" "tony-web-app-a" {
  bucket = aws_s3_bucket.tony-web-app-a.id  # Apply the policy to this bucket

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "tony-web-app-a",
  "Statement": [
    {
      "Sid": "AllowIP",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::tony-web-app-a/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "24.85.136.163/32"}
      }
    },
    {
      "Sid": "DenyAllOtherIPs",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::tony-web-app-a/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "0.0.0.0/0"}
      }
    }
  ]
}
POLICY
}

# S3 Bucket Policy for Tony's Web App B
resource "aws_s3_bucket_policy" "tony-web-app-b" {
  bucket = aws_s3_bucket.tony-web-app-b.id  # Apply the policy to this bucket

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "tony-web-app-b",
  "Statement": [
    {
      "Sid": "AllowIP",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::tony-web-app-b/*",  # Correctly referencing "tony-web-app-b"
      "Condition": {
        "IpAddress": {"aws:SourceIp": "24.85.136.163/32"}
      }
    },
    {
      "Sid": "DenyAllOtherIPs",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::tony-web-app-b/*",  # Correctly referencing "tony-web-app-b"
      "Condition": {
        "IpAddress": {"aws:SourceIp": "0.0.0.0/0"}
      }
    }
  ]
}
POLICY
}
