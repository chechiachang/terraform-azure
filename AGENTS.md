# Agent Guide

## Rules
- Be concise.
- Do only what is asked.
- Prefer safe, non-destructive actions.

## Azure planning
- `cc/terragrunt.hcl` supplies the subscription to provider/backend and finds Azure CLI in `~/codex/azure-cli-venv/bin` or PATH. Override with `ARM_SUBSCRIPTION_ID` (then `SUBSCRIPTION_ID`) and `AZURE_CLI_BIN_DIR` when needed.
- Run `terragrunt run -- plan` from the chosen stack; no manual exports are needed for `cc`.
- If login expires, use `~/codex/azure-cli-venv/bin/az login --use-device-code --tenant 5dc1c3ed-d350-4c3b-ba3d-db5ac4bfe072`; human completes login on another device. Never save tokens or secrets in Git.
- State access allows OCI Osaka NAT `161.33.23.63`; recheck if the gateway is replaced. Do not broaden the firewall automatically.

## Folder Layout
Current stack format:
`<resource-group>/<env>/<region>/<optional project>/<resource>`

Examples:
`cc/dev/eastus2/national/ai-foundry`
`cc/g/tenant/verified_domains`

Envs:
- `g` (global)
- `dev`

Regions:
- `tenant`
- `eastus2`
- others as needed

## Legacy Layout (Deprecated)
`chechia/<resource-group>` is legacy layout without clear layering.
Mark as deprecated in new changes, but do not remove existing stacks.
