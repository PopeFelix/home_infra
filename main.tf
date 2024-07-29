resource "proxmox_vm_qemu" "cloudinit-test" {
    name = "terraform-cloudinit-test1"
    desc = "Testing Terraform and cloud-init"

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
            ide2 {
                cloudinit {
                    storage = "containers-and-vms"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                  size     = "32G"
                  storage  = "containers-and-vms"
                  discard  = true
                  iothread = true
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = var.nic_name
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=dhcp,ip6=dhcp"
    skip_ipv6 = true

    lifecycle {
      ignore_changes = [
        ciuser,
        sshkeys,
        network
      ]
    }
}

