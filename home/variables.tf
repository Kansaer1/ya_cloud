variable "token" {
 type = string
 description = "y0__xDf49XsARjB3RMggpHynRMwipGFjgi7Zeb2BuhQrdyMsvMRl3prixdcTA" 
}

variable "cloud_id" {
 type = string
 description = "b1gfqe1fd9qoq467gd5n"
}

variable "folder_id" {
 type = string
 description = "b1gvplk4kr4vsmm6dim4"
}


variable "vm_name_prefix" {
  description = "Префикс имени ВМ"
  type = string
  default = "test-vm"
}

variable "vm_cpu" {
  description = "Количество CPU"
  type = number
  default = 2
}

variable "vm_memory" {
  description = "Память в МБ"
  type = number
  default = 2
}
variable "copies" {
  description = "кол-во вм"
  type = number
  default = 1
}

variable "base_image_id" {
 type = string
 default = "правильный_id_образа"
}