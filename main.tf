#resource "proxmox_vm_qemu" "cloudinit-test" {
#    name = var.vm_name
#    desc = "Testing Terraform and cloud-init"
#    depends_on = [ null_resource.cloud_init_test1 ]
#    # Node name has to be the same name as within the cluster
#    # this might not include the FQDN
#    target_node = var.proxmox_host
#
#    # The template name to clone this vm from
#    clone = var.template_name
#    # Activate QEMU agent for this VM
#    agent = 1
#
#    os_type = "cloud-init"
#    cores = 2
#    sockets = 1
#    vcpus = 0
#    cpu = "host"
#    memory = 2048
#    scsihw = "virtio-scsi-single"
#
#    # Setup the disk
#    disks {
#        ide {
#            ide2 {
#                cloudinit {
#                    storage = "containers-and-vms"
#                }
#            }
#        }
#        scsi {
#            scsi0 {
#                disk {
#                  size     = "32G"
#                  storage  = "containers-and-vms"
#                  discard  = true
#                  iothread = true
#                }
#            }
#        }
#    }
#
#    network {
#        model = "virtio"
#        bridge = var.nic_name
#	tag = -1
#    }
#
#    # Setup the ip address using cloud-init.
#    boot = "order=scsi0"
#    # Keep in mind to use the CIDR notation for the ip.
#    ipconfig0 = "ip=192.168.1.80/24,gw=192.168.1.1,ip6=dhcp"
#    skip_ipv6 = true
#
#    lifecycle {
#      ignore_changes = [
#        ciuser,
#        sshkeys,
#        network
#      ]
#    }
#    cicustom = "user=local:snippets/cloud_init_test1.yml"
#}

resource "proxmox_vm_qemu" "k3s_master" {
    count = var.k3s_master_count
    name = "k3s-master-${count.index}"
    desc = "K8S Master Node"
    ipconfig0 = "gw=${var.k3s_gateway},ip=${var.k3s_master_ip_addresses[count.index]}"
    target_node = var.k3s_pve_node
    onboot = true
    clone = var.k3s_template_name
    agent = 1
    ciuser = var.k3s_user
    memory = var.k3s_master_mem
    cores = var.k3s_master_cores
    nameserver = var.k3s_nameserver
    os_type = "cloud-init"
    cpu = "host"
    scsihw = "virtio-scsi-single"
    tags="k3s,k8s,ubuntu,k3s_master"

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
                  size     = var.k3s_node_root_disk_size
                  storage  = var.k3s_node_disk_storage
                  discard  = true
                  iothread = true
                }
            }
            scsi1 {
                disk {
                  size     = var.k3s_node_data_disk_size
                  storage  = var.k3s_node_disk_storage
                  discard  = true
                  iothread = true
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = var.nic_name
	      tag = -1
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

resource "proxmox_vm_qemu" "k3s_workers" {
    count = var.k3s_worker_count
    name = "k3s-worker-${count.index}"
    desc = "K8S Master Node"
    ipconfig0 = "gw=${var.k3s_gateway},ip=${var.k3s_worker_ip_addresses[count.index]}"
    target_node = var.k3s_pve_node
    onboot = true
    clone = var.k3s_template_name
    agent = 1
    ciuser = var.k3s_user
    memory = var.k3s_worker_mem
    cores = var.k3s_worker_cores
    nameserver = var.k3s_nameserver
    os_type = "cloud-init"
    cpu = "host"
    scsihw = "virtio-scsi-single"
    sshkeys = file("${path.module}/files/${var.k3s_ssh_key_file}")
    tags="k3s,k8s,ubuntu,k3s_worker"

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
                  size     = var.k3s_node_root_disk_size
                  storage  = var.k3s_node_disk_storage
                  discard  = true
                  iothread = true
                }
            }
            scsi1 {
                disk {
                  size     = var.k3s_node_data_disk_size
                  storage  = var.k3s_node_disk_storage
                  discard  = true
                  iothread = true
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = var.nic_name
	      tag = -1
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

#data "template_file" "k3s" {
#  template = file("./templates/k3s.tpl")
#  vars = {
#    k3s_master_ip = "${join("\n", [for instance in proxmox_vm_qemu.k3s_master : join("", [instance.name, " ansible_host=", instance.default_ipv4_address])])}"
#    k3s_node_ip   = "${join("\n", [for instance in proxmox_vm_qemu.k3s_workers : join("", [instance.name, " ansible_host=", instance.default_ipv4_address])])}"
#  }
#}
#
#resource "local_file" "k3s_file" {
#  content  = data.template_file.k3s.rendered
#  filename = "../../inventory/k3s"
#}
#
#output "Master-IPS" {
#  value = ["${proxmox_vm_qemu.k3s_master.*.default_ipv4_address}"]
#}
#output "worker-IPS" {
#  value = ["${proxmox_vm_qemu.k3s_workers.*.default_ipv4_address}"]
#}


