variable "project" {
  type    = string
  default = "openquestion"
}

variable "environment" {
  default = "development"
}

variable "location" {
  type        = string
  description = "This is the default location for the azure resources"
  default     = "westeurope"
}

variable "sku_name" {
  type        = string
  description = "This is the pricing plan"
  default     = "P1v3"
}

variable "docker_image_name" {
  type        = string
  description = "The name of the Docker Image"
  default     = "my_docker_image"
}

variable "docker_image_tag" {
  type        = string
  description = "The tag of the Docker Image"
  default     = "my_image_tag"
}

variable "sql_port" {
  default = 3306
}

variable "sql_container_group_name" {
  default = "acigroup"
}

variable "sql_container_name" {
  default = "mysql"
}

variable "sql_container_image" {
  default = "mysql:latest"
}

variable "sql_cpu_cores" {
  default = 2
}

variable "sql_memory_in_gb" {
  default = 4
}

variable "environment_variables" {
  default = {
    MYSQL_ROOT_PASSWORD = "your_mysql_root_password"
  }
}
