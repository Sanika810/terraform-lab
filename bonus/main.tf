terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# 1. The Dynamic Configuration (The "Data")
variable "container_config" {
  type = list(object({
    name = string
    port = number
  }))
  default = [
    { name = "web-8083", port = 8083 },
    { name = "web-8084", port = 8084 },
    { name = "web-8085", port = 8085 }
  ]
}

# 2. Get the Nginx image
resource "docker_image" "nginx_img" {
  name = "nginx:latest"
}

# 3. The "for_each" Loop (The "Engine")
# This calls your Day 4 module multiple times automatically
module "dynamic_containers" {
  source   = "../day4/modules/nginx_container"
  
  for_each = { for c in var.container_config : c.name => c }

  container_name = each.value.name
  container_port = each.value.port
  image_name     = docker_image.nginx_img.image_id
}

# 4. Dynamic Output (The "Results")
output "container_urls" {
  value = [for c in var.container_config : "http://localhost:${c.port}"]
}

