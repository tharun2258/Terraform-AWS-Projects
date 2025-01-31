terraform {
  backend "s3" {
    bucket = "demo-terraform-tharun"
    region = "ap-south-1"
    key= "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock-table"
    
  }
}