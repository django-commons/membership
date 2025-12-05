# Input Variables
# https://www.terraform.io/language/values/variables

variable "admins" {
  description = "A set of users who are admins to add to the organization"
  type        = set(string)
}

variable "super_admins" {
  description = "A set of users who have operational permissions to add to the organization"
  type        = set(string)
}

variable "github_token" {
  description = "The GitHub token used for managing the organization"
  type        = string
  sensitive   = true
}

variable "members" {
  description = "A set of members to add to the organization"
  type        = set(string)
  default     = []
}

variable "designers" {
  description = "A set of designers to add to the organization"
  type        = set(string)
  default     = []
}

variable "repositories" {
  description = "Map of repositories to create"
  type = map(object({
    description                     = string
    allow_auto_merge                = optional(bool, false)
    allow_merge_commit              = optional(bool, false)
    allow_rebase_merge              = optional(bool, false)
    allow_squash_merge              = optional(bool, true)
    allow_update_branch             = optional(bool, true)
    delete_branch_on_merge          = optional(bool, true)
    has_discussions                 = optional(bool, true)
    has_downloads                   = optional(bool, true)
    homepage_url                    = optional(string, "")
    has_wiki                        = optional(bool, false)
    push_allowances                 = optional(list(string), [])
    required_status_checks_contexts = optional(list(string), [])
    is_template                     = optional(bool, false) # Is the repository a template repository
    topics                          = optional(list(string))
    visibility                      = optional(string, "public")
    is_django_commons_repo          = optional(bool, false)     # Do not create teams for repository
    admins                          = optional(set(string), []) # Members of the repository's admin and repository teams. Have admin permissions
    committers                      = optional(set(string), [])
    # Members of the repository's committers and repository teams. Have write permissions
    members = optional(set(string), []) # Members of the repository team. Have triage permissions

    # The following are valid combinations for the merge commit title and message: PR_TITLE and PR_BODY, PR_TITLE and BLANK, MERGE_MESAGE and PR_TITLE. (invalid_merge_commit_setting_combo)}]
    merge_commit_title          = optional(string, null)
    merge_commit_message        = optional(string, null)
    squash_merge_commit_title   = optional(string, null)
    squash_merge_commit_message = optional(string, null)

    # Pages settings
    pages = optional(object({
      source = optional(object({
        branch = string
        path   = optional(string, "")
      }), null)
      build_type = optional(string, "workflow") # legacy or workflow
      cname      = optional(string, "")
      html_url   = optional(string, "")
      url        = optional(string, "")
      custom_404 = optional(bool, null)
      status     = optional(string, "built") # built or building
    }), null)

    # Template of the repository
    template = optional(object({
      owner                = string
      repository           = string
      include_all_branches = bool
    }), null)
  }))
}

variable "organization_teams" {
  description = "Map of Django Commons organization teams to manage"
  type = map(object({
    description               = string
    maintainers               = optional(set(string), [])
    members                   = optional(set(string), [])
    permission                = optional(string, null)
    privacy                   = optional(string, "closed")
    review_request_delegation = optional(bool, false)
  }))
}

variable "organization_secrets" {
  description = "Map of secrets to add to the organization"
  type = map(object({
    description = string
    visibility  = string
  }))
}
