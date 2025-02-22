variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile name for authentication"
  type        = string
  default     = "default"
}

variable "s3_buckets" {
  description = "List of S3 buckets with their settings"
  type = list(object({
    name       = string
    acl        = string
    ip_range   = string
    iam_group  = string
  }))
  default = [
    {
      name      = "tony-web-app-a-dev"
      acl       = "private"
      ip_range  = "192.168.10.0/24"
      iam_group = "arn:aws:iam::400000000003:group/Dev"
    },
    {
      name      = "tony-web-app-b-qa"
      acl       = "private"
      ip_range  = "192.168.20.0/24"
      iam_group = "arn:aws:iam::400000000003:group/qa"
    }
  ]
}
