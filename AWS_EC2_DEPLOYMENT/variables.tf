variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
  
}

variable "subnet_cidr_block" {
    type = string
    default = "10.0.0.0/24"
  
}

variable "instance_region" {
    type = string  
}

variable "availability_zone" {
    type = string
  
}

variable "ami" {
    type = string
  
}

variable "instance_type" {
  type = string
}

variable "key_name" {
    type = string
    default = "C:/Users/Yamini K/.ssh/id_rsa.pub"
}
