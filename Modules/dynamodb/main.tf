provider "aws" {
    region = "ap-south-1"
  
}


resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"  # No need to specify read/write capacity
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
