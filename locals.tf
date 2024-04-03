# IPAM specific locals
locals {
  # If no regions are specified, use current
  ipam_regions = coalesce(var.regions, [
    data.aws_region.current.name,
  ])

  # Root level normalised pool
  config_l0 = {
    for k, v in var.ipv4_root_pools :
    k => merge(v, {
      # Set the name to the map key
      name = k
      # Use key as description if none explicitly set
      description = coalesce(v.description, k)
    })
  }

  ram_l0 = merge([
    for k, v in local.config_l0 : {
      for p in v.ram_share_principals :
      md5(join("-", [k, p])) => {
        share     = k
        principal = p
      }
    }
  ]...)

  # Regional level normalised pool
  config_l1 = {
    for k, v in var.ipv4_regional_pools :
    k => merge(v, {
      # Join the name with the parent name
      name = join("-", [
        local.config_l0[v.parent].name,
        k
      ])

      # Use key as description if none explicitly set
      description = join("/", [
        local.config_l0[v.parent].description,
        coalesce(v.description, k),
      ])

      # Set the locale to the parent locale by default
      locale = coalesce(local.config_l0[v.parent].locale, v.locale, "")
    })
  }

  ram_l1 = merge([
    for k, v in local.config_l1 : {
      for p in v.ram_share_principals :
      md5(join("-", [k, p])) => {
        share     = k
        principal = p
      }
    }
  ]...)

  # organisational until level normalised pool
  config_l2 = {
    for k, v in var.ipv4_ou_pools :
    k => merge(v, {
      # Join the name with the parent name
      name = join("-", [
        local.config_l1[v.parent].name,
        k
      ])

      # Use key as description if none explicitly set
      description = join("/", [
        local.config_l1[v.parent].description,
        coalesce(v.description, k),
      ])

      # Set the locale to the parent locale by default
      locale = coalesce(local.config_l1[v.parent].locale, v.locale, "")
    })
  }

  ram_l2 = merge([
    for k, v in local.config_l2 : {
      for p in v.ram_share_principals :
      md5(join("-", [k, p])) => {
        share     = k
        principal = p
      }
    }
  ]...)
}
