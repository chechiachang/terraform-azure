Terraform for Azure Cloud
===

Terraform + Terragrunt stacks for Azure resources.

# Stack Layout

Current stack path format:
`<resource-group>/<env>/<region>/<optional project>/<resource>`

Examples:
- `cc/dev/eastus2/national/ai-foundry`
- `cc/g/tenant/login_users`
- `cc/g/tenant/verified_domains`

Envs:
- `g` (global)
- `dev`

Regions:
- `tenant`
- `eastus2`
- others as needed

Legacy layout:
- `chechia/<resource-group>` is legacy without clear layering.
- Mark as deprecated in new changes, but do not remove existing stacks.

# Usage

Choose a stack path:
```bash
cd cc/dev/eastus2/national/ai-foundry
# or
cd cc/g/tenant/login_users
# or
cd cc/g/tenant/verified_domains
```

For `cc` stacks, the shared Terragrunt config supplies the subscription and Azure CLI path; no manual exports are needed. Authenticate only when the CLI session is missing or expired:
```bash
az login --use-device-code # complete login in a browser on another device
az account set --subscription="6fce7237-7e8e-4053-8e7d-ecf8a7c392ce"
```

On the OCI agent host, Azure CLI is `~/codex/azure-cli-venv/bin/az`. Override `AZURE_CLI_BIN_DIR` for another installation. `ARM_SUBSCRIPTION_ID` (then `SUBSCRIPTION_ID`) overrides the `cc` subscription; workshop/legacy stacks still require explicit subscription configuration. Existing initialized `cc` stacks need a one-time `terragrunt run -- init -reconfigure` after this backend configuration update; state location is unchanged.

Run Terragrunt:
```bash
terragrunt run -- init
terragrunt run -- plan
terragrunt run -- apply
```

# First-time Backend Setup

Create Terraform backend resources manually, then use Terragrunt.

```bash
RESOURCE_GROUP_NAME=base
LOCATION=southeastasia
STORAGE_ACCOUNT_NAME=""
CONTAINER_NAME=base

az group create \
  --name ${RESOURCE_GROUP_NAME} \
  --location ${LOCATION}

az storage account create \
  --name ${STORAGE_ACCOUNT_NAME} \
  --resource-group ${RESOURCE_GROUP_NAME} \
  --location ${LOCATION} \
  --sku Standard_LRS \
  --kind StorageV2

az storage container create \
  --account-name ${STORAGE_ACCOUNT_NAME} \
  --name ${CONTAINER_NAME} \
  --auth-mode login
```

# Codex Agent: Azure OpenAI Model Updates

Workflow: `.github/workflows/codex-azure-openai-models.yml` (manual or weekly).

1. Fetches models supported by Azure OpenAI (`GET <endpoint>/openai/v1/models`).
2. Codex checks deployed models in `ai-foundry` stacks.
3. Codex adds the latest models and opens a PR.

Setup:
- Secrets: `AZURE_OPENAI_ENDPOINT` (e.g. `https://<resource>.openai.azure.com`), `AZURE_OPENAI_API_KEY`.
- Optional variable: `CODEX_MODEL` (Azure deployment used by Codex, default `gpt-5.5`).
- Enable Settings > Actions > General > "Allow GitHub Actions to create and approve pull requests".
