resource "aws_iam_group" "iam_group" {
    count = length(var.iam_groups)
    name = var.iam_groups[count.index]
  
}