resource "aws_eks_node_group" "node_group" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    node_group_name  = var.eks_node_group_name
    node_role_arn = aws_iam_role.Nodegrouprole.arn

    subnet_ids = ["subnet ids of 2 different AZ's"]

    scaling_config {
      desired_size = var.eks_node_group_desired_size
      min_size = var.eks_node_group_min_size
      max_size = var.eks_node_group_max_size
    }
  
}