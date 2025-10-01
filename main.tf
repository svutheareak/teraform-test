terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "docker" {}

# variables inline (no variables.tf needed)
variable "app_count" {
  description = "How many apps to deploy (from the apps list)"
  type        = number
}

variable "apps" {
  description = "List of apps"
  type = list(object({
    app_name  = string
    port      = number
    image_url = string
  }))
}

# Only take the first N apps (based on app_count)
locals {
  selected_apps = slice(var.apps, 0, var.app_count)
}

# Pull images
resource "docker_image" "images" {
  for_each = { for idx, app in local.selected_apps : idx => app }
  name     = each.value.image_url
}

# Run containers
resource "docker_container" "containers" {
  for_each = { for idx, app in local.selected_apps : idx => app }

  name  = each.value.app_name
  image = docker_image.images[each.key].name

  ports {
    internal = 80
    external = each.value.port
  }

  restart = "unless-stopped"
}

# Output
output "running_apps" {
  value = [for app in local.selected_apps : "${app.app_name} running on port ${app.port}"]
}