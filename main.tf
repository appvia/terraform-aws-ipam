
## Privision an IPAM with a root pool, regional pools, and organizational unit pools
resource "aws_vpc_ipam" "this" {
  description = coalesce(var.description, format("IPAM with primary in %s", data.aws_region.current.name))

  dynamic "operating_regions" {
    for_each = local.ipam_regions

    content {
      region_name = operating_regions.value
    }
  }

  tags = merge(var.tags, {
    Name = coalesce(var.name, data.aws_region.current.name)
  })
}

## Define the IPAM root
resource "aws_vpc_ipam_pool" "ipv4_root" {
  for_each = local.config_l0

  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.this.private_default_scope_id

  description                       = each.value.description
  allocation_default_netmask_length = each.value.allocation_default_netmask_length
  allocation_max_netmask_length     = each.value.allocation_max_netmask_length
  allocation_min_netmask_length     = each.value.allocation_min_netmask_length
  allocation_resource_tags          = each.value.allocation_resource_tags
  locale                            = each.value.locale
  auto_import                       = each.value.auto_import
}

resource "aws_vpc_ipam_pool_cidr" "ipv4_root" {
  for_each = local.config_l0

  ipam_pool_id = aws_vpc_ipam_pool.ipv4_root[each.key].id
  cidr         = each.value.cidr
}

resource "aws_vpc_ipam_pool" "ipv4_regional" {
  for_each = local.config_l1

  address_family      = "ipv4"
  ipam_scope_id       = aws_vpc_ipam.this.private_default_scope_id
  source_ipam_pool_id = aws_vpc_ipam_pool.ipv4_root[each.value.parent].id

  description                       = each.value.description
  allocation_default_netmask_length = each.value.allocation_default_netmask_length
  allocation_max_netmask_length     = each.value.allocation_max_netmask_length
  allocation_min_netmask_length     = each.value.allocation_min_netmask_length
  allocation_resource_tags          = each.value.allocation_resource_tags
  locale                            = each.value.locale
  auto_import                       = each.value.auto_import
}

resource "aws_vpc_ipam_pool_cidr" "ipv4_regional" {
  for_each = local.config_l1

  ipam_pool_id   = aws_vpc_ipam_pool.ipv4_regional[each.key].id
  cidr           = each.value.cidr
  netmask_length = each.value.netmask_length
}

resource "aws_vpc_ipam_pool" "ipv4_ou" {
  for_each = local.config_l2

  address_family      = "ipv4"
  ipam_scope_id       = aws_vpc_ipam.this.private_default_scope_id
  source_ipam_pool_id = aws_vpc_ipam_pool.ipv4_regional[each.value.parent].id

  description                       = each.value.description
  allocation_default_netmask_length = each.value.allocation_default_netmask_length
  allocation_max_netmask_length     = each.value.allocation_max_netmask_length
  allocation_min_netmask_length     = each.value.allocation_min_netmask_length
  allocation_resource_tags          = each.value.allocation_resource_tags
  locale                            = each.value.locale
  auto_import                       = each.value.auto_import
}

resource "aws_vpc_ipam_pool_cidr" "ipv4_ou" {
  for_each = local.config_l2

  ipam_pool_id   = aws_vpc_ipam_pool.ipv4_ou[each.key].id
  cidr           = each.value.cidr
  netmask_length = each.value.netmask_length
}
