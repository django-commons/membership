resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "django-commons-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
