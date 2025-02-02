resource "aws_s3_bucket" "example" {
    bucket = var.bucket_name

    tags = {
      environment = var.bucket_env
    }
  
}


# resource "aws_s3_bucket" "example1" {
#   bucket = "demo-terraform-tharun"
  
# }



