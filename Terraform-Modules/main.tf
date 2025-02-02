provider "aws" {
  region = "ap-south-1"

}

module "ec2_instance" {
  source        = "./Modules/Ec2_instances"
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  environment = var.environment
  project_name = var.project_name
}


module "s3_bucket" {
  source      = "./Modules/s3_Buckets"
  bucket_name = var.bucket_name
  bucket_env  = var.bucket_env

}


module "dynamodb_table" {
  source = "./Modules/dynamodb"
  
}

