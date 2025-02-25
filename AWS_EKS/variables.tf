variable "eks_cluster_name" {
    type = string
    description = "name of the eks cluster"
  
}


variable "eks_node_group_name" {
    type = string
    description = "name of the node group name"
  
}

variable "eks_cluster_tag_name" {
    type = string
    description = "name of the tag of eks cluster"
  
}

variable "eks_node_group_desired_size" {
    type = number
  
}

variable "eks_node_group_min_size" {
    type = number
  
}

variable "eks_node_group_max_size" {
    type = number
  
}


