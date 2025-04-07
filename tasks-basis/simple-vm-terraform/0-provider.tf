terraform {
  required_providers {
    nebius = {
      source  = "terraform-provider.storage.eu-north1.nebius.cloud/nebius/nebius"
      version = ">= 0.3.10"
    }
  }
}

provider "nebius" {
  service_account = {
    private_key_file_env = var.private_key_file_env
    public_key_id_env    = var.public_key_id_env 
    account_id_env       = var.account_id_env
  }
}