![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS IPAM

## Description

This module creates an AWS IAPM configuration, IPv4 pools and optionally shares them via AWS Resource Access Manager (RAM).

## Usage

Add example usage here

```hcl
module "example" {
  source  = "appvia/ipam/aws"
  version = "1.0.0"

  name        = "core"
  description = "Core IPAM network"

  # List of operating regions for this IPAM
  regions = [
    "eu-west-2",
  ]

  # Configure root IPAM pools
  ipv4_root_pools = {
    core = {
      cidr        = "10.0.0.0/8"
      description = "Core network IPv4 allocation pool"
    }
  }

  # Configure region IPAM pools
  ipv4_regional_pools = {
    eu-west-2 = {
      parent         = "core"
      netmask_length = 8
      locale         = "eu-west-2"
    }
  }

  # Configure workload level IPAM pools
  ipv4_ou_pools = {
    production = {
      parent      = "eu-west-2"
      cidr        = "10.0.0.0/16"
      description = "Production"

      ram_share_principals = [
        "arn:aws:organizations::012345678910:organization/o-skf6elds82",
      ]
    }
  }
}
```

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.ipam_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.ipam_regional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.ipam_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.ipam_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.ipam_regional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.ipam_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.ipam_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.ipam_regional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.ipam_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_vpc_ipam.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam) | resource |
| [aws_vpc_ipam_pool.ipv4_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool.ipv4_regional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool.ipv4_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool_cidr.ipv4_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_vpc_ipam_pool_cidr.ipv4_regional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_vpc_ipam_pool_cidr.ipv4_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the IPAM configuration | `string` | `null` | no |
| <a name="input_ipv4_ou_pools"></a> [ipv4\_ou\_pools](#input\_ipv4\_ou\_pools) | Organisational unit level IPv4 IPAM pools | <pre>map(object({<br>    parent                            = string<br>    cidr                              = optional(string)<br>    netmask_length                    = optional(number)<br>    description                       = optional(string)<br>    allocation_default_netmask_length = optional(number)<br>    allocation_max_netmask_length     = optional(number)<br>    allocation_min_netmask_length     = optional(number)<br>    allocation_resource_tags          = optional(map(string))<br>    auto_import                       = optional(bool, true)<br>    locale                            = optional(string)<br>    tags                              = optional(map(string), {})<br>    ram_share_principals              = optional(list(string), [])<br>  }))</pre> | `{}` | no |
| <a name="input_ipv4_regional_pools"></a> [ipv4\_regional\_pools](#input\_ipv4\_regional\_pools) | Regional level IPv4 IPAM pools | <pre>map(object({<br>    parent                            = string<br>    cidr                              = optional(string)<br>    netmask_length                    = optional(number)<br>    description                       = optional(string)<br>    allocation_default_netmask_length = optional(number)<br>    allocation_max_netmask_length     = optional(number)<br>    allocation_min_netmask_length     = optional(number)<br>    allocation_resource_tags          = optional(map(string))<br>    auto_import                       = optional(bool, true)<br>    locale                            = optional(string)<br>    tags                              = optional(map(string), {})<br>    ram_share_principals              = optional(list(string), [])<br>  }))</pre> | `{}` | no |
| <a name="input_ipv4_root_pools"></a> [ipv4\_root\_pools](#input\_ipv4\_root\_pools) | Top level IPv4 IPAM pools | <pre>map(object({<br>    cidr                              = optional(string)<br>    description                       = optional(string)<br>    allocation_default_netmask_length = optional(number)<br>    allocation_max_netmask_length     = optional(number)<br>    allocation_min_netmask_length     = optional(number)<br>    allocation_resource_tags          = optional(map(string))<br>    auto_import                       = optional(bool, true)<br>    locale                            = optional(string)<br>    tags                              = optional(map(string), {})<br>    ram_share_principals              = optional(list(string), [])<br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the IPAM configuration | `string` | `null` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | List of regions the IPAM will operate in | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the VPC IPAM |
| <a name="output_ou_pools"></a> [ou\_pools](#output\_ou\_pools) | Map of OU IPAM pools |
| <a name="output_ou_shares"></a> [ou\_shares](#output\_ou\_shares) | Map of RAM shares for OU IPAM pools |
| <a name="output_regional_pools"></a> [regional\_pools](#output\_regional\_pools) | Map of regional IPAM pools |
| <a name="output_regional_shares"></a> [regional\_shares](#output\_regional\_shares) | Map of RAM shares for regional IPAM pools |
| <a name="output_root_pools"></a> [root\_pools](#output\_root\_pools) | Map of root IPAM pools |
| <a name="output_root_shares"></a> [root\_shares](#output\_root\_shares) | Map of RAM shares for root IPAM pools |
<!-- END_TF_DOCS -->
