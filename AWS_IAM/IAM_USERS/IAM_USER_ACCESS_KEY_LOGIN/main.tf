# TRY APPLYING IAM ROLE POLICY TO S3 BUCKET


resource "aws_s3_bucket" "s3_bucket" {
    bucket = var.s3_bucket_name
  
}



resource "aws_iam_policy" "s3_bucket_read_write_access" {
    name = "s3-read-write-policy"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Effect" = "Allow"
                "Action" = ["s3:GetObject", "s3:PutObject" ]
                "Resource" = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
            }
        ]
    })
  
}


resource "aws_iam_user" "iam_user" {
    name = "devops-team"
  
}

resource "aws_iam_access_key" "login_access" {
    user = aws_iam_user.iam_user.name
  
}


resource "aws_iam_policy_attachment" "policy_attach" {
    name = "s3-bucket-attach-policy"
    users = [aws_iam_user.iam_user.name]
    policy_arn = aws_iam_policy.s3_bucket_read_write_access.arn
  
}