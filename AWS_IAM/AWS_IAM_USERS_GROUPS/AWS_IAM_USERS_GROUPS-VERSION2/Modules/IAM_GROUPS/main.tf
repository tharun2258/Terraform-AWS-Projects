resource "aws_iam_group" "iam_group" {
    for_each = toset(var.iam_groups)
    name = each.value
  
}