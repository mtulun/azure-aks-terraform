# AKS needs a service principal to function correctly.
variable "serviceprinciple_id" {}
variable "serviceprinciple_key" {}

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
  type = object({
    Project         = string
    Project_Contact = string
    Project_Owner   = string
  })
}

# Azure Kubernetes Cluster Variables
variable "azurerm_kubernetes_cluster_name" {
  type = string
}
variable "azurerm_kubernetes_cluster_location" {
  type = string
}
variable "azurerm_kubernetes_cluster_dnsPrefix" {
  type = string
}
variable "azurerm_kubernetes_cluster_kubernetes_version" {
  type = string
}
variable "azurerm_kubernetes_cluster_tags" {
  type = object({
    Project         = string
    Project_Contact = string
    Project_Owner   = string
  })
}

# Azure Kubernetes Cluster Default Node Pool Variables
variable "default_node_pool_name" {
  type = string
}
variable "default_node_pool_node_count" {
  type = number
}
variable "default_node_pool_vm_size" {
  type = string
}
variable "default_node_pool_type" {
  type = string
}
variable "default_node_pool_os_disk_size_gb" {
  type = number
}
variable "default_node_pool_max_pods" {
  type = number
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
  type = string
}
variable "linux_profile_ssh_key" {
  type = string
}

# Azure Kubernetes Cluster Network Profile Variables
variable "network_profile_network_plugin" {
  type = string
}
variable "network_profile_laod_balancer_sku" {
  type = string
}
variable "network_profile_pod_cidr" {
  type = string
}
variable "network_profile_service_cidr" {
  type = string
}
