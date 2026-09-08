# IAM Identity Center must be enabled before applying this file.
# AWS Console → IAM Identity Center → Enable
data "aws_ssoadmin_instances" "this" {}

data "aws_caller_identity" "current" {}

locals {
  sso_instance_arn  = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_ssoadmin_permission_set" "terraform_state" {
  name             = "TerraformStateAccess"
  description      = "Read/write access to django-commons Terraform state"
  instance_arn     = local.sso_instance_arn
  session_duration = "PT8H"
}

resource "aws_ssoadmin_permission_set_inline_policy" "terraform_state" {
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.terraform_state.arn
  inline_policy      = data.aws_iam_policy_document.terraform_state_access.json
}

resource "aws_identitystore_user" "collaborators" {
  for_each          = { for c in var.collaborators : c.username => c }
  identity_store_id = local.identity_store_id

  user_name    = each.value.username
  display_name = each.value.display_name

  name {
    given_name  = each.value.given_name
    family_name = each.value.family_name
  }

  emails {
    value   = each.value.email
    primary = true
  }
}

resource "aws_ssoadmin_account_assignment" "collaborators" {
  for_each           = aws_identitystore_user.collaborators
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.terraform_state.arn

  principal_id   = each.value.user_id
  principal_type = "USER"

  target_id   = data.aws_caller_identity.current.account_id
  target_type = "AWS_ACCOUNT"
}
