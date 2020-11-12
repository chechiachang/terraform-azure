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

SUBSCRIPTION_ID=
RESOURCE_GROUP_NAME=base
terragrunt import azurerm_resource_group.main /subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP_NAME}

az storage account list

STORAGE_ACCOUNT=
terragrunt import azurerm_storage_account.main /subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP_NAME}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT}

az storage container list --account-name ${STORAGE_ACCOUNT}

CONTAINER_NAME=base
terragrunt import azurerm_storage_container.main "https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER_NAME}"
```
