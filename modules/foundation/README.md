Foundation: base of terraform
===

Content in foundation are essential to initializa terraform. These resources are manually provisioned and then imported to terraform for management.

WARNING: Misconfiguration in foundation could cause terraform total failure.

contents:
- resource group
- storage account

# Initialization

- Manually create resources on azure
  - resource group
  - storage account
  - storage container
- Import resources
- Manage resources with terraform

# Import

```
az group list
terragrunt import azurerm_resource_group.main /subscriptions/xxx/resourceGroups/base

az storage account list
terragrunt import azurerm_storage_account.main /subscriptions/xxx/resourceGroups/base/providers/Microsoft.Storage/storageAccounts/basexxx

az storage container list --account-name basexxx
terragrunt import azurerm_storage_container.main https://basexxx.blob.core.windows.net/base
```
