# 1. TELL TERRAFORM WHICH PLUGIN TO DOWNLOAD
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# 2. CONNECT TO DOCKER ON UBUNTU
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# 3. PULL THE NGINX IMAGE (Like "docker pull")
resource "docker_image" "nginx_img" {
  name         = "nginx:latest"
  keep_locally = false
}

# 4. CREATE THE CONTAINER (Like "docker run")
resource "docker_container" "nginx_container" {
  image = docker_image.nginx_img.image_id
  name  = "my-lab-webserver"
  
  ports {
    internal = 80    # The port Nginx listens on inside the container
    external = 8080  # The port you will type into your Ubuntu browser
  }
}

# 5. PRINT THE URL TO THE SCREEN
output "service_url" {
  value = "http://localhost:8080"
}
