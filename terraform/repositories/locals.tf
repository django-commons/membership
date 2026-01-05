# Local Values
# https://www.terraform.io/language/values/locals

data "github_team" "admins_team" {
  slug = "Admins"
}

locals {
  project_repositories = {
    for repository_key, repository in var.repositories : repository_key => repository
    if !repository.is_django_commons_repo
  }

  admins = data.github_team.admins_team.members
}
