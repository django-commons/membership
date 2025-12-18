# Local Values
# https://www.terraform.io/language/values/locals

locals {

  project_repositories = {
    for repository_key, repository in var.repositories : repository_key => repository
    if !repository.is_django_commons_repo
  }
}
