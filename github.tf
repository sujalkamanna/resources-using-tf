# create a token first in github 
# Go to github -> settings -> Developer Settings -> Personal access token classic -> generate new token classic

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0.0"
    }
  }
}

provider "github" {
  # Use the token from a variable or environment variable
  token = var.github_token
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

# Create a GitHub repository
resource "github_repository" "my_github_repo_using_tf" {
  name        = "my-tf-repo"
  description = "Created from Terraform"
  visibility  = "public"   # "private" also supported
}

#to run perform 
#tf init
#tf plan
#tf apply