terraform {
  source = "../../..//modules/budget/management_group"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/kubernetes_cluster?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  # enterprise features
  #
  #management_group_id = ""

  #name        = "sponsorship-monthly"
  #amount      = 1000
  #time_period = "Monthly"
  #start_date  = "2024-12-01T00:00:00+08:00"

  #resource_group_name = "base"
  #notifications = {
  #  forecast_80_percent = {
  #    enabled        = true
  #    threshold      = 60
  #    operator       = "GreaterThan"
  #    threshold_type = "Forecasted"
  #    contact_emails = [
  #      "chechia@chechia.net"
  #    ]
  #  }
  #  actual_90_percent = {
  #    enabled        = true
  #    threshold      = 90
  #    operator       = "GreaterThan"
  #    threshold_type = "Actual"
  #    contact_emails = [
  #      "chechia@chechia.net"
  #    ]
  #  }
  #}
}
