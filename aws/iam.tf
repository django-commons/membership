resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

locals {
  github_repos = {
    production = {
      org  = "django-commons"
      repo = "membership"
    }
    test = {
      org  = "django-commons-test"
      repo = "membership"
    }
  }
}

# Apply roles — one per repo, scoped to pushes to main only.
# Both sub and ref conditions are required. When a workflow job specifies
# `environment`, GitHub sets sub to `repo:org/repo:environment:<name>` rather
# than the branch or event, so sub alone can't distinguish a PR from a push.
# The ref condition closes that gap: a PR-triggered job will never have
# refs/heads/main as its ref, so a malicious PR cannot assume the apply role
# even if it were modified to reference AWS_APPLY_ROLE_ARN.
data "aws_iam_policy_document" "github_actions_apply_assume_role" {
  for_each = local.github_repos

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${each.value.org}/${each.value.repo}:environment:production"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:ref"
      values   = ["refs/heads/main"]
    }
  }
}

resource "aws_iam_role" "github_actions_apply" {
  for_each           = local.github_repos
  name               = "${each.value.org}-github-actions-apply"
  assume_role_policy = data.aws_iam_policy_document.github_actions_apply_assume_role[each.key].json
}

data "aws_iam_policy_document" "terraform_state_access" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.terraform_state.arn}/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.terraform_state.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem", "dynamodb:DescribeTable"]
    resources = [aws_dynamodb_table.terraform_state_lock.arn]
  }
}

resource "aws_iam_role_policy" "github_actions_apply" {
  for_each = local.github_repos
  name     = "terraform-state-access"
  role     = aws_iam_role.github_actions_apply[each.key].id
  policy   = data.aws_iam_policy_document.terraform_state_access.json
}

# Plan roles — one per repo, read-only state access for pull requests.
# sub is sufficient here since the plan role only grants read access to state.
data "aws_iam_policy_document" "github_actions_plan_assume_role" {
  for_each = local.github_repos

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${each.value.org}/${each.value.repo}:environment:production"]
    }
  }
}

resource "aws_iam_role" "github_actions_plan" {
  for_each           = local.github_repos
  name               = "${each.value.org}-github-actions-plan"
  assume_role_policy = data.aws_iam_policy_document.github_actions_plan_assume_role[each.key].json
}

data "aws_iam_policy_document" "terraform_state_read" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.terraform_state.arn}/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.terraform_state.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem", "dynamodb:DescribeTable"]
    resources = [aws_dynamodb_table.terraform_state_lock.arn]
  }
}

resource "aws_iam_role_policy" "github_actions_plan" {
  for_each = local.github_repos
  name     = "terraform-state-read"
  role     = aws_iam_role.github_actions_plan[each.key].id
  policy   = data.aws_iam_policy_document.terraform_state_read.json
}
