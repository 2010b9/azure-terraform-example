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
