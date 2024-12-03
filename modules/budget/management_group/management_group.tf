data "azurerm_management_group" "main" {
  name = var.management_group_id
}

resource "azurerm_consumption_budget_management_group" "main" {
  name = var.name

  management_group_id = data.azurerm_management_group.main.id

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
    }
  }
}
