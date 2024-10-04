# Local Values
# https://www.terraform.io/language/values/locals

locals {

  admins = {
    for user in var.admins : user => "admin"
  }

  branch_protections = {
    for repository_key, repository in var.repositories : repository_key => repository
    if repository.enable_branch_protection
  }

  members = {
    for user in var.members : user => "member"
  }

  users = merge(local.admins, local.members)
}
