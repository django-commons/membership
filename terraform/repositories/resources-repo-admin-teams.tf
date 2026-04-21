# Define the admin team for each repository
resource "github_team" "repo_admin_team" {
  for_each = local.project_repositories

  parent_team_id = github_team.repo_team[each.key].slug
  name           = "${each.key}-admins"
  description    = "Admin team for the ${each.key} repository"
  privacy        = "closed"
}

# Add the people to the team
resource "github_team_members" "repo_admin_members" {
  for_each = local.project_repositories

  team_id = github_team.repo_admin_team[each.key].slug

  dynamic "members" {
    for_each = each.value.admins

    content {
      username = members.value
      role     = contains(local.admins, members.value) ? "maintainer" : "member"
    }
  }
}

# Define the team's permissions for the repositories
resource "github_team_repository" "repo_admin_team_access" {
  for_each   = local.project_repositories
  repository = each.key
  team_id    = github_team.repo_admin_team[each.key].slug
  permission = "admin"
}