variable "apps" {
  description = "Map of all available apps"
  type = map(object({
    app_name  = string
    port      = number
    image_url = string
  }))

  default = {
    app1 = {
      app_name  = "app1"
      port      = 9001
      image_url = "nginx:latest"
    }
    app2 = {
      app_name  = "app2"
      port      = 9002
      image_url = "httpd:latest"
    }
    app3 = {
      app_name  = "app3"
      port      = 9003
      image_url = "alpine:latest"
    }
  }
}

variable "deploy_apps" {
  description = "Which apps to deploy (choose from app1, app2, app3)"
  type        = list(string)
  default     = []
}
