output "user_groups" {
    value = {for  idx ,u in var.users : u => var.groups[idx] }
  
}