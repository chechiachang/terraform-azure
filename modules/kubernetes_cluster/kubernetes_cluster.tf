resource "azurerm_kubernetes_cluster" "main" {
  name                = var.kubernetes_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.kubernetes_cluster_name

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard" # Private cluster
  }

  identity {
    type = "SystemAssigned"
  }

  private_cluster_enabled = true

  role_based_access_control {
    enabled = false
  }

  #service_principal {}

  tags = {
    environment = var.environment
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }

  auto_scaler_profile {}

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.default_node_pool_vm_size
    # availability_zones = []

    enable_auto_scaling = false
    #max_count = 0
    #max_count = 0
    #node_count = 0

    enable_node_public_ip = false

    node_labels = {
      purpose = "general"
    }
    node_taints = []

    tags = {
      environment = var.environment
    }

    vnet_subnet_id = null
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.main.kube_config_raw
}
