# Required Providers
# https://www.terraform.io/docs/language/providers/requirements.html#requiring-providers

terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.3.1"
    }
  }
}

# Github Provider
# https://registry.terraform.io/providers/integrations/github/latest/docs

provider "github" {
  owner = "django-commons"
  token = var.github_token
}


# Random Password Resource
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password

############# GitHub Organization Secret Resource #############

# This is necessary to set a GitHub org secret
# resource "random_password" "this" {
#   for_each = var.organization_secrets
#   length   = 32
#   special  = false
#
#   keepers = {
#     rotation_time = time_rotating.this.rotation_rfc3339
#   }
# }

# Time Rotating Resource
# https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating

# This is necessary to use random_password, which is needed
# to set a GitHub org secret
# resource "time_rotating" "this" {
#   rotation_days = 5
# }

# Github Actions Secret Resource
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret

# resource "github_actions_organization_secret" "this" {
#
#   # Ensure GitHub Actions secrets are encrypted
#   # checkov:skip=CKV_GIT_4: We are passing the secret from the random_password resource which is sensitive by default
#   # and not checking in any plain text values. State is always secured.
#
#   for_each = var.organization_secrets
#
#   plaintext_value = random_password.this[each.key].result
#   secret_name     = each.key
#   visibility      = each.value.visibility
# }
