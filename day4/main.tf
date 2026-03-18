terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pull the image once so both containers can use it
resource "docker_image" "nginx_img" {
  name = "nginx:latest"
}

# Create Container 1
module "server_8081" {
  source         = "./modules/nginx_container"
  container_name = "web-8081"
  container_port = 8081
  image_name     = docker_image.nginx_img.image_id
}

# Create Container 2
module "server_8082" {
  source         = "./modules/nginx_container"
  container_name = "web-8082"
  container_port = 8082
  image_name     = docker_image.nginx_img.image_id
}
