# Source the Cloud Init Config file
data "template_file" "cloud_init_cfg" {
  template  = "${file("${path.module}/files/cloud_config")}"

  vars = {
    ssh_key = file("~/.ssh/id_ed25519.pub")
    hostname = var.vm_name
    domain = "scurrilous.foo"
  }
}

# Create a local copy of the file, to transfer to Proxmox
resource "local_file" "cloud_init_cfg" {
  content   = data.template_file.cloud_init_cfg.rendered
  filename  = "${path.module}/files/${var.vm_name}-user_data_cloud_init.cfg"
}

# Transfer the file to the Proxmox Host
resource "null_resource" "cloud_init_cfg" {
  connection {
    type    = "ssh"
    user    = "root"
    private_key = file("~/.ssh/id_ed25519")
    host    = var.proxmox_host
  }

  provisioner "file" {
    source       = local_file.cloud_init_cfg.filename
    destination  = "/var/lib/vz/snippets/${var.vm_name}-cloud_init.yml"
  }
}

