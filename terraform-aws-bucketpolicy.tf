provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_s3_bucket_policy" "tony-web-app-a" {
  bucket = aws_s3_bucket.tony-web-app-a.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "tony-web-app-a",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::tony-web-app-a/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "8.8.8.8/32"}
      }
    }
  ]
}
POLICY
}