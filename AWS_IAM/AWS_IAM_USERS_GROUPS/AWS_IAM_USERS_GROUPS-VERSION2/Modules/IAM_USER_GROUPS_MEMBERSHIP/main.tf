resource "aws_iam_group_membership" "group_membership" {
    name = "iam_group_membership"
    for_each = var.users
    users = [each.key]
    group = each.value

    
    
}