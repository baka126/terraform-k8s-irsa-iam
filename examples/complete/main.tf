################################################################################
# Defines and manages the terraform resources
################################################################################
module "this" {
  source = "../../"

  role_name                       = var.name
  kubernetes_namespace            = var.kubernetes_namespace
  kubernetes_service_account_name = var.kubernetes_service_account_name
  eks_oidc_provider_url           = var.oidc_provider_url
  aws_account_id                  = data.aws_caller_identity.current.account_id
  role_description                = "IAM Role for Service Account"

  existing_policy_attachments_map = {
    example_policy = aws_iam_policy.this.arn
  }
  # existing_policy_arns is defaulted to [] by the module
}
