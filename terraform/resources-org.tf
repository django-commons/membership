# GitHub Membership Resource
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership
data "github_users" "users" {
  usernames = setunion(var.admins, var.ops_team, var.members)
}

output "invalid_users" {
  value = data.github_users.users.unknown_logins
}

locals {
  users = merge(
    { for user in var.admins : user => "admin" if contains(data.github_users.users.logins, user) },
    { for user in var.ops_team : user => "admin" if contains(data.github_users.users.logins, user) },
    { for user in var.members : user => "member" if contains(data.github_users.users.logins, user) }
  )
}

resource "github_membership" "this" {
  for_each = local.users

  role     = each.value
  username = each.key
}

# Github Organization Security Manager Resource
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_role_team

resource "github_organization_role_team" "admins_security_manager" {
  # Can be confirmed by inspecting the input for the Security Manager role at:
  # https://github.com/organizations/django-commons/settings/org_role_assignments/new
  role_id   = 138
  team_slug = github_team.org_teams["Admins"].slug
}

# Create the organization teams for Django Commons.
resource "github_team" "org_teams" {
  for_each = var.organization_teams

  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}

resource "github_team_members" "org_team_members" {
  for_each = var.organization_teams

  team_id = github_team.org_teams[each.key].id

  dynamic "members" {
    for_each = each.value.members

    content {
      username = members.value
      role     = "member"
    }
  }

  # Maintainer here means the maintainer role for the team. It's not a maintainer of the repo.
  dynamic "members" {
    for_each = each.value.maintainers

    content {
      username = members.value
      role     = "maintainer"
    }
  }
}
