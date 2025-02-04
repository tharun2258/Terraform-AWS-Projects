locals {
  resource_name = "${var.project_name}-${var.environment}"
}



resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.instance_type 
    key_name = var.key_name

    tags = {
      Name = local.resource_name
    }
  
}