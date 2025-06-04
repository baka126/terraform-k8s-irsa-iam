################################################################################
# Defines the Attribute Reference created infrastructure
################################################################################

output "role_arn" {
  description = "The ARN of the created IAM role. Returns null if 'create_role' is false."
  value       = module.this.iam_role_arn

}
