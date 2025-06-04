## Example Usages
```tf
module "this" {
  source = "baka126/terraform-k8s-irsa-iam"

  role_name                       = "example_name"
  kubernetes_namespace            = "default"
  kubernetes_service_account_name = "example_sa"
  eks_oidc_provider_url           = var.oidc_provider_url
  aws_account_id                  = data.aws_caller_identity.current.account_id
  role_description                = "IAM Role for Service Account"

  existing_policy_attachments_map = {
    example_policy = aws_iam_policy.this.arn
  }
  # existing_policy_arns is defaulted to [] by the module
}
```
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
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [null_resource.validation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.k8s_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_oidc_aud_condition"></a> [add\_oidc\_aud\_condition](#input\_add\_oidc\_aud\_condition) | Whether to add the ':aud' condition (checking for 'sts.amazonaws.com') to the OIDC trust policy. Recommended for EKS. | `bool` | `true` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | Your AWS Account ID. If not provided, it will be fetched automatically. | `string` | `null` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create the IAM role and associated policies. If false, no resources will be created by this module. | `bool` | `true` | no |
| <a name="input_eks_oidc_provider_url"></a> [eks\_oidc\_provider\_url](#input\_eks\_oidc\_provider\_url) | The OIDC provider URL of your EKS cluster (e.g., 'oidc.eks.YOUR\_REGION.amazonaws.com/id/YOUR\_EKS\_CLUSTER\_ID'). Do not include 'https://' or the leading 'arn:aws:iam::ACCOUNT\_ID:oidc-provider/'. | `string` | n/a | yes |
| <a name="input_existing_policy_attachments_map"></a> [existing\_policy\_attachments\_map](#input\_existing\_policy\_attachments\_map) | A map of existing IAM managed policy ARNs to attach to the role. Keys are arbitrary static identifiers, values are the policy ARNs. | `map(string)` | `{}` | no |
| <a name="input_inline_policy_document_json"></a> [inline\_policy\_document\_json](#input\_inline\_policy\_document\_json) | A valid IAM policy document as a JSON string to be embedded as an inline policy. | `string` | `null` | no |
| <a name="input_inline_policy_name"></a> [inline\_policy\_name](#input\_inline\_policy\_name) | The name for the inline policy. Required if 'inline\_policy\_document\_json' is provided and create\_role is true. | `string` | `null` | no |
| <a name="input_kubernetes_namespace"></a> [kubernetes\_namespace](#input\_kubernetes\_namespace) | The Kubernetes namespace of the service account. | `string` | n/a | yes |
| <a name="input_kubernetes_service_account_name"></a> [kubernetes\_service\_account\_name](#input\_kubernetes\_service\_account\_name) | The name of the Kubernetes service account. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region be used for all the resources | `string` | `"us-east-1"` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | A description for the IAM role. | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The desired name for the IAM role. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the IAM role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_attached_policy_info"></a> [attached\_policy\_info](#output\_attached\_policy\_info) | Information about the attached policy/policies. Returns null if 'create\_role' is false. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the created IAM role. Returns null if 'create\_role' is false. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The Name of the created IAM role. Returns null if 'create\_role' is false. |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | The unique ID of the created IAM role. Returns null if 'create\_role' is false. |
<!-- END_TF_DOCS -->
