resource "aws_instance" "EC2" {

    availability_zone = var.availability_zone 
    instance_type = var.instance_type
    ami = var.ami_id
    key_name = var.key_name
    iam_instance_profile = aws_iam_instance_profile.profile.name

    depends_on = [ aws_iam_instance_profile.profile ]
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "demo-iam-role-s3-tharun-test"
  
}

resource "aws_s3_object" "aws_s3_object" {
    bucket = aws_s3_bucket.s3_bucket.id
    key = var.s3_bucket_key_name
    source = var.s3_bucket_source

  
}


resource "aws_iam_role" "ec2_s3_role" {
    name = "ec2_s3_access_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Action" = "sts:AssumeRole"
                "Effect" = "Allow"
                "Principal" = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
  
}


resource "aws_iam_policy" "S3_access_to_Ec2" {

    name = "Ec2_s3_access_policy"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Effect"= "Allow"
                "Action" = ["s3:GetObject" , "s3:PutObject" , "s3:ListBucket"]
                "Resource" = ["arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}","arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"]
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
    role = aws_iam_role.ec2_s3_role.name
    policy_arn = aws_iam_policy.S3_access_to_Ec2.arn
  
}


resource "aws_iam_instance_profile" "profile" {
    name = "ec2_s3_role_access"
    role = aws_iam_role.ec2_s3_role.name
  
}

