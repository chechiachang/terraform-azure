# AKS

Check azure official doc: [Create a Kubernetes cluster with Azure Kubernetes Service using Terraform](https://docs.microsoft.com/zh-tw/azure/developer/terraform/create-k8s-cluster-with-tf-and-aks?WT.mc_id=AZ-MVP-5003985)

# Access AKS

```
KUBECONFIG_OUTPUT_PATH="/Users/che-chia/.kube/azure-aks"
kubectl --kubeconfig ${KUBECONFIG_OUTPUT_PATH} get no
```
