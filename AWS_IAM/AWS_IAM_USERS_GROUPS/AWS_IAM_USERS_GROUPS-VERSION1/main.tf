module "create_users" {
    source = "./Modules/IAM_USERS"
    iam_users = var.iam_users
  
}

module "create_groups" {
    source = "./Modules/IAM_GROUPS"
    iam_groups =   var.iam_groups
}

module "user_group_membership"{
    source = "./Modules/IAM_USER_GROUPS_MEMBERSHIP"
    users = module.create_users.iam_user
    groups = module.create_groups.iam_groups
}