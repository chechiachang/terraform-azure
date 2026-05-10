terraform {
  source = "${get_repo_root()}/modules/openai_monitoring_aca"
}

include {
  path = find_in_parent_folders()
}

locals {
  grafana_allowed_cidrs = compact(split(",", get_env("GRAFANA_CLOUD_IP_RANGES", "")))
}

inputs = {
  name                           = "national-openai-monitoring"
  container_app_environment_name = "national-openai-monitoring-env"
  container_app_name             = "national-openai-monitoring-bbx"
  location                       = "eastus2"
  resource_group_name            = "cc"

  openai_api_key = get_env("AZURE_OPENAI_API_KEY")
  # Add one target per model deployment defined in:
  # cc/dev/eastus2/national/ai-foundry/terragrunt.hcl
  openai_targets = [
    "https://national-team.openai.azure.com/openai/deployments/gpt-5.5/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/text-embedding-3-small/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-4.1/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-5-mini/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-5-nano/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-5.1-codex-mini/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-5.3-codex/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-5.4/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-5.4-nano/chat/completions?api-version=2024-05-01-preview",
    "https://national-team.openai.azure.com/openai/deployments/gpt-5.4-mini/chat/completions?api-version=2024-05-01-preview"
  ]

  grafana_allowed_cidrs = local.grafana_allowed_cidrs

  environment = "dev"
  project     = "openai-monitoring"
  tags = {
    ManagedBy = "terraform"
  }

  enable_managed_identity = false
}
