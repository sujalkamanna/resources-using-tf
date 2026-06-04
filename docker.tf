# first install docker on your vm

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "docker" {
  # Connect to local Docker daemon
  host = "unix:///var/run/docker.sock"
}

# Pull the latest NGINX Docker image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create a container from the NGINX image
resource "docker_container" "my_tf_container" {
  name  = "nginx-container"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
}

# Outputs
output "container_name" {
  description = "Name of the running container"
  value       = docker_container.my_tf_container.name
}

output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.my_tf_container.id
}

output "nginx_url" {
  description = "URL to access the NGINX container"
  value       = "http://localhost:8080"
}

#to run perform 
#tf init
#tf plan
#tf apply