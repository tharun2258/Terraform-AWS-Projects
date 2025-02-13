resource "aws_iam_user" "iam_user" {
    count = length(var.iam_users)
   name = var.iam_users[count.index]
  
}
