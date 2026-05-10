terraform {
  source = "${get_repo_root()}/modules/ai_foundry"
}

include {
  path = find_in_parent_folders()
}

locals {
  account_name    = "national-team"
  rai_policy_name = "high-severity-filter-202504"
}

inputs = {
  name                = local.account_name
  location            = "eastus2"
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

  # Keep model deployments here aligned with monitoring targets in:
  # cc/dev/eastus2/national/openai-monitoring-aca/terragrunt.hcl
  cognitive_deployments = {
    "gpt-5.5" = {
      name = "gpt-5.5"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.5"
        version = "2026-04-24"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 400
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "text-embedding-3-small" = {
      name = "text-embedding-3-small"
      model = {
        format  = "OpenAI"
        name    = "text-embedding-3-small"
        version = "1"
      }
      sku = {
        name     = "Standard"
        capacity = 350
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-41" = {
      name = "gpt-4.1"
      model = {
        format  = "OpenAI"
        name    = "gpt-4.1"
        version = "2025-04-14"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 400
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-5-mini" = {
      name = "gpt-5-mini"
      model = {
        format  = "OpenAI"
        name    = "gpt-5-mini"
        version = "2025-08-07"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 400
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-5-nano" = {
      name = "gpt-5-nano"
      model = {
        format  = "OpenAI"
        name    = "gpt-5-nano"
        version = "2025-08-07"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 400
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-5.1-codex-mini" = {
      name = "gpt-5.1-codex-mini"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.1-codex-mini"
        version = "2025-11-13"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 400
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-5.3-codex" = {
      name = "gpt-5.3-codex"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.3-codex"
        version = "2026-02-24"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 1005
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-5.4" = {
      name = "gpt-5.4"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.4"
        version = "2026-03-05"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 804
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
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
      }
      dynamic_throttling_enabled = false
      rai_policy_name            = local.rai_policy_name
    }
    "gpt-5.4-mini" = {
      name = "gpt-5.4-mini"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.4-mini"
        version = "2026-03-17"
      }
      sku = {
        name     = "GlobalStandard"
        capacity = 400
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
