output "arn" {
  value       = aws_vpc_ipam.this.arn
  description = "ARN of the VPC IPAM"
}

output "root_pools" {
  value = {
    ipv4 = {
      for k, v in aws_vpc_ipam_pool.ipv4_root :
      k => {
        arn = v.arn
      }
    }
  }

  description = "Map of root IPAM pools"
}

output "root_shares" {
  value = {
    for k, v in aws_ram_resource_share.ipam_root :
    k => {
      arn = v.arn
    }
  }

  description = "Map of RAM shares for root IPAM pools"
}

output "regional_pools" {
  value = {
    ipv4 = {
      for k, v in aws_vpc_ipam_pool.ipv4_regional :
      k => {
        arn = v.arn
      }
    }
  }

  description = "Map of regional IPAM pools"
}

output "regional_shares" {
  value = {
    for k, v in aws_ram_resource_share.ipam_regional :
    k => {
      arn = v.arn
    }
  }

  description = "Map of RAM shares for regional IPAM pools"
}

output "ou_pools" {
  value = {
    ipv4 = {
      for k, v in aws_vpc_ipam_pool.ipv4_ou :
      k => {
        arn = v.arn
      }
    }
  }

  description = "Map of OU IPAM pools"
}

output "ou_shares" {
  value = {
    for k, v in aws_ram_resource_share.ipam_ou :
    k => {
      arn = v.arn
    }
  }

  description = "Map of RAM shares for OU IPAM pools"
}
