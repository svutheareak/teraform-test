app_count = 2

apps = [
  {
    app_name  = "app1"
    port      = 9001
    image_url = "nginx:latest"
  },
  {
    app_name  = "app2"
    port      = 9002
    image_url = "httpd:latest"
  },
  {
    app_name  = "app3"
    port      = 9003
    image_url = "alpine:latest"
  }
]
