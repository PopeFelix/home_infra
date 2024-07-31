# Source the Cloud Init Config file
data "template_file" "cloud_init_test1" {
  template  = "${file("${path.module}/files/test1.cloud_config")}"

  vars = {
    ssh_key = file("~/.ssh/id_ed25519.pub")
    hostname = var.vm_name
    domain = "scurrilous.foo"
  }
}

# Create a local copy of the file, to transfer to Proxmox
resource "local_file" "cloud_init_test1" {
  content   = data.template_file.cloud_init_test1.rendered
  filename  = "${path.module}/files/user_data_cloud_init_test1.cfg"
}

# Transfer the file to the Proxmox Host
resource "null_resource" "cloud_init_test1" {
  connection {
    type    = "ssh"
    user    = "root"
    private_key = file("~/.ssh/id_ed25519")
    host    = var.proxmox_host
  }

  provisioner "file" {
    source       = local_file.cloud_init_test1.filename
    destination  = "/var/lib/vz/snippets/cloud_init_test1.yml"
  }
}

