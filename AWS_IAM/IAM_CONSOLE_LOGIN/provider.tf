terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~> 5.2"
    }
  }
}

provider "aws" {
    region = var.provider_region
  
}