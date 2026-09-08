GitHub Organization as OpenTofu
===============================

# Structure

## General OpenTofu structure:

- `variables.tf` - define variable types (classes?), notice there is `variable "repositories" {...` there which has a
  few variables marked as optional with default values. Why I chose to have `has_discussions`.
- `backend.tf` - define the remote state backend: the `django-commons-tofu-state` S3 bucket, with the
  `django-commons-tofu-state-lock` DynamoDB table providing state locking (see [the S3 backend
  documentation][4]). The bucket, lock table and the roles used to reach them are provisioned by the configuration in
  `aws/`, documented in `aws/README.md`.
- `locals.tf` - define local variables to be used in `main.tf`
- `main.tf` - build configuration based on instances values from `*.tfvars` (or, if not defined explicitly,
  then default value from `variables.tf`)
- `resources-*.tf` - define resources, like `github_repository`, `github_team`, etc.
- `tfstate.json.bak2026-09-08` - Copy of the state as it was before the move to S3, kept for reference only.
  OpenTofu does not read it. The live state is in S3 under `members/tfstate.json` and `repositories/tfstate.json`.

## members module:

- `org.tfvars` - Define organization members, designers, admins and super-admins as required by `variables.tf`.
  Example:
    ```hcl
    admins = [      
      "ryancheley", # ...
    ]

    members = [
      "cunla", # ...
    ]
    ```
- `members/*.tf` - define OpenTofu resources for organization members and organization teams.

## repositories module:

- `repositories.tfvars` - define repositories to be managed based on the definition of the `repositories` variable in
  `repositories/variables.tf`. Example (for a full repository definition, see the `# What changes can be made` section
  below):
    ```hcl
    repositories = {
      "repo-name" = {
        description = "repo description"
        admins = ["member1", "member2"]
        committers = ["member3"]
        members = ["member4", "member5"]
      }
     # ...
    }
    ```

- Note: some repository configuration is not extracted to be managed via `repositories.tfvars`, for example,
  whether a repository has issues enabled or not. These settings are enforced in `repositories/resources-repos.tf`
  directly under `resource "github_repository" "this" {...`.

# Why OpenTofu?

We can define our "desired/default" repository configuration, and within this configuration:

- What is enforced from day one (i.e., constant in `resource "github_repository" "this"`)
- What is recommended but can be changed by users (i.e., variable with a default value in `variables.tf` that can be
  updated in `*.tfvars`) => Note this can also help us review outliers, you can see all repos which have
  non-default values in the `*.tfvars` file
- What is determined by users (i.e., variables without default value, like `description`)
- What is not configured in the infra-as-code (currently, for example, repo-labels).

# What changes can be made

All changes should be made in `*.tfvars`:

- Add/Remove organization admins/members/designers by editing the `org.tfvars` file.
- Add/Remove/Update repositories by editing the `repositories.tfvars`. A repository can have the following variables:
    ```hcl
    repositories = {
      "repo-name" = {
        description = "repo description"
        homepage_url = "" # optional, default is ""
        allow_auto_merge = false # optional, default is false
        allow_merge_commit = false # optional, default is false
        allow_rebase_merge = false # optional, default is false
        allow_squash_merge = true # optional, default is true
        allow_update_branch = true # optional, default is true
        delete_branch_on_merge = true # optional, default is true
        has_discussions = true # optional, default is true
        has_wiki = false # optional, default is false
        is_template = false # optional, default is false
        push_allowances = []
        template = "" # optional, default is ""
        topics = []
        visibility = "public" # optional, default is "public"
        is_django_commons_repo = optional(bool, false) # Do not create teams for repository
        required_status_checks_contexts = [] # optional, default is []
        admins = [] # Members of the repository's admin and repository teams. Have admin permissions
        committers = [] # Members of the repository's committers and repository teams. Have write permissions
        members = [] # Members of the repository team. Have triage permissions
      }
     # ...
    }
    ```

# How to use locally

You might want to try new settings locally before applying them to the repository automation.
To do so, you can use the following steps:

1. Clone the repository.
2. Get AWS credentials for the account holding the state bucket. State lives in S3, so `tofu init` cannot run without
   them - see `aws/README.md` for the IAM Identity Center setup and how collaborators are granted access.
3. From the `terraform/{module}` directory, run `tofu init` (replace `{module}` with either `members` or
   `repositories`).
4. Create a github-token with the necessary permissions on the organization (see [permissions documentation][1]).
    - The `repo` permission for full control of private repositories.
    - The `admin:org` permission for full control of orgs and teams, read and write org projects
    - The `delete_repo` permission to delete repositories

5. Make changes to `org.tfvars`/`repositories.tfvars` to reflect the desired state (add/update users, repositories,
   teams, etc.)
6. Export the token, so it is not recorded in your shell history or in the process list:
   `export TF_VAR_github_token=...`
7. To see what changes between the current state of the GitHub organization and the plan, run one of:
    ```shell
    cd terraform/members      && tofu plan -var-file=../org.tfvars
    cd terraform/repositories && tofu plan -var-file=../repositories.tfvars
    ```
   Note that the var-file name does not follow the module name: the `members` module reads `org.tfvars`.
8. To apply the changes, run the same command with `apply` in place of `plan`.

# Integration with GitHub Actions

The repository is configured to run `tofu plan` on every new pull-request as well as an update to a pull-request
and list the expected changes as a comment on the pull-request.
Once the pull-request is merged to the `main` branch, `tofu apply` applies the changes to the GitHub organization.
The updated state is written to the S3 backend; it is no longer committed back to the `main` branch, which is what the
older `[AUTO]... state changes after apply` commits used to do.

To achieve this, the workflows use the `TERRAFORM_MANAGEMENT_GITHUB_TOKEN` secret to plan/apply OpenTofu changes, and
authenticate to AWS via OIDC using the role ARNs in the `AWS_PLAN_ROLE_ARN` and `AWS_APPLY_ROLE_ARN` secrets. The plan
role is read-only on the state; only the apply role can write it, and only on pushes to `main`.

The workflows also pin `OPENTOFU_VERSION`. A state file records the version that wrote it as a bare string, with no
indication of which tool it was, so without the pin the action can read an OpenTofu version out of the state, look for
a Terraform release of that number, and fail because no such release exists.

`TERRAFORM_MANAGEMENT_GITHUB_TOKEN` is a fine-grained personal access token with permissions the following permissions
required (see documentation [here][2]):

- The `repo` permission for full control of private repositories
- The `admin:org` permission for full control of orgs and teams, read and write org projects
- The `delete_repo` permission to delete repositories
- Additionally, the token should have permissions to write content to the repository (see, [here][3])

[1]: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps

[2]: https://docs.github.com/en/rest/authentication/permissions-required-for-fine-grained-personal-access-tokens

[3]: https://search.opentofu.org/provider/integrations/github/latest/docs/resources/repository

[4]: https://opentofu.org/docs/language/settings/backends/s3/
