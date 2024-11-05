resource "github_repository_environment" "pypi" {
  for_each = local.project_repositories

  environment         = "pypi"
  repository          = each.key
  prevent_self_review = false
  reviewers {
    teams = [github_team.repo_admin_team[each.key].id]
  }
}

resource "github_repository_environment" "testpypi" {
  for_each = local.project_repositories

  environment         = "testpypi"
  repository          = each.key
  prevent_self_review = false
}