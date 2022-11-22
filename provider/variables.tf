variable "serviceprinciple_id" {}
variable "serviceprinciple_key" {}
variable "tenant_id" {}
variable "subscription_id" {}

# Azure Resource Group Variables
variable "azurerm_resource_group_name" {
  type    = string
  default = "rg-aks-test-cluster"
}
variable "azurerm_resource_group_location" {
  type    = string
  default = "West Europe"
}
variable "azurerm_resource_group_tags" {
  default = {
    Project         = ""
    Project_Contact = ""
    Project_Owner   = ""
  }
}

# Azure Kubernetes Cluster Variables
variable "azurerm_kubernetes_cluster_name" {
  type    = string
  default = "aks-test-cluster"
}
variable "azurerm_kubernetes_cluster_location" {
  type    = string
  default = "West Europe"
}
variable "azurerm_kubernetes_cluster_dnsPrefix" {
  default = "akstesttf"
  type    = string
}
variable "azurerm_kubernetes_cluster_kubernetes_version" {
  type    = string
  default = "1.24.6"
}
variable "azurerm_kubernetes_cluster_tags" {
  default = {
    Project         = ""
    Project_Contact = ""
    Project_Owner   = ""
  }
}

# Azure Kubernetes Cluster Default Node Pool Variables
variable "default_node_pool_name" {
  type    = string
  default = "akstestclusterpools"
}
variable "default_node_pool_node_count" {
  type    = number
  default = 4
}
variable "default_node_pool_vm_size" {
  type    = string
  default = "Standard_E64as_v4"
}
variable "default_node_pool_type" {
  type    = string
  default = "VirtualMachineScaleSets"
}
variable "default_node_pool_os_disk_size_gb" {
  type    = number
  default = 500
}
variable "default_node_pool_max_pods" {
  type    = number
  default = 110
}

# Azure Kubernetes Cluster Service Principal Variables
variable "service_principal_client_id" {
  type = string
}
variable "service_principal_client_secret" {
  type = string
}

# Azure Kubernetes Cluster Linux Profiles Variables
variable "linux_profile_admin_username" {
  type    = string
  default = "azureuser"
}
variable "linux_profile_ssh_key" {
  type = string
}

# Azure Kubernetes Cluster Network Profile Variables
variable "network_profile_network_plugin" {
  type    = string
  default = "Kubenet"
}
variable "network_profile_laod_balancer_sku" {
  type    = string
  default = "Standard"
}
variable "network_profile_pod_cidr" {
  type    = string
  default = "10.204.0.0/16"
}
variable "network_profile_service_cidr" {
  type    = string
  default = "10.205.0.0/16"
}
