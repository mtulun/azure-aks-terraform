provider "azurerm" {
  version = "3.32.0"

  subscription_id = var.subscription_id
  client_id       = var.serviceprinciple_id
  client_secret   = var.serviceprinciple_key
  tenant_id       = var.tenant_id

  features {}
}

module "cluster" {
  source               = "./provider/modules/cluster/"
  serviceprinciple_id  = var.serviceprinciple_id
  serviceprinciple_key = var.serviceprinciple_key
  ssh_key              = var.linux_profile_ssh_key
  location             = var.azurerm_kubernetes_cluster_location
  kubernetes_version   = var.azurerm_kubernetes_cluster_kubernetes_version
}
