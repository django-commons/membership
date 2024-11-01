# Github Repository Resource
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository

# Try to import the repository if it already exists
import {
  for_each = var.repositories

  id = each.key
  to = github_repository.this[each.key]
}

resource "github_repository" "this" {
  for_each = var.repositories

  homepage_url                = each.value.homepage_url
  allow_auto_merge            = each.value.allow_auto_merge
  allow_merge_commit          = each.value.allow_merge_commit
  merge_commit_title          = each.value.merge_commit_title
  merge_commit_message        = each.value.merge_commit_message
  allow_rebase_merge          = each.value.allow_rebase_merge
  allow_squash_merge          = each.value.allow_squash_merge
  squash_merge_commit_title   = each.value.squash_merge_commit_title
  squash_merge_commit_message = each.value.squash_merge_commit_message
  allow_update_branch         = each.value.allow_update_branch
  archive_on_destroy          = true
  delete_branch_on_merge      = each.value.delete_branch_on_merge
  description                 = each.value.description
  has_downloads               = each.value.has_downloads
  has_discussions             = each.value.has_discussions
  has_issues                  = true
  has_projects                = true
  has_wiki                    = each.value.has_wiki
  is_template                 = each.value.is_template
  name                        = each.key
  topics                      = each.value.topics
  visibility                  = each.value.visibility
  vulnerability_alerts        = true
  pages                       = each.value.pages

  dynamic "template" {
    for_each = each.value.template != null ? [each.value.template] : []

    content {
      owner      = "django-commons"
      repository = template.value
    }
  }
}


############# Github Branch Protection Resource #############
#
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection
#
# resource "github_branch_protection" "this" {
#
#   # GitHub pull requests should require at least 2 approvals
#   # checkov:skip=CKV_GIT_5: 1 approval is reasonable for a small team
#   for_each = local.branch_protections
#
#   enforce_admins                  = false
#   pattern                         = "main"
#   repository_id                   = github_repository.this[each.key].name
#   require_conversation_resolution = true
#   required_linear_history         = true
#   require_signed_commits          = true
#
#   required_pull_request_reviews {
#     dismiss_stale_reviews           = true
#     require_code_owner_reviews      = true
#     required_approving_review_count = github_repository.this[each.key].required_approving_review_count
#   }
#
#   required_status_checks {
#     contexts = each.value.required_status_checks_contexts
#     strict   = true
#   }
#
#   restrict_pushes {
#     push_allowances = each.value.push_allowances
#   }
# }
