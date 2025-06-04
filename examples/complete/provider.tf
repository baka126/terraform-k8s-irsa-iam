################################################################################
# Defines the resources provider
################################################################################

provider "aws" {
  region = var.region
  # Default tags (Global tags) applies to all resources created by this provider
  default_tags {
    tags = {
      project   = var.project
      terraform = var.terraform
      silo      = var.silo
      owner     = var.owner
    }
  }
}
