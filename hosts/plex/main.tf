terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      #latest version as of 16 July 2024
      version = "3.0.1-rc3"
    }
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://${var.proxmox_host}:8006/api2/json"
  pm_api_token_id = var.token_id
  pm_api_token_secret = var.token_secret
  pm_tls_insecure = var.pm_tls_insecure
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

resource "proxmox_vm_qemu" "plex" {
    count = var.host_count
    name = "plex-${count.index}"
    desc = "Plex Media Server"
    ipconfig0 = "gw=${var.gateway},ip=${var.ip_addresses[count.index]}"
    target_node = var.proxmox_host
    onboot = true
    clone = var.template_name
    agent = 1
    ciuser = var.username
    memory = var.memory
    cores = var.cores
    nameserver = var.nameserver
    os_type = "cloud-init"
    cpu = "host"
    scsihw = "virtio-scsi-single"
    tags="debian,plex"

    # Setup the disk
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = var.storage_location
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                  size     = var.disk_size
                  storage  = var.storage_location
                  discard  = true
                  iothread = true
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = var.nic_name
	      tag = var.vlan_num
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0"
    skip_ipv6 = true

    lifecycle {
      ignore_changes = [
        disks,
        target_node,
        sshkeys,
        network
      ]
    }
}
