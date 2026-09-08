# Backend Configuration
# https://opentofu.org/docs/language/settings/backends/s3/

terraform {
  backend "s3" {
    bucket         = "django-commons-tofu-state"
    key            = "members/tfstate.json"
    region         = "us-east-1"
    dynamodb_table = "django-commons-tofu-state-lock"
    encrypt        = true
  }
}
