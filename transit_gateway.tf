resource "aws_ec2_transit_gateway" "this" {
  description                     = var.tgw_description
  amazon_side_asn                 = var.tgw_asn
  auto_accept_shared_attachments  = var.tgw_auto_accept_shared_attachments ? "enable" : "disable"
  default_route_table_association = var.tgw_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.tgw_default_route_table_propagation ? "enable" : "disable"
  dns_support                     = var.tgw_dns_support ? "enable" : "disable"
  multicast_support               = var.tgw_multicast_support ? "enable" : "disable"
  transit_gateway_cidr_blocks     = var.tgw_transit_gateway_cidr_blocks
  vpn_ecmp_support                = var.tgw_vpn_ecmp_support ? "enable" : "disable"

  tags = merge(var.tags, var.tgw_tags, {
    Name = var.tgw_name
  })
}
