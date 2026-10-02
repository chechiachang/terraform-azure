You are a coding agent maintaining Azure OpenAI model deployments in this Terragrunt repository.
Follow `AGENTS.md`. Be concise and make minimal changes.

## Inputs
- `.codex-tmp/azure-openai-models.min.json`: models supported by the Azure OpenAI resource
  (`id`, `created_at`, `lifecycle_status`, `deprecation`, `capabilities`).
  Raw response: `.codex-tmp/azure-openai-models.json`.
- Model deployments in this repo: `cognitive_deployments` blocks in `**/terragrunt.hcl`.

## Tasks
1. Fetch: read the supported model list above. Do not call the network.
2. Check: list the OpenAI models (name + version) deployed in this repo. Only these stacks are in scope:
   - `cc/dev/eastus2/national/ai-foundry/terragrunt.hcl`
   - `workshop/dev/eastus2/workshop/ai-foundry/terragrunt.hcl`
   Do NOT modify `cc/dev/eastus2/national/openai` (deprecated) or anything under `chechia/` (legacy).
3. Suggest and add: find the latest models that are not deployed yet, e.g. a newer generation or a
   newer version of a model family already in use (gpt, gpt-mini, gpt-nano, codex, embeddings).
   - Only use models with `lifecycle_status` of `generally-available` (or `preview` if the family
     is already deployed as preview) and with `chat_completion`, `completion`, or `embeddings` capability.
   - Skip deprecated models and models whose deprecation date has passed.
   - Model `version` is the date suffix of the model id (e.g. `gpt-5.5-2026-04-24` -> name `gpt-5.5`,
     version `2026-04-24`); use the newest version per model name.
   - Add a new entry to `cognitive_deployments`, copying the exact structure of the closest existing
     entry in the same file (sku name, capacity, `dynamic_throttling_enabled`, `rai_policy_name`).
     Keep existing entries; do not remove or bump existing deployments.
   - Use the model name as both the map key and `name`, matching existing style.
   - Keep HCL formatting consistent (run `terragrunt hclfmt` if available).

## Output
Your final message is used as the pull request body. Write markdown with:
- A table of models currently deployed in the repo.
- A table of newly added models (name, version, file).
- Other suggestions not applied (e.g. deprecated deployments to retire), if any.
If there is nothing to add, make no file changes and say so.
