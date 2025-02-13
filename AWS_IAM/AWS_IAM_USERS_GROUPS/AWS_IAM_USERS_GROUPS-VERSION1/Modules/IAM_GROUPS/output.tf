output "iam_groups" {
    value = aws_iam_group.iam_group[*].name
  
}