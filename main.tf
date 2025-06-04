
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