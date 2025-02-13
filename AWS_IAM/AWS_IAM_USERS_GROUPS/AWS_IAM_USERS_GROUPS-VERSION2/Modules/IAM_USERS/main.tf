resource "aws_iam_user" "iam_user" {
    for_each = var.iam_users
    name = each.key
   
  
}
