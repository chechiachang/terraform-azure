terraform {
  source = "${get_repo_root()}/modules/ai_foundry"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  account_name    = "national-team-westus"
  rai_policy_name = "high-severity-filter-202504"
}

inputs = {
  name                = local.account_name
  location            = "westus"
  resource_group_name = "cc"
  kind                = "AIServices"
  sku_name            = "S0"

  custom_subdomain_name      = local.account_name
  dynamic_throttling_enabled = false

  account_identity = {
    type = "SystemAssigned"
  }

  project_management_enabled = true
  projects                   = {}

  # Independent West US stack; leave both East US stacks and their state unchanged.
  # GlobalStandard/capacity 10000 aligns with the East US 2 GPT-6 family.
  # Global routing does not guarantee inference in West US or lower latency.
  # Confirm model access, quota, available capacity, and Decisions rollout before applying.
  # https://learn.microsoft.com/en-us/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure-region-availability
  cognitive_deployments = {
    "gpt-6.1-terra" = {
      name = "gpt-6.1-terra"
      model = {
        format  = "OpenAI"
        name    = "gpt-6.1-terra"
        version = "2026-10-26"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 10000
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-6.1-sol" = {
      name = "gpt-6.1-sol"
      model = {
        format  = "OpenAI"
        name    = "gpt-6.1-sol"
        version = "2026-09-29"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 10000
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    # Azure OpenAI Decisions API: POST /openai/v1/decisions.
    # It currently supports gpt-6-luna only; pass this deployment name as model.
    # https://learn.microsoft.com/en-us/azure/foundry/openai/how-to/decisions
    "gpt-6-luna" = {
      name = "gpt-6-luna"
      model = {
        format  = "OpenAI"
        name    = "gpt-6-luna"
        version = "2026-09-22"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 10000
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
