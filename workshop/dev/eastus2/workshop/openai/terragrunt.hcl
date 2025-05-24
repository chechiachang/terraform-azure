terraform {
  # https://github.com/Azure/terraform-azurerm-avm-res-cognitiveservices-account/pull/99
  #source = "git::https://github.com/Azure/terraform-azurerm-avm-res-cognitiveservices-account.git//?ref=v0.6.0"
  source = "git::https://github.com/asttle-sigtech/terraform-azurerm-avm-res-cognitiveservices-account.git//?ref=patch-1"
}

include {
  path = find_in_parent_folders()
}

locals {
  rai_policy_name = "high-severity-filter-202504"
}

inputs = {
  kind     = "OpenAI"
  location = "eastus2"

  name     = "chechia-workshop"
  sku_name = "S0"

  cognitive_deployments = {
    "gpt-41" = {
      name = "gpt-4.1"
      model = {
        format  = "OpenAI"
        name    = "gpt-4.1"
        version = "2025-04-14"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 600
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-41-mini" = {
      name = "gpt-4.1-mini"
      model = {
        format  = "OpenAI"
        name    = "gpt-4.1-mini"
        version = "2025-04-14"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 1000
      }
      rai_policy_name = local.rai_policy_name
    },
    "text-embedding-3-large" = {
      name = "text-embedding-3-large"
      model = {
        format  = "OpenAI"
        name    = "text-embedding-3-large"
        version = "1"
      }
      scale = {
        type     = "Standard"
        capacity = 340
      }
      rai_policy_name = local.rai_policy_name
    }
  }

  custom_subdomain_name = "chechia-workshop"

  # content filters
  rai_policies = {
    high202504 = {
      name             = local.rai_policy_name
      base_policy_name = "Microsoft.Default"
      mode             = "Asynchronous_filter"
      content_filters = [
        # Inputs
        { name = "Hate", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Sexual", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Selfharm", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Violence", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        # Ouputs
        { name = "Hate", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Sexual", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Selfharm", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Violence", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
      ]
    }
  }

  enable_telemetry = false
}

