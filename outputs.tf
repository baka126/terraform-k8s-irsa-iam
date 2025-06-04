################################################################################
# Defines the list of output for the created infrastructure
################################################################################
output "iam_role_arn" {
  description = "The ARN of the created IAM role. Returns null if 'create_role' is false."
  value       = var.create_role ? aws_iam_role.this[0].arn : null
}

output "iam_role_name" {
  description = "The Name of the created IAM role. Returns null if 'create_role' is false."
  value       = var.create_role ? aws_iam_role.this[0].name : null
}

output "iam_role_unique_id" {
  description = "The unique ID of the created IAM role. Returns null if 'create_role' is false."
  value       = var.create_role ? aws_iam_role.this[0].unique_id : null
}

output "attached_policy_info" {
  description = "Information about the attached policy/policies. Returns null if 'create_role' is false."
  value = var.create_role ? {
    inline_policy_name              = var.inline_policy_document_json != null ? var.inline_policy_name : null
    attached_managed_policy_details = { for k, v in var.existing_policy_attachments_map : k => v }
  } : null
}
