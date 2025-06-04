################################################################################
# Argument Reference for the resources
################################################################################

variable "region" {
  description = "Region be used for all the resources"
  type        = string
  default     = "us-east-1"
}

variable "create_role" {
  description = "Whether to create the IAM role and associated policies. If false, no resources will be created by this module."
  type        = bool
  default     = true
}

variable "role_name" {
  description = "The desired name for the IAM role."
  type        = string
}

variable "kubernetes_namespace" {
  description = "The Kubernetes namespace of the service account."
  type        = string
}

variable "kubernetes_service_account_name" {
  description = "The name of the Kubernetes service account."
  type        = string
}

variable "eks_oidc_provider_url" {
  description = "The OIDC provider URL of your EKS cluster (e.g., 'oidc.eks.YOUR_REGION.amazonaws.com/id/YOUR_EKS_CLUSTER_ID'). Do not include 'https://' or the leading 'arn:aws:iam::ACCOUNT_ID:oidc-provider/'."
  type        = string
}

variable "aws_account_id" {
  description = "Your AWS Account ID. If not provided, it will be fetched automatically."
  type        = string
  default     = null # Will use data.aws_caller_identity.current.account_id if null
}

variable "add_oidc_aud_condition" {
  description = "Whether to add the ':aud' condition (checking for 'sts.amazonaws.com') to the OIDC trust policy. Recommended for EKS."
  type        = bool
  default     = true
}

variable "role_description" {
  description = "A description for the IAM role."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the IAM role."
  type        = map(string)
  default     = {}
}

# Option 1: Inline Policy
variable "inline_policy_name" {
  description = "The name for the inline policy. Required if 'inline_policy_document_json' is provided and create_role is true."
  type        = string
  default     = null
}

variable "inline_policy_document_json" {
  description = "A valid IAM policy document as a JSON string to be embedded as an inline policy."
  type        = string
  default     = null
}

# Option 2: Existing Managed Policies
variable "existing_policy_attachments_map" {
  description = "A map of existing IAM managed policy ARNs to attach to the role. Keys are arbitrary static identifiers, values are the policy ARNs."
  type        = map(string)
  default     = {}
}
