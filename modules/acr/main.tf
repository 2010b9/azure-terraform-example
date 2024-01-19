resource "azurerm_container_registry" "registry" {
  name                = "${var.project}containerregistry"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true # required for App Service
}
