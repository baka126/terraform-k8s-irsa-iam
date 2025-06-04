
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id = var.aws_account_id == null ? data.aws_caller_identity.current.account_id : var.aws_account_id
  partition  = data.aws_partition.current.partition

  default_role_description = "IAM role for Kubernetes SA ${var.kubernetes_namespace}:${var.kubernetes_service_account_name}"
  role_description_final   = coalesce(var.role_description, local.default_role_description)

  should_create_inline_policy = var.create_role && var.inline_policy_document_json != null
}

