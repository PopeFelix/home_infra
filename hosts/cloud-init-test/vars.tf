# TF vars for spinning up VMs

variable "vm_name" {
    default = "test1"
}

variable "pm_tls_insecure" {
  description = "Set to true to ignore certificate errors"
  type        = bool
  default     = true
}

#Establish which Proxmox host you'd like to spin a VM up on
variable "proxmox_host" {
    default = "thebeast"
}

#Specify which template name you'd like to use
variable "template_name" {
    default = "ubuntu-2404-base"
}
#Establish which nic you would like to utilize
variable "nic_name" {
    default = "vmbr1"
}

# Number of VMs to spin up
variable "vm_count" {
    default = 1
}

# Needed for remote exec
variable "ssh_keys" {
    default = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDjuXJsm20610XQGaGgsagEupVlfzYMorJXrNo1u7Gx took@oscar
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjUArrNxdmrCsL4RHnChkj4r4ZO/aT1ZN2uatKEwO7q aurelia@Aurelias-MBP.scurrilous.foo
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFvTxWlvvqFcVFSfCCTfmC61Z7Dzkuk0t5s8dos4/Bb took@brook
EOF
}

variable "k3s_pve_node" {
  description = "Proxmox node for k3s"
  default = "thebeast"
}


variable "k3s_master_count" {
  description = "Number of k3s masters to create"
  default = 3
}

variable "k3s_worker_count" {
  description = "Number of k3s workers to create"
  default = 3
}

variable "k3s_master_cores" {
  description = "Number of CPU cores for each k3s master"
  default = 8
}

variable "k3s_master_mem" {
  description = "Memory (in KB) to assign to each k3s master"
  default = 8192
}

variable "k3s_worker_cores" {
  description = "Number of CPU cores for each k3s worker"
  default = 8
}

variable "k3s_worker_mem" {
  description = "Memory (in KB) to assign to each k3s worker"
  default = 8192
}

variable "k3s_user" {
  description = "Used by Ansible"
  default = "ansible"
}

variable "k3s_nameserver" {
  default = "192.168.1.9"
}

variable "k3s_nameserver_domain" {
  default = "scurrilous.foo"
}

variable "k3s_gateway" {
  default = "192.168.1.1"
}

variable "k3s_master_ip_addresses" {
  type = list(string)
  default = ["192.168.1.80/24", "192.168.1.81/24", "192.168.1.82/24"]
}

variable "k3s_worker_ip_addresses" {
  type = list(string)
  default = ["192.168.1.90/24", "192.168.1.91/24", "192.168.1.92/24", "192.168.1.93/24"]
}

variable "k3s_node_root_disk_size" {
  default = "32G"
}

variable "k3s_node_data_disk_size" {
  default = "250G"
}

variable "k3s_node_disk_storage" {
  default = "containers-and-vms"
}

variable "k3s_template_name" {
  default = "ubuntu-2404-base"
}

variable "k3s_ssh_key_file" {
  default = "ansible_ed25519.pub"
}

# I don't have VLANs set up
# #Establish the VLAN you'd like to use 
# variable "vlan_num" {
#     default = "place_vlan_number_here"
# }

#Blank var for use by terraform.tfvars
variable "token_secret" {
}

#Blank var for use by terraform.tfvars
variable "token_id" {
}
