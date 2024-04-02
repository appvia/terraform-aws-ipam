variable "name" {
  type    = string
  default = null
}

variable "description" {
  type    = string
  default = null
}

variable "regions" {
  type    = list(string)
  default = null
}

variable "ipv4_root_pools" {
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

variable "ipv4_regional_pools" {
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

variable "ipv4_ou_pools" {
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

variable "tags" {
  type    = map(string)
  default = {}
}
