variable "ipam_name" {
  type    = string
  default = null
}

variable "ipam_description" {
  type    = string
  default = null
}

variable "ipam_regions" {
  type    = list(string)
  default = null
}

variable "ipam_ipv4_root_pools" {
  type = map(object({
    cidr                              = optional(string)
    description                       = optional(string)
    allocation_default_netmask_length = optional(number)
    allocation_max_netmask_length     = optional(number)
    allocation_min_netmask_length     = optional(number)
    allocation_resource_tags          = optional(map(string))
    auto_import                       = optional(bool, true)
    locale                            = optional(string)
    tags                              = optional(map(string), {})
    ram_share_principals              = optional(list(string), [])
  }))

  default     = {}
  description = "Top level IPv4 IPAM pools"
}

variable "ipam_ipv4_regional_pools" {
  type = map(object({
    parent                            = string
    cidr                              = optional(string)
    netmask_length                    = optional(number)
    description                       = optional(string)
    allocation_default_netmask_length = optional(number)
    allocation_max_netmask_length     = optional(number)
    allocation_min_netmask_length     = optional(number)
    allocation_resource_tags          = optional(map(string))
    auto_import                       = optional(bool, true)
    locale                            = optional(string)
    tags                              = optional(map(string), {})
    ram_share_principals              = optional(list(string), [])
  }))

  default     = {}
  description = "Regional level IPv4 IPAM pools"
}

variable "ipam_ipv4_ou_pools" {
  type = map(object({
    parent                            = string
    cidr                              = optional(string)
    netmask_length                    = optional(number)
    description                       = optional(string)
    allocation_default_netmask_length = optional(number)
    allocation_max_netmask_length     = optional(number)
    allocation_min_netmask_length     = optional(number)
    allocation_resource_tags          = optional(map(string))
    auto_import                       = optional(bool, true)
    locale                            = optional(string)
    tags                              = optional(map(string), {})
    ram_share_principals              = optional(list(string), [])
  }))

  default     = {}
  description = "Organisational unit level IPv4 IPAM pools"
}

variable "ipam_tags" {
  type    = map(string)
  default = {}
}

variable "tgw_name" {
  type = string
}

variable "tgw_description" {
  type = string
}

variable "tgw_asn" {
  type    = number
  default = null
}

variable "tgw_auto_accept_shared_attachments" {
  type    = bool
  default = false
}

variable "tgw_default_route_table_association" {
  type    = bool
  default = true
}

variable "tgw_default_route_table_propagation" {
  type    = bool
  default = true
}

variable "tgw_dns_support" {
  type    = bool
  default = true
}

variable "tgw_multicast_support" {
  type    = bool
  default = false
}

variable "tgw_transit_gateway_cidr_blocks" {
  type    = list(string)
  default = null
}

variable "tgw_vpn_ecmp_support" {
  type    = bool
  default = true
}

variable "tgw_tags" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
