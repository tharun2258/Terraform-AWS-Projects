### USERS

resource "aws_iam_user" "iam_user" {
   count = length(var.iam_users)
   name = var.iam_users[count.index]
  
}


Here if we want to create multiple users with single resource block , we can use count function in terraform.

1. count = length(var.iam_users)

Initially will check the number of users will be created by checking variables/ tfvars input given.

With this count , next line will be processed.

2. name = var.iam_users[count.index]

After counting length of users , will iterate the count loop by passing count.index value.

3. Example:

iam_users =["dev-1" , "dev-2" , "dev-3"]

#count = length(var.iam_users) = 3 [Going to create 3 users with indexes 0 ,1 2]

#name = var.iam_users[count.index] --- > name = var.iam_users[0] ---> var.iam_users[0] value is "dev-1".

like these the count loop will iterate for rest of the index input values.







### GROUPS

resource "aws_iam_group" "iam_group" {
    count = length(var.iam_groups)
    name = var.iam_groups[count.index]
  
}

same as mentioned above for users , same functionality will apply for Groups as well.



### USERS_GROUPS_MEMBERSHIP

resource "aws_iam_group_membership" "group_membership" {
    name = "iam_group_membership"
    for_each =  {for idx ,u in var.users : u => var.groups[idx]}
    users = [each.key]
    group = each.value
}


1. Now we want to attach each user to each group , so for this we are creating aws_iam_group_membership resourec block.

2. Initially , will create for_each function which will work as for_loop , so that it will read all the users from the users list.

3. Simplyfying this line and breaking down the logic in sub parts.

 ### for_each =  {for idx ,u in var.users : u => var.groups[idx]}

 for_each function will not accept list(string) which we have for users and groups. so need to those list(string) into maps.

   1. First need to read users list

     for_each = {for u in var.users} ### will work as for loop functionality


   2. for_each = {for u in var.users : u => u} ### here the u will assign the value u itself , just to convert the list(string) to map we did this.

   3. Then to attach each user to each group , we are utilizing index value provided by for_each
   
     ### for_each =  {for idx ,u in var.users : u => var.groups[idx]}

     Here idx variable will hold the value of user index , lets say for example

     Example : dev-1 user index value will 0 , and that 0 index value will apply to group i.e app-a
      


