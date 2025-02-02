variable "ami" {
  description = "ami value of the ec2 instance"
  type = string
}

variable "instance_type" {
    description = "instance type of the ec2 instance"
    type = string
  
}

variable "key_name" {
    description = "key name of the ec2 instance"
    type = string
  
}

variable "environment" {

  type = string
  
}

variable "project_name" {

  type = string
  
}

