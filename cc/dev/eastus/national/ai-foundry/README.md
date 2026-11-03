# National AI Foundry — East US proposal

This is an **additive, review-only regional stack** proposed in [issue #22](https://github.com/chechiachang/terraform-azure/issues/22). It does not move or replace `cc/dev/eastus2/national/ai-foundry` and must not be applied until reviewers confirm the account name, subscription quota, deployment access, expected costs, and endpoint consumers.

## Initial deployments

- `gpt-6.1-terra`, model version `2026-10-26`, `DataZoneStandard`
- `gpt-6-luna`, model version `2026-09-22`, `DataZoneStandard`; this is the currently supported model for the **Azure OpenAI Decisions API**. Call `POST /openai/v1/decisions` and pass the deployment name `gpt-6-luna` as `model`. GPT-6.1 Terra is not currently documented as a Decisions API model.

Microsoft's region matrix lists both deployments in East US. The Azure OpenAI Decisions API rollout explicitly excludes East US 2, so adding the API feature requires an eligible region and a `gpt-6-luna` deployment. `DataZoneStandard` keeps inference within the US data zone; it does not promise the lowest latency. The initial capacity of `1` is only a conservative validation setting, not a production throughput recommendation.

- [Azure OpenAI Decisions API: supported model, endpoint, and regional rollout](https://learn.microsoft.com/en-us/azure/foundry/openai/how-to/decisions)
- [OpenAI Decisions API guide](https://developers.openai.com/api/docs/guides/decisions)
- [Model availability by region and deployment type](https://learn.microsoft.com/en-us/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure-region-availability)

## Rollout

1. Review East US suitability, unique resource/subdomain name, actual subscription model access/quota, capacity, networking, identity/RBAC, and cost.
2. Plan and deploy this stack separately; smoke-test Terra via its supported API and GPT-6 Luna through `/openai/v1/decisions`.
3. Update consumers deliberately and retain the existing East US 2 stack as rollback until acceptance.
4. Migrate any further model deployments only after checking that model's region/deployment-type availability. Do not change the existing account's `location` in place: [AzureRM v4.71 documents that this forces account replacement](https://registry.terraform.io/providers/hashicorp/azurerm/4.71.0/docs/resources/cognitive_account#location).

No resource has been applied as part of this proposal.
