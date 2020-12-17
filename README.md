Terraform for Azure Cloud
===

This repository manage my azure resources with terraform and terragrunt. For user not using terragrunt, check our [archived version terraform-azure](archived/azure/README.md)

# Client Version

terraform
  0.13.5
terragrunt
  0.26.0

# Usage

```
NEW_PROJECT_NAME=my-awesome-azure

cp -r chechia ${NEW_PROJECT_NAME}
# cd to base/dev/staging/prod environment
cd ${NEW_PROJECT_NAME}/base/foundation
```

Edit environments
- resource group name
- storage account name
- storage container name
```
vim env.tfvars

az login
terragrunt init && terragrunt plan
```

---

# First time? Let's Get-Started!

### Install tools

- Azure-cli [Azure doc: Install azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?WT.mc_id=AZ-MVP-5003985)
- Terraform [Azure doc: configure terraform using azure cloud shell](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell?WT.mc_id=AZ-MVP-5003985)
- Terragrunt [Github: terragrunt](https://github.com/gruntwork-io/terragrunt)

### config Azure cli

[Azure doc: get started with azure cli](https://docs.microsoft.com/en-us/cli/azure/get-started-with-azure-cli?WT.mc_id=AZ-MVP-5003985)

This project use credential from azure-cli.
```
az login
```

### Create resource group, storage account, and storage blob container

[Azure doc: create storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?WT.mc_id=AZ-MVP-5003985&tabs=azure-cli#create-a-storage-account-1)

[Azure doc: Configure storage account](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?WT.mc_id=AZ-MVP-5003985#configure-storage-account)

```
RESOURCE_GROUP_NAME=base
LOCATION=southeastasia

az group create \
  --name ${RESOURCE_GROUP_NAME} \
  --location ${LOCATION}

STORAGE_ACCOUNT_NAME=""

az storage account create \
  --name ${STORAGE_ACCOUNT_NAME} \
  --resource-group ${RESOURCE_GROUP_NAME} \
  --location ${LOCATION} \
  --sku Standard_LRS \
  --kind StorageV2

CONTAINER_NAME=base

az storage container create \
    --account-name ${STORAGE_ACCOUNT_NAME} \
    --name ${CONTAINER_NAME} \
    --auth-mode login
```
