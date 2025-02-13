output "iam_users" {
    value = module.create_users.iam_user
  
}

output "iam_groups" {
    value = module.create_groups.iam_groups
  
}

output "user_group_membership" {
    value = {for idx, u in var.iam_users : u => var.iam_groups[idx]}
  
}