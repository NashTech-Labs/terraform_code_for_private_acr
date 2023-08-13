variable "azure_client_id" {
  default = " "
}
variable "azure_client_secret" {
  default = " "
}
variable "azure_tenant_id" {
  default = " "
}

variable "azure_subscription_id" {
  default = " "
}

variable "tags" {
  description = "Tags to be applied to the resources"
  type = map(string)
  default = {}
}

variable "location" {
  description = "Azure region where resources should be provisioned"
  type        = string
  default     = "Central US"
}

variable "azure_resource_group" {
  description = "Name of the Azure resource group where resources will be provisioned"
  type = string
  default = "acrTesting"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type = string
  default = "testACRnewRegisTrytestingdct"
}
variable "acr_sku" {
  description = "SKU of the Azure Container Registry"
  default = "Premium"

  validation {
    condition     = contains(["Premium"], var.acr_sku)
    error_message = "Argument \"acr_sku\" must be either \"Premium\" in order to support private endpoints."
  }
}

variable "aks_name" {
  description = "Name of the AKS to which you want to provide the pull access"
  type = string
  default = "aks"
}

variable "aks_resource_group" {
  description = "name of the resource group where aks resides"
  type = string
  default = "aks-rg"
}





