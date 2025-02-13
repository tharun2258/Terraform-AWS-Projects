output "iam_users_group_membership" {
  value = { for user, group in var.users : user => group }
}
