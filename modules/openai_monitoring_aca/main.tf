locals {
  merged_tags = merge(
    var.tags,
    {
      for k, v in {
        Name        = var.name
        Environment = var.environment
        Project     = var.project
      } : k => v if v != null && trim(v) != ""
    }
  )

  blackbox_config_template = yamlencode({
    modules = {
      azure_openai_check = {
        prober  = "http"
        timeout = "10s"
        http = {
          method = "POST"
          headers = {
            "api-key"      = "__AZURE_OPENAI_API_KEY__"
            "Content-Type" = "application/json"
          }
          body               = "{\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}],\"max_tokens\":1}"
          valid_status_codes = [200]
        }
      }
    }
  })

  scrape_config_yaml = yamlencode({
    scrape_configs = [
      {
        job_name     = "azure_openai_models"
        metrics_path = "/probe"
        params = {
          module = ["azure_openai_check"]
        }
        static_configs = [
          {
            targets = var.openai_targets
          }
        ]
        relabel_configs = [
          {
            source_labels = ["__address__"]
            target_label  = "__param_target"
          },
          {
            source_labels = ["__param_target"]
            target_label  = "model_deployment"
          },
          {
            target_label = "__address__"
            replacement  = "${azurerm_container_app.this.latest_revision_fqdn}:9115"
          }
        ]
      }
    ]
  })
}

resource "azurerm_container_app_environment" "this" {
  name                = var.container_app_environment_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.merged_tags
}

resource "azurerm_container_app" "this" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"
  tags                         = local.merged_tags

  dynamic "identity" {
    for_each = var.enable_managed_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  secret {
    name  = "azure-openai-api-key"
    value = var.openai_api_key
  }

  secret {
    name  = "blackbox-config-template"
    value = local.blackbox_config_template
  }

  ingress {
    external_enabled = true
    target_port      = 9115
    transport        = "http"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }

    dynamic "ip_security_restriction" {
      for_each = var.grafana_allowed_cidrs
      content {
        name             = "allow-${replace(replace(ip_security_restriction.value, ".", "-"), "/", "-")}"
        action           = "Allow"
        ip_address_range = ip_security_restriction.value
      }
    }
  }

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "blackbox-exporter"
      image  = var.image
      cpu    = var.cpu
      memory = var.memory

      command = ["/bin/sh", "-c"]
      args = [
        "printf '%s' \"$BLACKBOX_CONFIG_TEMPLATE\" | sed \"s|__AZURE_OPENAI_API_KEY__|$AZURE_OPENAI_API_KEY|g\" > /tmp/blackbox.yml && exec /bin/blackbox_exporter --config.file=/tmp/blackbox.yml"
      ]

      env {
        name        = "AZURE_OPENAI_API_KEY"
        secret_name = "azure-openai-api-key"
      }

      env {
        name        = "BLACKBOX_CONFIG_TEMPLATE"
        secret_name = "blackbox-config-template"
      }
    }
  }
}
