resource "github_repository_environment" "pypi" {
  for_each = { for k, v in var.repositories : k => v if v.is_django_commons_repo == false }

  environment         = "pypi"
  repository          = each.key
  prevent_self_review = false
  reviewers {
    teams = [github_team.repo_admin_team[each.key].id]
  }
}

resource "github_repository_environment" "testpypi" {
  for_each = { for k, v in var.repositories : k => v if v.is_django_commons_repo == false }

  environment         = "testpypi"
  repository          = each.key
  prevent_self_review = false
}