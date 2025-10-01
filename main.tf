provider "docker" {}

# Only take first `app_count` apps
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
}
