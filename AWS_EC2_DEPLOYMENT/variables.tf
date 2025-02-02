variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "cidr address block range for vpc"
  
}

variable "subnet_cidr_block" {
    type = string
    default = "10.0.0.0/24"
    description = "cidr address block range for subnet"
  
}

variable "instance_region" {
    type = string  
    description = "value of instance region"
}

variable "availability_zone" {
    type = string
    description = "value of availability zone"
  
}

variable "ami" {
    type = string
    description = "value of ami"
  
}

variable "instance_type" {
  type = string
  description = "value of instance type"
}

variable "key_name" {
    type = string
    default = "path/.ssh/id_rsa.pub"
    description = "path of key name created"
}
