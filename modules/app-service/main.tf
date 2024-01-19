resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.project}-app-service-plan"
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.project}-webapp-backend"
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  https_only          = true # This is needed, otherwise will fail due to organisation permissions

  site_config {
    minimum_tls_version = "1.2"
    always_on           = false
    ftps_state          = "FtpsOnly"
    http2_enabled       = true
    health_check_path   = "/health"
    application_stack {
      docker_image     = "${var.login_server}/${var.docker_image_name}"
      docker_image_tag = var.docker_image_tag
    }
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true

    http_logs {
      file_system {
        retention_in_days = 1
        retention_in_mb   = 35
      }
    }
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = var.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = var.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.admin_password
  }
}
