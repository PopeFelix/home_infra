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
  pm_api_url = var.api_url
  # References our secrets.tfvars file to plug in our token_id
  pm_api_token_id = var.token_id
  # References our secrets.tfvars to plug in our token_secret 
  pm_api_token_secret = var.token_secret
  # Default to `true` unless you have TLS working within your pve setup 
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "cloudinit-test1" {
    name = "terraform-test-vm"
    desc = "A test for using terraform and cloudinit"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = var.proxmox_host

    # The template name to clone this vm from
    clone = var.template_name

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 2048
    scsihw = "virtio-scsi-single"

    # Setup the disk
    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        virtio {
          virtio0 {
            disk {
              size = "32G"
              storage = "containers-and-vms"
              discard = true
              iothread        = true
              # Can't emulate SSDs in virtio
            }
          }
        }
    }

    network {
      model = "virtio"
      bridge = var.nic_name
    }

    # Setup the ip address using cloud-init.
    boot = "order=virtio0"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=dhcp,ip6=dhcp"
    skip_ipv6 = true
    sshkeys = var.ssh_key
}
resource "proxmox_vm_qemu" "cloudinit-test2" {
    name = "terraform-test-vm-2"
    desc = "A test for using terraform and cloudinit"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = var.proxmox_host

    # The template name to clone this vm from
    clone = var.template_name

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 2048
    scsihw = "virtio-scsi-single"

    # Setup the disk
    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        virtio {
          virtio0 {
            disk {
              size = "32G"
              storage = "containers-and-vms"
              discard = true
              iothread        = true
              # Can't emulate SSDs in virtio
            }
          }
        }
    }

    network {
      model = "virtio"
      bridge = var.nic_name
    }

    # Setup the ip address using cloud-init.
    boot = "order=virtio0"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=dhcp,ip6=dhcp"
    skip_ipv6 = true

    sshkeys = var.ssh_key
}
