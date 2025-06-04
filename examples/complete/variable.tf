################################################################################
# Argument Reference for the resources
################################################################################

variable "region" {
  description = "Region be used for all the resources"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "teraform_modules"
}

variable "terraform" {
  description = "Name to be used on all the resources as identifier"
  type        = bool
  default     = true
}


variable "owner" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "silo" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}
