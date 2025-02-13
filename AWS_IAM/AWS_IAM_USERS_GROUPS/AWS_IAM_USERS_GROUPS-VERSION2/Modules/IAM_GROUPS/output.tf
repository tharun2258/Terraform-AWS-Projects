output "iam_groups" {
    value = { for g in var.iam_groups : g => g }
  
}