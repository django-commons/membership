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

# Apply roles — one per repo, scoped to pushes to main only
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
      values   = ["repo:${each.value.org}/${each.value.repo}:ref:refs/heads/main"]
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

# Plan roles — one per repo, scoped to pull requests, read-only state access
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
      values   = ["repo:${each.value.org}/${each.value.repo}:pull_request"]
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
