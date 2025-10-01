variable "app_count" {
  description = "How many apps to create"
  type        = number
  default     = 1
}

variable "apps" {
  description = "List of apps"
  type = list(object({
    app_name  = string
    port      = number
    image_url = string
  }))
  default = []
}
