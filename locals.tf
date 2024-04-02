// IPAM specific locals
locals {
  // Whether to enable IPAM
  enable_ipam = length(local.config_l0) > 0 ? 1 : 0

  // If no regions are specified, use current
  ipam_regions = coalesce(var.ipam_regions, [
    data.aws_region.current.name,
  ])

  // Root level normalised pool
  config_l0 = {
    for k, v in var.ipam_ipv4_root_pools :
    k => merge(v, {
      // Use key as description if none explicitly set
      description = coalesce(v.description, k)
    })
  }

  // Regional level normalised pool
  config_l1 = {
    for k, v in var.ipam_ipv4_regional_pools :
    k => merge(v, {
      // Use key as description if none explicitly set
      description = join("/", [
        local.config_l0[v.parent].description,
        coalesce(v.description, k),
      ])

      // Set the locale to the parent locale by default
      locale = coalesce(local.config_l0[v.parent].locale, v.locale, "")
    })
  }

  // organisational until level normalised pool
  config_l2 = {
    for k, v in var.ipam_ipv4_ou_pools :
    k => merge(v, {
      // Use key as description if none explicitly set
      description = join("/", [
        local.config_l1[v.parent].description,
        coalesce(v.description, k),
      ])

      // Set the locale to the parent locale by default
      locale = coalesce(local.config_l1[v.parent].locale, v.locale, "")
    })
  }
}

// Transit gateway specific locals
locals {

}
