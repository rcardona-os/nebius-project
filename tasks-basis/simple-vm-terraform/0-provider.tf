terraform {
  required_providers {
    nebius = {
      source  = "terraform-provider.storage.eu-north1.nebius.cloud/nebius/nebius"
      version = ">= 0.3.10"
    }
  }
}

provider "nebius" {
  service_account = {**+/
    public_key_id    = var.public_key_id 
    account_id       = var.account_id
  }
}