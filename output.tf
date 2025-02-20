# Output the bucket names and policy ARNs for verification
output "tony_web_app_a_dev_bucket" {
  value = aws_s3_bucket.tony-web-app-a-dev.id
  description = "Bucket name for Tony's Web App A (Dev)"
}

output "tony_web_app_a_dev_policy" {
  value = aws_s3_bucket_policy.tony-web-app-a-dev-policy.policy
  description = "Policy applied to Tony's Web App A (Dev)"
}

output "tony_web_app_b_qa_bucket" {
  value = aws_s3_bucket.tony-web-app-b-qa.id
  description = "Bucket name for Tony's Web App B (QA)"
}

output "tony_web_app_b_qa_policy" {
  value = aws_s3_bucket_policy.tony-web-app-b-qa-policy.policy
  description = "Policy applied to Tony's Web App B (QA)"
}