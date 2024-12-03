data "azurerm_subscription" "current" {}

resource "azurerm_consumption_budget_subscription" "main" {
  name = var.name

  subscription_id = data.azurerm_subscription.current.id

  amount     = var.amount
  time_grain = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date != "" ? var.end_date : null
  }

  filter {
    dimension {
      name = "ResourceGroupName"
      values = [
        var.resource_group_name
      ]
    }

    #tag {
    #  name = "foo"
    #  values = [
    #    "bar",
    #    "baz",
    #  ]
    #}
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      enabled        = notification.value.enabled
      threshold      = notification.value.threshold
      operator       = notification.value.operator
      threshold_type = notification.value.threshold_type
      contact_emails = notification.value.contact_emails
      contact_groups = notification.value.contact_groups
      contact_roles  = notification.value.contact_roles
    }
  }
}
