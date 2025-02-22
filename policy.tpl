{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowIP",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${bucket_name}/*",
      "Condition": {
        "IpAddress": { "aws:SourceIp": "${ip_range}" }
      }
    },
    {
      "Sid": "AllowIAMGroup",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${iam_group}"
      },
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::${bucket_name}",
        "arn:aws:s3:::${bucket_name}/*"
      ]
    },
    {
      "Sid": "DenyAllOtherIPs",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${bucket_name}/*",
      "Condition": {
        "IpAddress": { "aws:SourceIp": "0.0.0.0/0" }
      }
    }
  ]
}
