terraform {
  backend "remote" {
    organization = "DCTEnterprise"
    workspaces {
      prefix = "ws-"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {
  }
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.aks_resource_group
}
# Create azure resource group
resource "azurerm_resource_group" "acr_resource_group" {
  name     = var.azure_resource_group
  location = var.location
  tags     = var.tags
}

# Create azure container registry
resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = azurerm_resource_group.acr_resource_group.name
  admin_enabled                 = true
  sku                           = var.acr_sku
  public_network_access_enabled = false
  tags                          = var.tags 
}

resource "azurerm_role_assignment" "acr_pull_role_assignment" {
  principal_id                     = data.azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

