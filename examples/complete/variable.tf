variable "name" {
  description = "The name of the resource"
  type        = string
}

variable "oidc_provider_url" {
  description = "The OIDC provider URL for the EKS cluster"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "kubernetes_namespace" {
  description = "The Kubernetes namespace where the service account will be created"
  type        = string
  default     = "default"
}

variable "kubernetes_service_account_name" {
  description = "The name of the Kubernetes service account to create"
  type        = string
}

variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "project" {
  description = "The project name for tagging resources"
  type        = string
  default     = "my-project"
}

variable "terraform" {
  description = "The Terraform version for tagging resources"
  type        = string
  default     = "1.0.0"
}

variable "silo" {
  description = "The silo for tagging resources"
  type        = string
  default     = "k8s"
}

variable "owner" {
  description = "The owner of the resources for tagging"
  type        = string
  default     = "baka126"
}
