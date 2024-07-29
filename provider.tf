terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      #latest version as of 16 July 2024
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  # References our vars.tf file to plug in the api_url 
  pm_api_url = "https://${var.proxmox_host}:8006/api2/json"
  # References our secrets.tfvars file to plug in our token_id
  pm_api_token_id = var.token_id
  # References our secrets.tfvars to plug in our token_secret 
  pm_api_token_secret = var.token_secret
  # Default to `true` unless you have TLS working within your pve setup 
  pm_tls_insecure = var.pm_tls_insecure
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}


