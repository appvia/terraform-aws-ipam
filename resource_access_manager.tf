/*
resource "aws_ram_resource_share" "ipam_root" {
  for_each = local.config_l0

  name                      = format("IPAM %s", replace(each.value.description, "/", "-"))
  allow_external_principals = false

  tags = merge(var.tags, {
    Name = format("IPAM Root %s", each.key)
  })
}

resource "aws_ram_resource_share" "ipam_regional" {
  for_each = local.config_l1

  name                      = format("IPAM %s", replace(each.value.description, "/", "-"))
  allow_external_principals = false

  tags = merge(var.tags, {
    Name = format("IPAM Regional %s", each.key)
  })
}

resource "aws_ram_resource_share" "ipam_ou" {
  for_each = local.config_l2

  name                      = format("IPAM %s", replace(each.value.description, "/", "-"))
  allow_external_principals = false

  tags = merge(var.tags, {
    Name = format("IPAM OU %s", each.key)
  })
}
*/

# resource "aws_ram_principal_association" "associations" {
#   for_each = var.ram_principals

#   principal          = each.value
#   resource_share_arn = module.tgw_eu_west_2.ram_resource_share_id
# }
