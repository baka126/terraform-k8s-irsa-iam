<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS account ID | `string` | n/a | yes |
| <a name="input_kubernetes_namespace"></a> [kubernetes\_namespace](#input\_kubernetes\_namespace) | The Kubernetes namespace where the service account will be created | `string` | `"default"` | no |
| <a name="input_kubernetes_service_account_name"></a> [kubernetes\_service\_account\_name](#input\_kubernetes\_service\_account\_name) | The name of the Kubernetes service account to create | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource | `string` | n/a | yes |
| <a name="input_oidc_provider_url"></a> [oidc\_provider\_url](#input\_oidc\_provider\_url) | The OIDC provider URL for the EKS cluster | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the resources for tagging | `string` | `"baka126"` | no |
| <a name="input_project"></a> [project](#input\_project) | The project name for tagging resources | `string` | `"my-project"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the resources will be created | `string` | `"us-west-2"` | no |
| <a name="input_silo"></a> [silo](#input\_silo) | The silo for tagging resources | `string` | `"k8s"` | no |
| <a name="input_terraform"></a> [terraform](#input\_terraform) | The Terraform version for tagging resources | `string` | `"1.0.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->
