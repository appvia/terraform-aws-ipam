
output "arn" {
  description = "ARN of the VPC IPAM"
  value       = aws_vpc_ipam.this.arn
}

output "root_pools" {
  description = "Map of root IPAM pools"
  value = {
    ipv4 = {
      for k, v in aws_vpc_ipam_pool.ipv4_root :
      k => {
        arn = v.arn
      }
    }
  }
}

output "root_shares" {
  description = "Map of RAM shares for root IPAM pools"
  value = {
    for k, v in aws_ram_resource_share.ipam_root :
    k => {
      arn = v.arn
    }
  }
}

output "regional_pools" {
  description = "Map of regional IPAM pools"
  value = {
    ipv4 = {
      for k, v in aws_vpc_ipam_pool.ipv4_regional :
      k => {
        arn = v.arn
      }
    }
  }
}

output "regional_shares" {
  description = "Map of RAM shares for regional IPAM pools"
  value = {
    for k, v in aws_ram_resource_share.ipam_regional :
    k => {
      arn = v.arn
    }
  }
}

output "ou_pools" {
  description = "Map of OU IPAM pools"
  value = {
    ipv4 = {
      for k, v in aws_vpc_ipam_pool.ipv4_ou :
      k => {
        arn = v.arn
      }
    }
  }
}

output "ou_shares" {
  description = "Map of RAM shares for OU IPAM pools"
  value = {
    for k, v in aws_ram_resource_share.ipam_ou :
    k => {
      arn = v.arn
    }
  }
}
