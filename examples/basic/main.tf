module "ipam_core" {
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
    operations = {
      parent      = "eu-west-2"
      cidr        = "10.0.0.0/16"
      description = "Operations"

      ram_share_principals = [
        "arn:aws:organizations::012345678910:organization/o-skf6elds82",
      ]
    }

    sandbox = {
      parent      = "eu-west-2"
      cidr        = "10.1.0.0/16"
      description = "Sandbox"

      ram_share_principals = [
        "arn:aws:organizations::012345678910:organization/o-vks92kduav",
      ]
    }

    development = {
      parent      = "eu-west-2"
      cidr        = "10.2.0.0/15"
      description = "Development"

      ram_share_principals = [
        "arn:aws:organizations::012345678910:organization/o-alqof7w9vj",
      ]
    }

    staging = {
      parent      = "eu-west-2"
      cidr        = "10.4.0.0/14"
      description = "Staging"

      ram_share_principals = [
        "arn:aws:organizations::012345678910:organization/o-apdb3c87vp",
      ]
    }

    production = {
      parent      = "eu-west-2"
      cidr        = "10.8.0.0/14"
      description = "Production"

      ram_share_principals = [
        "arn:aws:organizations::012345678910:organization/o-pqlvysh6a1",
      ]
    }
  }
}
