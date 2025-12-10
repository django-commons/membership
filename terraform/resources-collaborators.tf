# This aims to remove all manually added users from the repository collaborators

locals {
  repo_collaborators = {
    for key, value in local.project_repositories : key => [
      {
        team_id    = github_team.org_teams["Admins"].slug
        permission = "pull"
      },
      {
        team_id    = github_team.repo_admin_team[key].slug
        permission = "admin"
      },
      {
        team_id    = github_team.repo_committer_team[key].slug
        permission = "maintain"
      },
      {
        team_id    = github_team.repo_team[key].slug
        permission = "triage"
      }
    ]
  }
}

import {
  for_each = local.project_repositories

  id = each.key
  to = github_repository_collaborators.this[each.key]
}

resource "github_repository_collaborators" "this" {
  for_each = local.repo_collaborators

  repository = github_repository.this[each.key].name
  dynamic "team" {
    for_each = local.repo_collaborators[each.key]
    content {
      team_id    = team.value.team_id
      permission = team.value.permission
    }
  }
}