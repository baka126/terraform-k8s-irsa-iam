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
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.example](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_owner"></a> [owner](#input\_owner) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | Name to be used on all the resources as identifier | `string` | `"teraform_modules"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region be used for all the resources | `string` | `"us-east-1"` | no |
| <a name="input_silo"></a> [silo](#input\_silo) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_terraform"></a> [terraform](#input\_terraform) | Name to be used on all the resources as identifier | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->
