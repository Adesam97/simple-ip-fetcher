variable "image" {
  description = "The ip-finder container image"
  type        = string
  default     = "fikunmisamson/container-ip-finder:latest"
}

variable "region" {
  description = "region of deployment"
  type        = string
  default     = "East US"
}
