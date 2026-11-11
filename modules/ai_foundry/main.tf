resource "azurerm_cognitive_account" "this" {
  name                               = var.name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  kind                               = var.kind
  sku_name                           = var.sku_name
  custom_subdomain_name              = var.custom_subdomain_name
  dynamic_throttling_enabled         = var.dynamic_throttling_enabled
  local_auth_enabled                 = var.local_auth_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted
  public_network_access_enabled      = var.public_network_access_enabled
  project_management_enabled         = var.project_management_enabled
  tags                               = var.tags

  dynamic "identity" {
    for_each = var.account_identity == null ? [] : [var.account_identity]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}

resource "azurerm_cognitive_account_rai_policy" "this" {
  for_each = var.rai_policies

  name                 = each.value.name
  cognitive_account_id = azurerm_cognitive_account.this.id
  base_policy_name     = each.value.base_policy_name
  mode                 = try(each.value.mode, null)

  dynamic "content_filter" {
    for_each = each.value.content_filters
    content {
      name               = content_filter.value.name
      filter_enabled     = content_filter.value.filter_enabled
      block_enabled      = content_filter.value.block_enabled
      severity_threshold = content_filter.value.severity_threshold
      source             = content_filter.value.source
    }
  }
}

resource "azurerm_cognitive_deployment" "this" {
  for_each = var.cognitive_deployments

  # Policy names are plain strings, so Terraform cannot infer this dependency.
  depends_on = [azurerm_cognitive_account_rai_policy.this]

  name                       = each.value.name
  cognitive_account_id       = azurerm_cognitive_account.this.id
  rai_policy_name            = try(each.value.rai_policy_name, null)
  version_upgrade_option     = try(each.value.version_upgrade_option, "OnceNewDefaultVersionAvailable")
  dynamic_throttling_enabled = try(each.value.dynamic_throttling_enabled, false)

  model {
    format  = each.value.model.format
    name    = each.value.model.name
    version = try(each.value.model.version, null)
  }

  sku {
    name     = each.value.sku.name
    capacity = try(each.value.sku.capacity, null)
    family   = try(each.value.sku.family, null)
    size     = try(each.value.sku.size, null)
    tier     = try(each.value.sku.tier, null)
  }
}

resource "azurerm_cognitive_account_project" "this" {
  for_each = var.projects

  name                 = each.value.name
  cognitive_account_id = azurerm_cognitive_account.this.id
  location             = each.value.location
  description          = try(each.value.description, null)
  display_name         = try(each.value.display_name, null)
  tags                 = try(each.value.tags, {})

  identity {
    type         = each.value.identity.type
    identity_ids = try(each.value.identity.identity_ids, [])
  }
}
