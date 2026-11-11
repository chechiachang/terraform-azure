# National AI Foundry — East US proposal

This is an **additive, review-only regional stack** proposed in [issue #22](https://github.com/chechiachang/terraform-azure/issues/22). It does not move or replace `cc/dev/eastus2/national/ai-foundry` and must not be applied until reviewers confirm the account name, subscription quota, deployment access, expected costs, and endpoint consumers.

## Deployments

| Deployment | Model version | SKU | Capacity |
| --- | --- | --- | --- |
| `gpt-6.1-terra` | `2026-10-26` | `DataZoneStandard` | `400` |
| `gpt-6.1-sol` | `2026-09-29` | `DataZoneStandard` | `400` |
| `gpt-6-luna` | `2026-09-22` | `DataZoneStandard` | `400` |

Capacity `400` matches the most common setting in `cc/dev/eastus2/national/ai-foundry`; it does not copy that stack's GPT-6-family capacity `10000` or its `GlobalStandard` SKU. Actual quota and capacity availability must be checked for each model and deployment type in East US before applying.

Microsoft's region matrix lists all three model versions for `DataZoneStandard` in East US (checked November 12, 2026). `DataZoneStandard` keeps inference within the US data zone; it does not promise the lowest latency.

`gpt-6-luna` remains the only currently documented model for the **Azure OpenAI Decisions API**. Call `POST /openai/v1/decisions` and pass the deployment name `gpt-6-luna` as `model`; GPT-6.1 Terra and GPT-6.1 Sol are not documented as Decisions API models. The Decisions API rollout explicitly excludes East US 2, so using it requires an eligible region and a `gpt-6-luna` deployment.

- [Azure OpenAI Decisions API: supported model, endpoint, and regional rollout](https://learn.microsoft.com/en-us/azure/foundry/openai/how-to/decisions)
- [OpenAI Decisions API guide](https://developers.openai.com/api/docs/guides/decisions)
- [Model availability by region and deployment type](https://learn.microsoft.com/en-us/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure-region-availability)

## Rollout

1. Review East US suitability, unique resource/subdomain name, actual subscription model access/quota, capacity, networking, identity/RBAC, and cost.
2. Plan and deploy this stack separately; smoke-test Terra and Sol via their supported APIs and GPT-6 Luna through `/openai/v1/decisions`.
3. Update consumers deliberately and retain the existing East US 2 stack as rollback until acceptance.
4. Migrate any further model deployments only after checking that model's region/deployment-type availability. Do not change the existing account's `location` in place: [AzureRM v4.71 documents that this forces account replacement](https://registry.terraform.io/providers/hashicorp/azurerm/4.71.0/docs/resources/cognitive_account#location).

No resource has been applied as part of this proposal.
