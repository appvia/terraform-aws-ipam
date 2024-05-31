mock_provider "aws" {}

run "basic" {
  command = plan

  variables {
    name        = "test"
    description = "test IPAM module instance"

    // List of operating regions for this IPAM
    regions = [
      "eu-west-1",
      "eu-west-2",
    ]

    // Configure root IPAM pools
    ipv4_root_pools = {
      core = {
        cidr        = "10.0.0.0/8"
        description = "Core network IPv4 allocation pool"
      }
    }

    // Configure region IPAM pools
    ipv4_regional_pools = {
      eu-west-1 = {
        parent         = "core"
        netmask_length = 15
        locale         = "eu-west-1"
      }

      eu-west-2 = {
        parent         = "core"
        netmask_length = 15
        locale         = "eu-west-2"
      }
    }

    // Configure workload level IPAM pools
    ipv4_ou_pools = {
      operations = {
        parent      = "eu-west-2"
        cidr        = "10.128.0.0/17"
        description = "Operations"

        ram_share_principals = [
          "arn:aws:organizations::009151033531:organization/o-l0pd2fg8bu",
        ]
      }

      development = {
        parent      = "eu-west-2"
        cidr        = "10.128.128.0/17"
        description = "Development"

        ram_share_principals = [
          "arn:aws:organizations::009151033531:organization/o-l0pd2fg8bu",
        ]
      }

      production = {
        parent      = "eu-west-2"
        cidr        = "10.129.0.0/18"
        description = "Production"

        ram_share_principals = [
          "arn:aws:organizations::009151033531:organization/o-l0pd2fg8bu",
        ]
      }

      sandbox = {
        parent      = "eu-west-2"
        cidr        = "10.129.64.0/18"
        description = "Sandbox"

        ram_share_principals = [
          "arn:aws:organizations::009151033531:organization/o-l0pd2fg8bu",
        ]
      }

      staging = {
        parent      = "eu-west-2"
        cidr        = "10.129.128.0/18"
        description = "Staging"

        ram_share_principals = [
          "arn:aws:organizations::009151033531:organization/o-l0pd2fg8bu",
        ]
      }
    }
  }
}
