# Define the committers team for each repository
resource "github_team" "repo_committer_team" {
  for_each = local.project_repositories

  parent_team_id = github_team.repo_team[each.key].slug
  name           = "${each.key}-committers"
  description    = "Committers team for the ${each.key} repository"
  privacy        = "closed"
}

# Add the people to the team
resource "github_team_members" "repo_committer_team_members" {
  for_each = {
    for k, v in var.repositories : k => v
    if v.is_django_commons_repo == false && length(v.committers) > 0
  }

  team_id = github_team.repo_committer_team[each.key].slug

  dynamic "members" {
    for_each = each.value.committers

    content {
      username = members.value
      role     = contains(each.value.admins, members.value) ? "maintainer" : "member"
    }
  }
}

# Define the team's permissions for the repositories
resource "github_team_repository" "repo_committer_team_access" {
  for_each = {
    for k, v in var.repositories : k => v
    if v.is_django_commons_repo == false
  }
  repository = each.key
  team_id    = github_team.repo_committer_team[each.key].slug
  permission = "maintain"
}

