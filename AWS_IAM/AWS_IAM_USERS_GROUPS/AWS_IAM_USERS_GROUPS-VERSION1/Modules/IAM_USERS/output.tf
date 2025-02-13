output "iam_user" {
    value = aws_iam_user.iam_user[*].name
  
}