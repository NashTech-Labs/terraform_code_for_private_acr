output "acr_credentials" {
  description = "Azure Container Registry Credentials"
  sensitive   = true
  value       = {
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }
}
output "login_server" {
  value = azurerm_container_registry.acr.login_server 
  }
