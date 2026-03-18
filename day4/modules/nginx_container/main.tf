terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "docker_container" "nginx" {
  # We use 'var.' to tell Terraform to use the inputs from variables.tf
  name  = var.container_name  
  image = var.image_name      
  
  ports {
    internal = 80
    external = var.container_port
  }
}
