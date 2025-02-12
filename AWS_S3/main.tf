resource "random_id" "random_id" {
    byte_length = 8
  
}


resource "aws_s3_bucket" "s3_bucket" {

    bucket = format("%s-%s" , var.bucket_name , random_id.random_id.hex)
    

    tags = {
      Environment = var.bucket_env
    }
}


resource "aws_s3_object" "s3_object" {
    for_each = fileset("./images" , "**")
    bucket = aws_s3_bucket.s3_bucket.id
    key = each.key
    source = "${"./images"}/${each.value}"
    etag = filemd5("${"./images"}/${each.value}")
    server_side_encryption = "AES256"
    content_type = "image/jpg"

}



resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
    bucket = aws_s3_bucket.s3_bucket.id
    versioning_configuration {
      status = "Enabled"
    }
  
}

resource "aws_s3_bucket" "s3_bucket_logging_bucket" {
    bucket = format("%s-%s" , "test-logging", random_id.random_id.hex)

    tags = {
      Environment = "log-bucket-dev"
    }
  
}

resource "aws_s3_bucket_logging" "s3_bucket_logging" {
    bucket = aws_s3_bucket.s3_bucket.id
    target_bucket = aws_s3_bucket.s3_bucket_logging_bucket.id
    target_prefix = "/logging"
  
}

resource "aws_s3_bucket_public_access_block" "public_access_enable" {
    bucket = aws_s3_bucket.s3_bucket.id


    block_public_acls = false
    restrict_public_buckets = false
    ignore_public_acls = false
    block_public_policy = false
  
}


resource "aws_s3_bucket_policy" "read_access" {
    bucket = aws_s3_bucket.s3_bucket.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [

            {
            "Effect" = "Allow",
            "Principal" = "*",
            "Action" = ["s3:GetObject"]
            "Resource"  = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
            }


        ]
    }
    )

    depends_on = [ aws_s3_bucket_public_access_block.public_access_enable ]
  
}




# resource "aws_kms_key" "kms_key" {

#   description = "kms key for s3 bucket"
#   deletion_window_in_days = 7
# }

# resource "aws_kms_alias" "kms_alias" {
#     name = "alias/aws_km_key_kms_key"
#     target_key_id = aws_kms_key.kms_key.key_id
  
# }













