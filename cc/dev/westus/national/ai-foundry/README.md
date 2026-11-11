# National AI Foundry — West US

Independent `dev` stack in `westus` (California), using account/subdomain `national-team-westus`. It leaves both East US stacks unchanged and uses the shared AI Foundry module and RAI policy settings. The inherited backend key is `dev/westus/national/ai-foundry/terraform.tfstate`, separate from the East US state keys.

## Deployments

| Deployment | Model version | SKU | Capacity |
| --- | --- | --- | --- |
| `gpt-6.1-terra` | `2026-10-26` | `GlobalStandard` | `10000` |
| `gpt-6.1-sol` | `2026-09-29` | `GlobalStandard` | `10000` |
| `gpt-6-luna` | `2026-09-22` | `GlobalStandard` | `10000` |

Microsoft's [region matrix](https://learn.microsoft.com/en-us/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure-region-availability?tabs=az-americas&pivots=standard#global-standard) lists all three versions for West US Global Standard (checked November 12, 2026). Capacity and SKU align with the East US 2 GPT-6 family; this does not verify West US subscription quota or reserve compute.

## OpenAI Decisions API

Call `POST /openai/v1/decisions` on the new resource endpoint, with `model` set to deployment name `gpt-6-luna`. Sol and Terra are not documented as Decisions API models. This is the Azure OpenAI Decisions API, not the Microsoft Decision-1/System One endpoint.

The [Decisions guide](https://learn.microsoft.com/en-us/azure/foundry/openai/how-to/decisions) describes rollout to regions where GPT-6 Luna is available and excludes East US 2. West US meets that documented eligibility; actual rollout and endpoint behavior still require verification before consumer cutover. No separate Terraform resource enables this API.

## Latency and rollout

West US is a candidate to reduce network latency from Taiwan, not a measured improvement. [Global Standard](https://learn.microsoft.com/en-us/azure/foundry/foundry-models/concepts/deployment-types#global-standard) dynamically routes inference globally: neither this location nor capacity guarantees West US processing or faster time to first token.

Before applying, confirm account/subdomain availability, subscription model access, quota and available capacity for each model/SKU, networking, RBAC, and cost. Plan this stack separately, then verify Sol/Terra through their supported APIs and Luna through Decisions before deliberately changing consumers. Retain the old stacks for rollback; East US 2 cannot provide Decisions fallback under the documented rollout.

No plan, apply, API call, or latency test was performed when proposing this stack.
