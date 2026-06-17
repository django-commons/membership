# AWS Personal Account Infrastructure

This directory contains Terraform configuration for resources in a personal AWS account
that support the GitHub Actions workflows in this repository. It is checked in to document
the settings used — it is not applied automatically by CI.

## Owner

The account owner and AWS account ID are stored in 1Password:
`op://Django Commons Infrastructure/AWS Personal Account/`

## What this creates

| Resource | Name | Purpose |
|---|---|---|
| S3 bucket | `django-commons-terraform-state` | Stores Terraform state files for `members` and `repositories` workspaces |
| DynamoDB table | `django-commons-terraform-state-lock` | Provides state locking to prevent concurrent apply conflicts |
| IAM OIDC provider | `token.actions.githubusercontent.com` | Allows GitHub Actions to authenticate to AWS without stored credentials |
| IAM role | `django-commons-github-actions-apply` | Assumed by apply workflows in `django-commons/membership` on pushes to `main` |
| IAM role | `django-commons-github-actions-plan` | Assumed by plan workflows in `django-commons/membership` on pull requests |
| IAM role | `django-commons-test-github-actions-apply` | Assumed by apply workflows in `django-commons-test/membership` on pushes to `main` |
| IAM role | `django-commons-test-github-actions-plan` | Assumed by plan workflows in `django-commons-test/membership` on pull requests |
| IAM Identity Center permission set | `TerraformStateAccess` | Grants collaborators read/write access to state bucket and lock table |

## 1Password setup

Sensitive values are kept out of this repository using 1Password. You will need the
1Password CLI (`op`) installed and access to the **Django Commons Infrastructure** vault.

### Install the 1Password CLI

```bash
brew install 1password-cli
```

Then enable the CLI integration in the 1Password desktop app:
> 1Password → Settings → Developer → Connect with 1Password CLI

### Vault structure

Create a vault named **Django Commons Infrastructure** in 1Password, then add the following items.

**Item: `AWS Personal Account`**

1. New Item → Secure Note
2. Title: `AWS Personal Account`
3. Click **Add a field** → Text → label it `Account ID` → enter your 12-digit AWS account ID
4. Click **Add a field** → Text → label it `Owner` → enter your name
5. Save

**Item: one per collaborator**

Repeat for each person who needs AWS access, e.g.:

1. New Item → Secure Note
2. Title: `Ryan Cheley` — this must match the name used in `terraform.tfvars.tpl`
3. Click **Add a field** → Text → label it `email` → enter their email address
4. Save

The `op://` reference in the template resolves using the vault name, item title, and field
label — so all three must match exactly.

## Applying

### Prerequisites

1. **Enable IAM Identity Center** in the AWS Console before the first apply — this cannot be
   done via Terraform:
   > AWS Console → IAM Identity Center → Enable

2. AWS CLI configured with credentials for the personal account.

3. 1Password CLI signed in (`op signin`).

### Generate vars and apply

```bash
cd aws
terraform init
op inject -i terraform.tfvars.tpl -o terraform.tfvars
terraform apply
rm terraform.tfvars
```

The generated `terraform.tfvars` is gitignored and should be deleted after applying.

After applying, `terraform apply` outputs two maps — one for apply roles, one for plan roles,
each keyed by `production` and `test`. Add the role ARNs as secrets in each repository:

**`django-commons/membership`**
```
AWS_APPLY_ROLE_ARN = <github_actions_apply_role_arns.production>
AWS_PLAN_ROLE_ARN  = <github_actions_plan_role_arns.production>
```

**`django-commons-test/membership`**
```
AWS_APPLY_ROLE_ARN = <github_actions_apply_role_arns.test>
AWS_PLAN_ROLE_ARN  = <github_actions_plan_role_arns.test>
```

## Test repository setup

`django-commons-test/membership` needs the same workflow files as this repository and the
following backend configs (note the `test/` key prefix — this is what separates test state
from production state in the shared bucket):

**`terraform/members/backend.tf`**
```hcl
terraform {
  backend "s3" {
    bucket         = "django-commons-terraform-state"
    key            = "test/members/tfstate.json"
    region         = "us-east-1"
    dynamodb_table = "django-commons-terraform-state-lock"
    encrypt        = true
  }
}
```

**`terraform/repositories/backend.tf`**
```hcl
terraform {
  backend "s3" {
    bucket         = "django-commons-terraform-state"
    key            = "test/repositories/tfstate.json"
    region         = "us-east-1"
    dynamodb_table = "django-commons-terraform-state-lock"
    encrypt        = true
  }
}
```

## Adding a collaborator

1. Create a Login item in the **Django Commons Infrastructure** vault with the person's
   email address (see vault structure above).

2. Add a block to `terraform.tfvars.tpl`:

```hcl
{
  username     = "ryancheley"
  display_name = "Ryan Cheley"
  given_name   = "Ryan"
  family_name  = "Cheley"
  email        = "op://Django Commons Infrastructure/Ryan Cheley/email"
},
```

3. Apply:

```bash
op inject -i terraform.tfvars.tpl -o terraform.tfvars
terraform apply
rm terraform.tfvars
```

AWS emails the collaborator a temporary password. They sign in at the URL shown in the
`sso_start_url` output, reset their password, and then have access to the state bucket
and lock table via the AWS CLI or console.

## Notes

- **S3 versioning** is enabled. Previous state versions are retained and can be used to
  recover from a corrupted or accidentally deleted state file.
- **OIDC provider**: If `token.actions.githubusercontent.com` already exists in your account
  (from another project), import it before applying:
  ```
  terraform import aws_iam_openid_connect_provider.github_actions <existing-provider-arn>
  ```
- The IAM role trust policies are scoped to `repo:django-commons/membership` only — they
  cannot be assumed by any other repository.
