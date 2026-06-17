variable "aws_region" {
  description = "AWS region for DynamoDB and related resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for Terraform state (must be globally unique)"
  type        = string
  default     = "django-commons-terraform-state"
}

variable "collaborators" {
  description = "Team members to add to IAM Identity Center with Terraform state access"
  type = list(object({
    username     = string
    display_name = string
    given_name   = string
    family_name  = string
    email        = string
  }))
  default = []
}
