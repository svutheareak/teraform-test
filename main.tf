provider "docker" {}

# filter only the apps chosen by user
locals {
  selected_apps = {
    for k, v in var.apps : k => v
    if contains(var.deploy_apps, k)
  }
}

# pull docker images
resource "docker_image" "images" {
  for_each = local.selected_apps
  name     = each.value.image_url
}

# run docker containers
resource "docker_container" "containers" {
  for_each = local.selected_apps

  name  = each.value.app_name
  image = docker_image.images[each.key].name

  ports {
    internal = 80
    external = each.value.port
  }

  restart = "unless-stopped"
}

# output URLs
output "app_urls" {
  value = {
    for k, v in local.selected_apps :
    k => "http://localhost:${v.port}"
  }
}
