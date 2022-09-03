
# Create a resource group
resource "azurerm_resource_group" "RG_DLL" {
  name = var.rg_dll
  location = var.location_dll
    
  #name     = "RG_AKS-Cluster_DLL"
  #location = "East Us 2"
}

resource "azurerm_kubernetes_cluster" "K8sCluster" {
  name = var.clustername_dll
  #name                = "Cluster-AKS_DLL"
  location = azurerm_resource_group.RG_DLL.location
  resource_group_name = azurerm_resource_group.RG_DLL.name
  #location            = "EastUs2" #azurerm_resource_group.AKS.location
  #resource_group_name = "RG-AKS-Cluster_DLL" #azurerm_resource_group.AKS.name
  dns_prefix          = "Cluster-AKS-DNS"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "POC_Semillero"
  }
}

# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.K8sCluster.kube_config.0.client_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.K8sCluster.kube_config_raw

#   sensitive = true
# }