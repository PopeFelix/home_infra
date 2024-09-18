terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      #latest version as of 12 Sep 2024
      version = "3.0.1-rc4"
    }
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}

provider "proxmox" {
  # References our vars.tf file to plug in the api_url
  pm_api_url = "https://${var.proxmox_host}:8006/api2/json"
  # Default to `true` unless you have TLS working within your pve setup
  pm_tls_insecure = var.pm_tls_insecure
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
  pm_user = "root@pam"
}
