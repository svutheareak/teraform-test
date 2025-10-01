variable "app_count" {
  description = "How many apps do you want to create?"
  type        = number
}

variable "apps" {
  description = "App details (name, port, image_url)"
  type = list(object({
    app_name  = string
    port      = number
    image_url = string
  }))
}
