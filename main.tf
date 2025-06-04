
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id = var.aws_account_id == null ? data.aws_caller_identity.current.account_id : var.aws_account_id
  partition  = data.aws_partition.current.partition

  default_role_description = "IAM role for Kubernetes SA ${var.kubernetes_namespace}:${var.kubernetes_service_account_name}"
  role_description_final   = coalesce(var.role_description, local.default_role_description)

  should_create_inline_policy = var.create_role && var.inline_policy_document_json != null
}

resource "null_resource" "validation" {
  count = var.create_role ? 1 : 0

  lifecycle {
    precondition {
      condition     = !local.should_create_inline_policy || (local.should_create_inline_policy && var.inline_policy_name != null)
      error_message = "Configuration error: If 'inline_policy_document_json' is provided and 'create_role' is true, 'inline_policy_name' must also be specified."
    }
  }
}
data "aws_iam_policy_document" "k8s_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${var.eks_oidc_provider_url}"]
    }

    # :sub condition (Subject - the service account)
    condition {
      test     = "StringEquals"
      variable = "${var.eks_oidc_provider_url}:sub"
      values   = ["system:serviceaccount:${var.kubernetes_namespace}:${var.kubernetes_service_account_name}"]
    }

    # Conditional :aud condition (Audience - sts.amazonaws.com)
    dynamic "condition" {
      for_each = var.add_oidc_aud_condition ? [
        { # Using a list of one map to construct the dynamic block
          test     = "StringEquals"
          variable = "${var.eks_oidc_provider_url}:aud"
          values   = ["sts.amazonaws.com"] # Standard audience for EKS IRSA
        }
      ] : [] # Empty list if condition should not be added

      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}
resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.k8s_assume_role_policy.json
  description        = local.role_description_final
  tags               = var.tags

  depends_on = [null_resource.validation]
}

resource "aws_iam_role_policy" "this" {
  count = local.should_create_inline_policy ? 1 : 0

  name   = var.inline_policy_name
  role   = aws_iam_role.this[0].id
  policy = var.inline_policy_document_json
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.create_role ? var.existing_policy_attachments_map : {}

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}
