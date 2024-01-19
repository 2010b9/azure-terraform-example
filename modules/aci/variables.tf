variable "project" {

}

variable "rg_name" {

}

variable "location" {

}

variable "container_group_name" {
  type        = string
  description = "Prefix of the container group name that's combined with the project name so name is unique in your Azure subscription."
}

variable "container_name" {
  type        = string
  description = "Prefix of the container name that's combined with the project name so name is unique in your Azure subscription."
}

variable "container_image" {
  type        = string
  description = "Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials."
}

variable "port" {
  type        = number
  description = "Port to open on the container and the public IP address."
  default     = 80
}

variable "cpu_cores" {
  type        = number
  description = "The number of CPU cores to allocate to the container."
}

variable "memory_in_gb" {
  type        = number
  description = "The amount of memory to allocate to the container in gigabytes."
}

variable "restart_policy" {
  type        = string
  description = "The behavior of Azure runtime if container has stopped."
  default     = "Always"
  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "The restart_policy must be one of the following: Always, Never, OnFailure."
  }
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "secure_environment_variables" {
  type    = map(string)
  default = {}
}
