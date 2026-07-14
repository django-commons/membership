output "state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "state_lock_table_name" {
  description = "DynamoDB table name for state locking"
  value       = aws_dynamodb_table.terraform_state_lock.name
}

output "github_actions_apply_role_arns" {
  description = "IAM apply role ARNs by repo — add each as AWS_APPLY_ROLE_ARN in the corresponding repository"
  value       = { for k, role in aws_iam_role.github_actions_apply : k => role.arn }
}

output "github_actions_plan_role_arns" {
  description = "IAM plan role ARNs by repo — add each as AWS_PLAN_ROLE_ARN in the corresponding repository"
  value       = { for k, role in aws_iam_role.github_actions_plan : k => role.arn }
}

output "sso_start_url" {
  description = "AWS access portal URL to share with collaborators for sign-in"
  value       = "https://${local.identity_store_id}.awsapps.com/start"
}
