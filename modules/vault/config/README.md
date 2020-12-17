Vault configurations
===

# Auth methods

- approle
- kubernetes
- azure

```
vault auth list
Path            Type          Accessor                    Description
----            ----          --------                    -----------
approle/        approle       auth_approle_12345678       n/a
general-k8s/    kubernetes    auth_kubernetes_12345678    n/a
```

# Azure auth method

Doc
- https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/service_principal_configuration
- https://www.vaultproject.io/docs/auth/azure
