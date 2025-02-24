# Create the main repository team for Django Commons.
resource "github_team" "repo_team" {
  for_each = local.project_repositories

  name        = each.key
  description = "Main team for the ${each.key} repository"
  privacy     = "closed"
}
# Add the people to the team
resource "github_team_members" "repo_team_members" {
  for_each = local.project_repositories

  team_id = github_team.repo_team[each.key].slug

  dynamic "members" {
    # Add the admins and committers as members because this is the parent
    # team for the organization. If the team is mentioned in a discussion,
    # they too should be notified.
    for_each = setunion(each.value.members, each.value.committers, each.value.admins)

    content {
      # members here references the dynamic name, not the looped entity.
      username = members.value
      role     = contains(var.admins, members.value) ? "maintainer" : "member"
    }
  }
}
# Define the team's permissions for the repositories
resource "github_team_repository" "repo_team_access" {
  for_each   = local.project_repositories
  repository = each.key
  team_id    = github_team.repo_team[each.key].slug
  permission = "triage"
}
# GitHub Team Settings Resource
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_settings

# This is used to enable automatic PR review requests
resource "github_team_settings" "this" {
  for_each = local.project_repositories

  review_request_delegation {
    algorithm    = "LOAD_BALANCE"
    member_count = 2
    notify       = false
  }

  team_id = github_team.repo_team[each.key].slug
}
