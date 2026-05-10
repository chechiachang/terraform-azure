# Agent Instruction: Azure OpenAI Model Monitoring via Container Apps

This instruction defines the pattern for deploying a lightweight **Blackbox Exporter** on **Azure Container Apps (ACA)**. It is optimized for the "Always Free" tier to provide external availability and latency metrics for a public Grafana dashboard.

## Context & Objectives

- **Service:** Azure Container Apps (ACA)
- **Workload:** `prom/blackbox-exporter` (Docker)
- **Goal:** Monitor specific Azure OpenAI model deployments (e.g., GPT-4o, GPT-3.5) with model-level granularity
- **Metric Targets:** `probe_success`, `probe_duration_seconds` (external latency)

## Terraform Resource Requirements

When generating Terraform code for this agent, ensure the following Azure resources are included:

1. **`azurerm_container_app_environment`**: The managed environment for ACA
2. **`azurerm_container_app`**
   - **Image:** use a pinned tag such as `prom/blackbox-exporter:v0.25.0` for reproducible deployments (`:latest` only for short-lived testing)
   - **Ingress:** external on port `9115`
   - **Transport:** `http`
   - **Replicas:** `min_replicas = 1`, `max_replicas = 1`
3. **Container App secret block** (`secret {}` inside `azurerm_container_app`): To store the `AZURE_OPENAI_API_KEY`

## Configuration (Blackbox Module)

The agent should generate a `blackbox.yml` configuration passed as a **Secret** or **Config Map** with the following HTTP `POST` module.
Render the `api-key` value into this file at deploy time (do not rely on runtime environment variable expansion by Blackbox Exporter):

```yaml
modules:
  azure_openai_check:
    prober: http
    timeout: 10s
    http:
      method: POST
      headers:
        api-key: "REPLACE_WITH_AZURE_OPENAI_API_KEY"
        Content-Type: "application/json"
      body: '{"messages":[{"role":"user","content":"ping"}],"max_tokens":1}'
      valid_status_codes: [200]
```

## Implementation Workflow

### 1. Identify Model Endpoints

The Terraform module must accept a list of Azure OpenAI deployment URLs as variables:

`https://{resource-name}.openai.azure.com/openai/deployments/{deployment-name}/chat/completions?api-version=2024-05-01-preview`

### 2. Network Security

- Restrict ingress to **Grafana Cloud IP ranges** only (source IP filtering)
- Use **Managed Identity** if the Blackbox Exporter needs to interact with other Azure services

### 3. Metric Integration (Grafana Cloud)

The agent should provide the following `scrape_configs` snippet to add to Prometheus/Grafana Cloud configuration:

```yaml
scrape_configs:
  - job_name: 'azure_openai_models'
    metrics_path: /probe
    params:
      module: [azure_openai_check]
    static_configs:
      - targets: ["DEPLOYMENT_URL_1", "DEPLOYMENT_URL_2"]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: model_deployment
      - target_label: __address__
        replacement: "${ACA_FQDN}:9115"
```

## Best Practices

- **Keep it small:** set CPU to `0.25` and memory to `0.5Gi` to maximize "Always Free" grant eligibility
- **Tagging:** apply `Environment` and `Project` tags to all resources for cost tracking
- **Versioning:** always pin the Azure OpenAI `api-version` in probe URLs to ensure metric stability

## How to Use This Agent

Example request: "Implement a Blackbox Exporter on Azure Container Apps using the `openai-monitoring-aca.md` pattern to monitor my GPT-4o deployment in East US."
