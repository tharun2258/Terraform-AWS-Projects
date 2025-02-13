resource "aws_iam_group_membership" "group_membership" {
    name = "iam_group_membership"
    for_each =  {for idx ,u in var.users : u => var.groups[idx]}
    users = [each.key]
    group = each.value
}