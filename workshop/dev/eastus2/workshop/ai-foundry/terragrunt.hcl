terraform {
  source = "${get_repo_root()}/modules/ai_foundry"
}

include {
  path = find_in_parent_folders()
}

locals {
  account_name    = "chechia-ws"
  rai_policy_name = "high-severity-filter-202504"
}

inputs = {
  name                = local.account_name
  location            = "eastus2"
  resource_group_name = "workshop"
  kind                = "AIServices"
  sku_name            = "S0"

  custom_subdomain_name      = local.account_name
  dynamic_throttling_enabled = false

  account_identity = {
    type = "SystemAssigned"
  }

  project_management_enabled = true
  projects                   = {}

  cognitive_deployments = {
    "gpt-5.4-nano" = {
      name = "gpt-5.4-nano"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.4-nano"
        version = "2026-03-17"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 400
        #capacity = 149000
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
  }

  rai_policies = {
    high202504 = {
      name             = local.rai_policy_name
      base_policy_name = "Microsoft.Default"
      mode             = "Asynchronous_filter"
      content_filters = [
        { name = "Hate", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Sexual", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Selfharm", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Violence", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Hate", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Sexual", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Selfharm", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Violence", filter_enabled = true, block_enabled = true, severity_threshold = "High", source = "Completion" }
      ]
    }
  }
}
