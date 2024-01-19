# https://learn.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-terraform

resource "azurerm_container_group" "container" {
  name                = "${var.project}${var.container_group_name}"
  resource_group_name = var.rg_name
  location            = var.location
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  container {
    name                         = var.container_name
    image                        = var.container_image
    environment_variables        = var.environment_variables
    secure_environment_variables = var.secure_environment_variables
    cpu                          = var.cpu_cores
    memory                       = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }
}
