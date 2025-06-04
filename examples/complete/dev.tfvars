################################################################################
# Defines the terraform initalization variables
################################################################################

region      = "us-east-1"
project     = "terraform_modules"
terraform   = true
environment = "dev"
silo        = "k8's"
owner       = "baka126"

name                            = "example-role"
kubernetes_namespace            = "default"
kubernetes_service_account_name = "example-service-account"
oidc_provider_url               = "https://oidc.eks.us-west-2.amazonaws.com/id/EXAMPLE"
