resource "azurerm_container_registry" "registry" {
  name                = "${var.project}containerregistry"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true # required for App Service
}

output "login_server" {
  value = azurerm_container_registry.registry.login_server
}

output "admin_username" {
  value     = azurerm_container_registry.registry.admin_username
  sensitive = true
}

output "admin_password" {
  value     = azurerm_container_registry.registry.admin_password
  sensitive = true
}
