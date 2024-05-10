resource "aws_ram_resource_share" "ipam_root" {
  for_each = {
    for k, v in local.config_l0 :
    k => v if length(v.ram_share_principals) > 0
  }

  name                      = format("ipam-%s", lower(each.value.name))
  allow_external_principals = false

  tags = merge(var.tags, {
    Name = format("IPAM Root %s", each.key)
  })
}

resource "aws_ram_resource_association" "ipam_root" {
  for_each = {
    for k, v in local.config_l0 :
    k => v if length(v.ram_share_principals) > 0
  }

  resource_share_arn = aws_ram_resource_share.ipam_root[each.key].arn
  resource_arn       = aws_vpc_ipam_pool.ipv4_root[each.key].arn
}

resource "aws_ram_principal_association" "ipam_root" {
  for_each = local.ram_l0

  principal          = each.value.principal
  resource_share_arn = aws_ram_resource_share.ipam_root[each.value.share].arn
}

resource "aws_ram_resource_share" "ipam_regional" {
  for_each = {
    for k, v in local.config_l1 :
    k => v if length(v.ram_share_principals) > 0
  }

  name                      = format("ipam-%s", lower(each.value.name))
  allow_external_principals = false

  tags = merge(var.tags, {
    Name = format("IPAM Regional %s", each.key)
  })
}

resource "aws_ram_resource_association" "ipam_regional" {
  for_each = {
    for k, v in local.config_l1 :
    k => v if length(v.ram_share_principals) > 0
  }

  resource_share_arn = aws_ram_resource_share.ipam_regional[each.key].arn
  resource_arn       = aws_vpc_ipam_pool.ipv4_regional[each.key].arn
}

resource "aws_ram_principal_association" "ipam_regional" {
  for_each = local.ram_l1

  principal          = each.value.principal
  resource_share_arn = aws_ram_resource_share.ipam_regional[each.value.share].arn
}

resource "aws_ram_resource_share" "ipam_ou" {
  for_each = {
    for k, v in local.config_l2 :
    k => v if length(v.ram_share_principals) > 0
  }

  name                      = format("ipam-%s", lower(each.value.name))
  allow_external_principals = false

  tags = merge(var.tags, {
    Name = format("IPAM OU %s", each.key)
  })
}

resource "aws_ram_resource_association" "ipam_ou" {
  for_each = {
    for k, v in local.config_l2 :
    k => v if length(v.ram_share_principals) > 0
  }

  resource_share_arn = aws_ram_resource_share.ipam_ou[each.key].arn
  resource_arn       = aws_vpc_ipam_pool.ipv4_ou[each.key].arn
}

resource "aws_ram_principal_association" "ipam_ou" {
  for_each = local.ram_l2

  principal          = each.value.principal
  resource_share_arn = aws_ram_resource_share.ipam_ou[each.value.share].arn
}
