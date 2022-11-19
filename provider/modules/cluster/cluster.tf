resource "azurerm_resource_group" "aks-tf-rg" {
  name     = var.azurerm_resource_group_name
  location = var.azurerm_resource_group_location

  tags = var.azurerm_resource_group_tags

}

resource "azurerm_kubernetes_cluster" "aks-tf-cluster" {
  name                = var.azurerm_kubernetes_cluster_name
  location            = var.azurerm_kubernetes_cluster_location
  resource_group_name = azurerm_resource_group.aks-tf-rg.name
  dns_prefix          = var.azurerm_kubernetes_cluster_dnsPrefix
  kubernetes_version  = var.azurerm_kubernetes_cluster_kubernetes_version # 1.24.6
  tags                = var.azurerm_kubernetes_cluster_tags

  default_node_pool {
    name            = var.default_node_pool_name            # akstestclusterpools
    node_count      = var.default_node_pool_node_count      # 4
    vm_size         = var.default_node_pool_vm_size         # Standard_E64as_v4
    type            = var.default_node_pool_type            # VirtualMachineScaleSets
    os_disk_size_gb = var.default_node_pool_os_disk_size_gb # 500 GB
    max_pods        = var.default_node_pool_max_pods        # 110
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }

  linux_profile {
    admin_username = var.linux_profile_admin_username
    ssh_key {
      key_data = var.linux_profile_ssh_key
    }
  }

  network_profile {
    network_plugin    = var.network_profile_network_plugin    # Kubenet
    load_balancer_sku = var.network_profile_laod_balancer_sku # Standard
    pod_cidr          = var.network_profile_pod_cidr          # 10.204.0.0/16
    service_cidr      = var.network_profile_service_cidr      # 10.205.0.0/16
  }

  oms_agent {
    enabled = true
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks-test-cluster-monitoring" {
  name                  = "monitoring"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-tf-cluster.id
  vm_size               = "Standard_D8s_v3"
  node_count            = 1
  os_disk_size_gb       = 128
  os_type               = "Linux"
}
