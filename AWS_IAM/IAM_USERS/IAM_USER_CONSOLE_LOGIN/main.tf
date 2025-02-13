resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
}

resource "aws_iam_user" "create_user" {
    name = "devops-1"
  
}

resource "aws_iam_user_login_profile" "login_profile" {
    user= aws_iam_user.create_user.name
    password_reset_required = false
    password_length = 12
    
  
}

resource "aws_iam_policy" "s3_read_write_access" {
    name = "aws-s3-read-write-access"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Effect" = "Allow"
                "Action" = [
                    "s3:GetObject",
                    "s3:PutObject"
                ]
                "Resource" = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
            },
            {
                "Effect" = "Allow"
                "Action" = [
                    "s3:ListBucket" , "s3:ListAllMyBuckets"
                ]
                "Resource" = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}"
            },
           

        ]
    })
}



resource "aws_iam_policy_attachment" "policy_attach" {
    name = "aws-s3-read-write-access"
    users = [aws_iam_user.create_user.name]
    policy_arn = aws_iam_policy.s3_read_write_access.arn
  
}