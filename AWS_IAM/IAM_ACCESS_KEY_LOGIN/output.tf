output "secret_key" {
    value = aws_iam_access_key.login_access.secret
    sensitive = true 
}

output "access_key_id" {
    value = aws_iam_access_key.login_access.id
    sensitive = true
}