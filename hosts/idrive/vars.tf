# TF vars for spinning up VMs

variable "host_count" {
  default = 1
}

variable "gateway" {
  default = "192.168.1.1"
}

variable "ip_addresses"  {
  type = list(string)
  default = ["192.168.1.11/24"]
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

variable "username" {
  default = "aurelia"
}

variable "memory" {
  default = 32768
}

variable "cores" {
  default = 24
}

variable "nameserver" {
  default = "192.168.1.9"
}

variable "disk_size" {
  default = "128G"
}

variable "storage_location" {
  default = "containers-and-vms"
}

variable "vlan_num" {
  default = "-1"
}

#Blank vars for use by terraform.tfvars
variable "token_secret" {
}

variable "token_id" {
}
