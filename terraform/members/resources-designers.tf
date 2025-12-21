# Create the organization teams for Django Commons.
resource "github_team" "org_designers_team" {
  name        = "Designers"
  description = "Django Commons designers"
  privacy     = "closed"

}


resource "github_team_members" "org_designers_team_members" {
  team_id = github_team.org_designers_team.id

  dynamic "members" {
    for_each = var.designers

    content {
      username = members.value
      role     = "member"
    }
  }
}

