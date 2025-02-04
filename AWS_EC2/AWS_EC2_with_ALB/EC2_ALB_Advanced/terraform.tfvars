ami_id        = "ami-0c614dee691cbbf37"
instance_type = "t2.micro"

key_name_value = "./ec2-new.pem"
vpc_cidr_block = "10.0.0.0/16"
subnet_cidr_block = {
  "subnet1" = "10.0.1.0/24"
  "subnet2" = "10.0.2.0/24"
}

availability_zone = {
  "az_subnet1" = "us-east-1a"
  "az_subnet2" = "us-east-1b"
}

