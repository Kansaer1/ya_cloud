terraform {
 required_providers {
 yandex = {
 source = "yandex-cloud/yandex"
 }
 }
 required_version = ">= 0.13"
}

provider "yandex" {
 token = var.token
 cloud_id = var.cloud_id
 folder_id = var.folder_id
}

resource "yandex_compute_disk" "boot-disk" {
 name = "boot-disk"
 type = "network-hdd"
 zone = "ru-central1-a"
 size = "20"
 image_id = "fd85bll745cg76f707mq"
}

resource "yandex_compute_instance" "linux-vm" {
  count = var.copies
  name = "linux-vm-${count.index+1}"
  platform_id = "standard-v3"
  zone = "ru-central1-a"
 resources {
  cores = var.vm_cpu
  memory = var.vm_memory
 }
 boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = "20"
      type     = "network-hdd"
    }
  }
 network_interface {
 subnet_id = yandex_vpc_subnet.subnet-1.id
 nat = true
 }
metadata = {
        user-data = "${file("meta.txt")}"
    }
}

resource "yandex_vpc_network" "network-1" {
 name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
 name = "subnet1"
 zone = "ru-central1-a"
 v4_cidr_blocks = ["192.168.10.0/24"]
 network_id = yandex_vpc_network.network-1.id
}
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

output "vm_nat_ip" {
  value = { for k, v in  yandex_compute_instance.linux-vm : k => v.network_interface.0.nat_ip_address}
} 