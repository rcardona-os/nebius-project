terraform {
  required_providers {
    nebius = {
      source  = "registry.nebius.cloud/nebius-cloud/nebius"
      version = "~> 0.10"
    }
  }
}

provider "nebius" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  token     = var.token
}