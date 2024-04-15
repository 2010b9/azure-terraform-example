resource "random_password" "admin_password" {
  count       = var.admin_password == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

data "azurerm_client_config" "current" {}

locals {
  admin_password = try(random_password.admin_password[0].result, var.admin_password)
}

resource "azurerm_mssql_server" "server" {
  name                          = var.project
  resource_group_name           = var.rg_name
  location                      = var.location
  administrator_login           = var.admin_username
  administrator_login_password  = local.admin_password
  version                       = "12.0"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false
  azuread_administrator {
    login_username = "example_admin"
    object_id      = data.azurerm_client_config.current.object_id
    tenant_id      = data.azurerm_client_config.current.tenant_id
  }
}

resource "azurerm_mssql_database" "database" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.server.id
}
