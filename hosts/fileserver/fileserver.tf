# Transfer the file to the Proxmox Host
# resource "null_resource" "hook_script" {
#   connection {
#     type    = "ssh"
#     user    = "root"
#     private_key = file("~/.ssh/id_ed25519")
#     host    = var.proxmox_host
#   }
#
#   provisioner "file" {
#     source       = "${path.module}/files/hook-script.pl"
#     destination  = "/var/lib/vz/snippets/hook-script.pl"
#   }
# }

resource "proxmox_lxc" "fileserver" {
  target_node  = var.proxmox_host
  hostname     = "fileserver-0"
  ostemplate   = "local:vztmpl/alpine-3.20.3-lxc-ansible-base-20240912.tar.xz"
  password     = var.fileserver_root_password
  unprivileged = true
  ssh_public_keys = var.ssh_keys

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "containers-and-vms"
    size    = "2G"
  }

  mountpoint {
    key = "0"
    slot = 0
    storage = "/shared"
    volume = "/shared"
    mp = "/shared"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.60/24"
    gw 	   = "192.168.1.1"
  }
  nameserver = "192.168.1.9"
  start = true
  onboot = true
  tags = "alpine;terraform;fileserver"
}

# TODO: Provision!!!!
