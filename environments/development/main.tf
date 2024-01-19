resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-${var.environment}"
  location = var.location
}

module "acr" {
  source   = "../../modules/acr"
  project  = var.project
  rg_name  = azurerm_resource_group.rg.name
  location = var.location
}

module "app-service" {
  source            = "../../modules/app-service"
  project           = var.project
  rg_name           = azurerm_resource_group.rg.name
  location          = var.location
  sku_name          = var.sku_name
  login_server      = module.acr.login_server
  admin_username    = module.acr.admin_username
  admin_password    = module.acr.admin_password
  docker_image_name = var.docker_image_name
  docker_image_tag  = var.docker_image_tag
}
