variable "vpc_cidr_block" {
  type = string

}

variable "subnet_cidr_block" {
  type = map(string)

}



variable "availability_zone" {
  type = map(string)

}


variable "ami_id" {
  type = string

}

variable "instance_type" {
  type = string

}

variable "key_name_value" {
  type = string
}

